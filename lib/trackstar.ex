defmodule Trackstar do
  require IEx

  @chunk 10000

  def parse(path) do
    coordinates = run(path)
    GeoJSON.formatted(coordinates)
  end

  def run(path) do
    {:ok, handle} = File.open(path, [:binary])

    position = 0
    c_state = {handle, position, @chunk}

    :erlsom.parse_sax("",
                      nil,
                      &sax_event_handler/2,
                      [{:continuation_function, &continue_file/2, c_state}])
                      
                      :ok = File.close(handle)
  end

  def continue_file(tail, {handle, offset, chunk}) do
    case :file.pread(handle, offset, chunk) do
      {:ok, data} ->
        {<<tail :: binary, data :: binary>>, {handle, offset + chunk, chunk}}
      :eof ->
        {tail, {handle, offset, chunk}}
    end
  end

  def sax_event_handler(:startDocument, state), do: %Coordinates{}

  def sax_event_handler({:startElement, _, 'trkpt', _, attributes}, state) do
    lnglat = lnglat(attributes)
    %{state | coordinates: state.coordinates ++ [ lnglat ]}
  end

  def sax_event_handler(:endDocument, state), do: state
  def sax_event_handler(_, state), do: state

  defp lnglat(attributes) do
    [pull_lng(attributes), pull_lat(attributes)]
    |> parse_lnglat
  end

  def pull_lat({_, 'lat', _, _, lat}), do: lat
  def pull_lat({_, 'lon', _, _, _lon}), do: nil
  def pull_lat(attributes) when is_list(attributes) do
    attributes |> Enum.map(&(pull_lat(&1)))
  end

  def pull_lng({_, 'lon', _, _, lon}), do: lon
  def pull_lng({_, 'lat', _, _, _lat}), do: nil
  def pull_lng(attributes) when is_list(attributes) do
    attributes |> Enum.map(&(pull_lng(&1)))
  end

  def parse_lnglat([[lng, nil], [nil, lat]]), do: [lng, lat]
end

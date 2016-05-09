defmodule Trackstar do
  import SAXEventHandlers

  @chunk 10000

  def to_linestring(path) do
    case run(path) do
      {:ok, coords, _} -> GeoJSON.to_file(coords)
      {_, error, _}    -> raise(error)
    end
  end

  def run(path) do
    {:ok, handle} = File.open(path, [:binary])

    position = 0
    c_state = {handle, position, @chunk}

    results = :erlsom.parse_sax("",
                      nil,
                      &event_handler/2,
                      [{:continuation_function, &continue_file/2, c_state}])

    :ok = File.close(handle)
    results
  end

  defp continue_file(tail, {handle, offset, chunk}) do
    case :file.pread(handle, offset, chunk) do
      {:ok, data} ->
        {<<tail :: binary, data :: binary>>, {handle, offset + chunk, chunk}}
      :eof ->
        {tail, {handle, offset, chunk}}
    end
  end
end

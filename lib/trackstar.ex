defmodule Trackstar do
  defmodule State do
    defstruct name: "", trkpt: "", ele: "", time: "", element_acc: ""
  end

  @chunk 10000

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
        {<<tail :: binary, data::binary>>, {handle, offset + chunk, chunk}}
      :eof ->
        {tail, {handle, offset, chunk}}
    end
  end

  def sax_event_handler({:startElement, _, 'name', _, _}, _state) do
    %State{}
  end

  def sax_event_handler({:startElement, _, 'ele', _, _}, _state) do
    %State{}
  end

  def sax_event_handler({:startElement, _, 'trkpt', _, _}, _state) do
    %State{}
  end

  def sax_event_handler({:characters, value}, %State{element_acc: element_acc} = state) do
    %{state | element_acc: element_acc <> to_string(value)}
  end

  def sax_event_handler({:endElement, _, 'name', _}, state) do
    %{state | name: state.element_acc}
  end

  def sax_event_handler({:endElement, _, 'ele', _}, state) do
    state = %{state | ele: state.element_acc}
    IO.puts "Elevation (m): #{state.ele}"
    state
  end

  def sax_event_handler({:endElement, _, 'trkpt', _}, state) do
    %{state | trkpt: state.element_acc}
    state
  end

  def sax_event_handler(:endDocument, state), do: state
  def sax_event_handler(_, state), do: state
end

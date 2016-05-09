defmodule SAXEventHandlers do
  import LngLat

  def event_handler(:startDocument, _state), do: %Coordinates{}

  def event_handler({:startElement, _, 'trkpt', _, attributes}, state) do
    lnglat = lnglat(attributes)
    %{state | coordinates: state.coordinates ++ [ lnglat ]}
  end

  def event_handler(:endDocument, state), do: state
  def event_handler(_, state), do: state
end

defmodule GeoJSON do
  def formatted(coordinates_struct) do
    %{
      "type": "LineString",
      "coordinates": coordinates_struct.coordinates
    }
  end
end

defmodule Coordinates do
  defstruct element_acc: "", coordinates: []
end

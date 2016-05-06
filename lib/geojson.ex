defmodule GeoJSON do
  require IEx

  @derive [Poison.Encoder]

  def formatted_linestring(coords) do
    Poison.encode!(formatted(coords))
  end

  def formatted(coordinates_struct) do
    %{
      "type": "LineString",
      "coordinates": fix_dumb_charlist(coordinates_struct.coordinates)
    }
  end

  def fix_dumb_charlist(coordinates_charlist) do
    coordinates_charlist
    |> Enum.map(&(fix_dumb_pair(&1)))
  end

  def fix_dumb_pair(pair) do
    pair
    |> Enum.map(&(List.to_float(&1)))
  end
end

defmodule Coordinates do
  defstruct element_acc: "", coordinates: []
end

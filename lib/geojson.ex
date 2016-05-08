defmodule GeoJSON do
  @derive [Poison.Encoder]

  def to_file(coords_struct, filename \\ "export_geojson") do
    json = coords_struct |> to_geojson
    File.write("export/#{filename}.json", json, [:binary])
  end

  def to_geojson(coords_struct) do
    coords_struct
    |> format_linestring
    |> Poison.encode!
  end

  def format_linestring(coords_struct) do
    %{
      "type": "LineString",
      "coordinates": fix_dumb_charlist(coords_struct.coordinates)
    }
  end

  defp fix_dumb_charlist(coordinates_charlist) do
    coordinates_charlist
    |> Enum.map(&(fix_dumb_pair(&1)))
  end

  defp fix_dumb_pair(pair) do
    pair
    |> Enum.map(&(List.to_float(&1)))
  end
end

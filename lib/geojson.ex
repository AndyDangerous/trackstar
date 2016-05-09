defmodule GeoJSON do
  @derive [Poison.Encoder]

  def to_file(coords_struct, filename \\ "export_geojson") do
    json = coords_struct |> to_geojson(&format_linestring/1)
    File.write("export/#{filename}.json", json, [:binary])
  end

  def to_geojson(coords_struct, format_fun) do
    format_fun.(coords_struct)
    |> Poison.encode!
  end

  def format_linestring(coords_struct) do
    %{
      "type": "LineString",
      "coordinates": coords_struct.coordinates
    }
  end
end

defmodule GeoJSONTest do
  use ExUnit.Case
  doctest GeoJSON

  def coords do
    %Coordinates{coordinates: [
        ['-106.3007900', '39.3604100'], 
        ['-106.3007500', '39.3604070'], 
        ['-106.3007050', '39.3604070'], 
        ['-106.3006830', '39.3604070'], 
        ['-106.3004510', '39.3604140']
      ]}
  end

  test "format_linestring formats coordinates struct" do
    expected_struct = %{coordinates: 
      [[-106.300790, 39.360410], 
       [-106.300750, 39.360407], 
       [-106.300705, 39.360407], 
       [-106.300683, 39.360407], 
       [-106.300451, 39.360414]], 
      type: "LineString"}

    assert GeoJSON.format_linestring(coords) == expected_struct
  end

  test "to_geojson exports valid GeoJSON" do
    geojson = GeoJSON.to_geojson(coords)

    assert geojson == "{\"type\":\"LineString\",\"coordinates\":[[-106.30079,39.36041],[-106.30075,39.360407],[-106.300705,39.360407],[-106.300683,39.360407],[-106.300451,39.360414]]}"
  end
end


defmodule LngLatTest do
  use ExUnit.Case
  doctest LngLat

  test "lnglat returns list of lng, lat" do
    attributes = [
      {:attribute, 'lon', [], [], '-106.3007900'},
      {:attribute, 'lat', [], [], '39.3604100'}]

    assert LngLat.lnglat(attributes) == [-106.30079, 39.36041]
  end
end

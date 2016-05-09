# Trackstar [![Build Status](https://travis-ci.org/AndyDangerous/trackstar.svg?branch=master)](https://travis-ci.org/AndyDangerous/trackstar)

Trackstar is a GPX parser. Specify the path to a GPX file and it will output a GeoJSON of the track as a LineString. It currently works with Strava-exported GPX files. 

#### How to use it:

`Trackstar.to_linestring("path/to/my_track.gpx")` will convert your GPX file to GeoJSON linestring. You can find your new file in `export/my_track.json`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add trackstar to your list of dependencies in `mix.exs`:

        def deps do
          [{:trackstar, "~> 0.0.1"}]
        end

  2. Ensure trackstar is started before your application:

        def application do
          [applications: [:trackstar]]
        end


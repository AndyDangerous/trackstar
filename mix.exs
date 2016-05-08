defmodule Trackstar.Mixfile do
  use Mix.Project

  def project do
    [app: :trackstar,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:erlsom, "~> 1.4"},
    {:poison, "~> 2.0"}]
  end

  defp description do
    """
    Trackstar is a GPX parser. Specify the path to a GPX file and it will output a GeoJSON of the track as a LineString. It currently works with Strava-exported GPX files.
    """
  end

  defp package do
    [# These are the default files included in the package
     maintainers: ["Andy Mention"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/andydangerous/trackstar"} ]
  end
end

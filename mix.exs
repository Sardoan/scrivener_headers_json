defmodule Scrivener.Headers.Mixfile do
  use Mix.Project

  @version "0.0.1"

  def project do
    [app: :scrivener_headers_json,
     version: @version,
     elixir: "~> 1.4",
     package: package(),
     description: """
     Helpers for paginating API responses with Scrivener and HTTP headers, changes link from string to json
     """,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def package do
    [maintainers: ["Sardoan"],
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/doomspork/scrivener_headers"}]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:plug, "~> 1.3", optional: true},
      {:scrivener, "~> 2.3"},

      {:credo, "~> 0.8.6", only: [:dev, :test]},
      {:ex_doc, "~> 0.15", only: :dev},
      {:poison, "~> 2.2.0"}
    ]

  end
end

defmodule AdventOfCode.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AdventOfCode.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:aja, "~> 0.6.5"}
    ]
  end
end

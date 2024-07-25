defmodule AdventOfCode.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [{Task.Supervisor, name: AdventOfCode}]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def run() do
    tasks = [{"Day 8", "Treetop Tree House"},
	     {"Day 9", "Rope Bridge"},
	     {"Day 10", "Cathode-Ray Tube"}]

    tasks
    |> Enum.map(fn {day, name} ->
      Task.Supervisor.async(AdventOfCode, fn ->
        mod = Module.concat(["Elixir", "AdventOfCode", String.replace(day, " ", "")])
        one = apply(mod, :part_one, [])
        two = apply(mod, :part_two, [])
	IO.puts(~s/--- #{day}: #{name} ---\n#{one}\n#{two}/)
      end)
    end)
    |> Enum.each(fn task -> Task.await(task) end)
  end
end

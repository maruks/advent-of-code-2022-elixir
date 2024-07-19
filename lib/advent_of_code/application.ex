defmodule AdventOfCode.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [{Task.Supervisor, name: AdventOfCode}]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def run() do
    tasks = [{"Day 8", "Treetop Tree House"}]

    tasks
    |> Enum.map(fn {day, name} ->
      Task.Supervisor.async(AdventOfCode, fn ->
        IO.puts(~s/--- #{day}: #{name} ---/)
        mod = Module.concat(["Elixir", "AdventOfCode", String.replace(day, " ", "")])
        IO.puts(apply(mod, :part_one, []))
        IO.puts(apply(mod, :part_two, []))
      end)
    end)
    |> Enum.each(fn task -> Task.await(task) end)
  end
end

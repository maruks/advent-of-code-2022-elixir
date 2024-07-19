defmodule AdventOfCode.Application do
  use Application
  require Logger

  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode.hello()
      :world

  """
  def hello do
    :world
  end

  def start(_type, _args) do
    children = [{Task.Supervisor, name: Playground}]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp hello(s) do
    Logger.info("foo")
    s |> String.reverse() |> IO.puts()
  end

  def main() do
    # {:ok, _} = Application.ensure_all_started(:playground)
    task = Task.Supervisor.async(Playground, fn -> hello("Hello world!") end)
    Logger.error("test")
    Task.await(task)
  end
end

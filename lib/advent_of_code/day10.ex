defmodule AdventOfCode.Day10 do
  import AdventOfCode.Util

  def read_input() do
    resource_path("day-10-input.txt")
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn s ->
      case String.split(s, " ") do
	[instr] -> {String.to_existing_atom(instr), 0}
	[instr, data] ->
	  {n, ""} = Integer.parse(data)
	  {String.to_existing_atom(instr), n}
      end
    end)
  end

  def sum_of_signal_strengths([instruction | _] = instructions, cycles) do
    n = case instruction do
      {:noop, _} -> 1
      {:addx, _} -> 2
    end
    sum_of_signal_strengths(instructions, cycles, 1, 1, n, 0)
  end
  def sum_of_signal_strengths(_, [], _ , _, _ , result), do: result
  def sum_of_signal_strengths([instruction | instructions_tail], cycles, x , counter, 0 , result) do
    next_x = case instruction do
      {:noop, _} -> x
      {:addx, a} -> a + x
    end
    next_n = case hd(instructions_tail) do
      {:noop, _} -> 1
      {:addx, _} -> 2
    end
    sum_of_signal_strengths(instructions_tail, cycles, next_x , counter, next_n , result)
  end
  def sum_of_signal_strengths(instructions, [cycle | cycles_tail], x , counter, n , result) when cycle == counter do
    sum_of_signal_strengths(instructions, cycles_tail, x , counter, n , cycle * x + result)
  end
  def sum_of_signal_strengths(instructions, cycles, x , counter, n , result) do
    sum_of_signal_strengths(instructions, cycles, x , 1 + counter, n - 1, result)
  end

  def sum_of_all_signal_strengths(input) do
    sum_of_signal_strengths(input, [20, 60, 100, 140, 180, 220])
  end

  def part_one() do
    read_input()
    |> sum_of_all_signal_strengths()
  end

  def part_two() do
  end
end

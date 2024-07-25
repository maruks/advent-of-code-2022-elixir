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
    sum_of_signal_strengths(input, [20 | Enum.to_list 60..220//40])
  end

  def part_one() do
    read_input()
    |> sum_of_all_signal_strengths()
  end

  defp pixel(position, x) when x - 1 <= position and x + 1 >= position, do: ?#
  defp pixel(_, _), do: ?.

  defp draw_pixel(x, counter) do
    position = rem (counter - 1), 40
    pixel(x, position)
  end

  def draw([instruction | _] = instructions) do
    n = case instruction do
      {:noop, _} -> 1
      {:addx, _} -> 2
    end
    draw(instructions, 1, 1, n, ~c"")
  end
  def draw(_, _ , counter, _ , result) when counter > 240, do: result |> Enum.reverse() |> Enum.chunk_every(40) |> Enum.join("\n") |> to_string()
  def draw([instruction | instructions_tail], x , counter, 0 , result) do
    next_x = case instruction do
      {:noop, _} -> x
      {:addx, a} -> a + x
    end
    next_n = case hd(instructions_tail) do
      {:noop, _} -> 1
      {:addx, _} -> 2
    end
    draw(instructions_tail, next_x , counter, next_n , result)
  end
  def draw(instructions, x , counter, n , result) do
    draw(instructions, x , 1 + counter, n - 1, [ draw_pixel(x, counter) | result])
  end

  def part_two() do
    read_input()
    |> draw()
  end
end

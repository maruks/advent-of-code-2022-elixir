defmodule AdventOfCode.Day9 do
  import AdventOfCode.Util

  defp read_input() do
    resource_path("day-9-input.txt")
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn s ->
      [dir, dist] = String.split(s, " ")
      {n, ""} = Integer.parse(dist)
      {String.to_existing_atom(dir), n} end)
  end

  defp head_positions(xs), do: head_positions(xs, [{0, 0}])
  defp head_positions([], result), do: Enum.reverse(result)
  defp head_positions([{_d, 0} | tail], result), do: head_positions(tail, result)
  defp head_positions([{d, n} | tail], [head | _] = result), do: head_positions([{d, n - 1} | tail], [move_head(d, head) | result])

  defp move_head(:U, {x, y}), do: {x, y - 1}
  defp move_head(:D, {x, y}), do: {x, y + 1}
  defp move_head(:L, {x, y}), do: {x - 1, y}
  defp move_head(:R, {x, y}), do: {x + 1, y}

  defp delta(x, y) when x < y, do: 1
  defp delta(x, y) when x > y, do: -1
  defp delta(_, _), do: 0

  defp move_tail({xh, yh}, {xt, yt}=t) when abs(xh - xt) <= 1 and abs(yh - yt) <= 1, do: t
  defp move_tail({xh, yh}, {xt, yt}), do: {xt + delta(xt, xh), yt + delta(yt, yh)}

  def tail_positions(head_positions) do
    head_positions
    |> Enum.reduce([{0, 0}], fn head, acc -> [move_tail(head, hd(acc)) | acc]  end)
  end

  def unique_tail_positions(input) do
    input
    |> head_positions()
    |> tail_positions()
    |> Enum.uniq
    |> Enum.count
  end

  def part_one() do
    read_input()
    |> unique_tail_positions
  end

  def tail_positions_with_knots(head_positions), do: tail_positions_with_knots(head_positions, List.duplicate({0,0}, 9), [])
  def tail_positions_with_knots([], _, result), do: result
  def tail_positions_with_knots([head | tail], knots, result) do
    next_knots = Enum.reduce(knots, [head], fn k, ks -> [move_tail(hd(ks), k) | ks] end)
    tail_positions_with_knots(tail, next_knots |> Enum.reverse() |> tl() , [hd(next_knots) | result])
  end

  def unique_tail_positions_with_knots(input) do
    input
    |> head_positions()
    |> tail_positions_with_knots()
    |> Enum.uniq
    |> Enum.count
  end

  def part_two() do
    read_input()
    |> unique_tail_positions_with_knots
  end
end

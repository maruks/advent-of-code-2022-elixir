defmodule AdventOfCode.Day8 do
  import AdventOfCode.Util
  import Aja
  alias Aja.Vector, as: Vector

  defp read_input() do
    resource_path("day-8-input.txt")
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn s -> {String.to_charlist(s), String.length(s)} end)
    |> Enum.reduce({Vector.new(), 0, 0}, fn {xs, len}, {xs_acc, height, _} -> {xs_acc +++ xs, height + 1, len} end)
  end

  def visible_trees(input, coords) do
    Enum.reduce(coords, {-1, []}, fn {x, y}, {highest, visible} ->
      elem = get_element(input, x, y)
      {max(elem, highest), if elem > highest do [{x, y} | visible] else visible end}
    end)
    |> elem(1)
  end

  def get_element({vec, height, width}, x, y) when x < width and y < height, do: vec[y * width + x]

  def count_visible_trees({_vec, height, width} = input) do
    left_to_right = for y <- 0..(height - 1), do: for(x <- 0..(width - 1), do: {x, y})
    top_to_bottom = for x <- 0..(width - 1), do: for(y <- 0..(height - 1), do: {x, y})

    (left_to_right ++ Enum.map(left_to_right, &Enum.reverse/1) ++ top_to_bottom ++ Enum.map(top_to_bottom, &Enum.reverse/1))
    |> Enum.flat_map(&visible_trees(input, &1))
    |> Enum.uniq()
    |> Enum.count()
  end

  def part_one() do
    read_input()
    |> count_visible_trees()
  end

  def viewing_distance({_vec, height, width} = input, x, y, dx, dy, max_height, result \\ 0) do
    cond do
      x >= width || y >= height || x < 0 || y < 0 ->
        result

      max_height <= get_element(input, x, y) ->
        result + 1

      true ->
        viewing_distance(input, x + dx, y + dy, dx, dy, max_height, result + 1)
    end
  end

  def scenic_score(input, {x, y}) do
    dxdy = for y <- [-1, 0, 1], x <- [-1, 0, 1], abs(y + x) == 1, do: {x, y}

    dxdy
    |> Enum.map(fn {dx, dy} ->
      viewing_distance(input, x + dx, y + dy, dx, dy, get_element(input, x, y))
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def max_scenic_score({_vec, height, width} = input) do
    coords = for y <- 1..(height - 2), x <- 1..(width - 2), do: {x, y}

    coords
    |> Enum.reduce(-1, fn xy, max_score -> max(max_score, scenic_score(input, xy)) end)
  end

  def part_two() do
    read_input()
    |> max_scenic_score()
  end
end

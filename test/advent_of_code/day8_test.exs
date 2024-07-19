defmodule AdventOfCode.Day8Test do
  use ExUnit.Case

  import AdventOfCode.Day8
  import Aja

  defp input(),
    do: {vec([3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0]), 5, 5}

  test "visible trees" do
    assert count_visible_trees(input()) == 21
  end

  test "viewing distance" do
    assert viewing_distance(input(), 3, 3, 1, 0, get_element(input(), 2, 3)) == 2
    assert viewing_distance(input(), 1, 3, -1, 0, get_element(input(), 2, 3)) == 2
    assert viewing_distance(input(), 2, 4, 0, 1, get_element(input(), 2, 3)) == 1
    assert viewing_distance(input(), 2, 2, 0, -1, get_element(input(), 2, 3)) == 2
  end

  test "scenic score" do
    assert scenic_score(input(), {2, 3}) == 8
  end

  test "max scenic score" do
    assert max_scenic_score(input()) == 8
  end

  test "part one" do
    assert part_one() == 1711
  end

  test "part two" do
    assert part_two() == 301392
  end
end

defmodule AdventOfCode.Day9Test do
  use ExUnit.Case

  import AdventOfCode.Day9

  defp input(), do: [R: 4, U: 4, L: 3, D: 1, R: 4, D: 1, L: 5, R: 2]

  test "unique tail positions" do
    assert unique_tail_positions(input()) == 13
  end

  test "part one" do
    assert part_one() == 5878
  end

  defp input_2(), do: [R: 5, U: 8, L: 8, D: 3, R: 17, D: 10, L: 25, U: 20]

  test "unique tail positions 2" do
    assert unique_tail_positions_with_knots(input_2()) == 36
  end

  test "part two" do
    assert part_two() == 2405
  end

end

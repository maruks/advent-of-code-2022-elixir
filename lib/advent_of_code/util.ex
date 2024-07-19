defmodule AdventOfCode.Util do
  def resource_path(file_name) do
    Path.join(:code.priv_dir(:advent_of_code), file_name)
  end
end

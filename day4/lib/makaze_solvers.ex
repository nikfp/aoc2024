defmodule MakazeSolver do
  @moduledoc """
  https://adventofcode.com/2024/day/4
  """

  @dirs [:s, :n, :e, :w, :ne, :nw, :se, :sw]

  def parse(input) do
    data =
      input
      |> Enum.map(fn line ->
        line
        |> String.trim()
        |> String.graphemes()
        |> Enum.map(fn
          "X" -> :x
          "M" -> :m
          "A" -> :a
          "S" -> :s
        end)
      end)

    data_tuple = data |> Enum.map(&List.to_tuple/1) |> List.to_tuple()

    map =
      data
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        line
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, col}, acc ->
          coord = [row, col]

          case char do
            :x ->
              Map.update(acc, :x, [count_from(data_tuple, coord)], fn list ->
                [count_from(data_tuple, coord) | list]
              end)

            :a ->
              Map.update(acc, :a, [count_x(data_tuple, coord)], fn list ->
                [count_x(data_tuple, coord) | list]
              end)

            _ ->
              acc
          end
        end)
      end)

    {data_tuple, map}
  end

  defp get_in_tuple(tuple, []) do
    tuple
  end

  defp get_in_tuple(tuple, [index | rest])
      when is_tuple(tuple) and tuple_size(tuple) - 1 >= index and index >= 0 do
    elem(tuple, index) |> get_in_tuple(rest)
  end

  defp get_in_tuple(_tuple, index), do: {:index_error, index}

  defp shift(coord, offset), do: Enum.zip(coord, offset) |> Enum.map(fn {a, b} -> a + b end)

  defp move(:s, coord), do: shift(coord, [1, 0])
  defp move(:n, coord), do: shift(coord, [-1, 0])
  defp move(:e, coord), do: shift(coord, [0, 1])
  defp move(:w, coord), do: shift(coord, [0, -1])
  defp move(:ne, coord), do: shift(coord, [-1, 1])
  defp move(:nw, coord), do: shift(coord, [-1, -1])
  defp move(:se, coord), do: shift(coord, [1, 1])
  defp move(:sw, coord), do: shift(coord, [1, -1])
  defp move(_, coord), do: coord

  defp count(_dir, _data, _coord, [:s, :a, :m, :x]), do: 1

  defp count(dir, data, coord, [:a, :m, :x] = walk) do
    next = move(dir, coord)
    count(dir, data, next, [get_in_tuple(data, next) | walk])
  end

  defp count(dir, data, coord, [:m, :x] = walk) do
    next = move(dir, coord)
    count(dir, data, next, [get_in_tuple(data, next) | walk])
  end

  defp count(dir, data, coord, [:x] = walk) do
    next = move(dir, coord)
    count(dir, data, next, [get_in_tuple(data, next) | walk])
  end

  defp count(_, _, _, _), do: 0

  defp count_x(data, coord) do
    nw = get_in_tuple(data, move(:nw, coord))
    ne = get_in_tuple(data, move(:ne, coord))
    sw = get_in_tuple(data, move(:sw, coord))
    se = get_in_tuple(data, move(:se, coord))

    case {nw, ne, sw, se} do
      {:m, :s, :m, :s} -> 1
      {:s, :m, :s, :m} -> 1
      {:m, :m, :s, :s} -> 1
      {:s, :s, :m, :m} -> 1
      _ -> 0
    end
  end

  defp count_from(data, x) do
    @dirs |> Enum.map(fn dir -> count(dir, data, x, [:x]) end) |> Enum.sum()
  end

  def part1({_data, map}) do
    Map.get(map, :x)
    |> Enum.sum()
  end

  def part2({_data, map}) do
    Map.get(map, :a)
    |> Enum.sum()
  end

  def reader(file) do
    File.read!(file)
    |> String.split(~r/\s+/, trim: true)
    |> parse()
  end
end

# test_file =
#   File.read!("test.txt")
#   |> String.split(~r/\s+/, trim: true)
#   |> Solver.parse()
#
# file =
#   File.read!("input.txt")
#   |> String.split(~r/\s+/, trim: true)
#   |> Solver.parse()
#
# IO.inspect(Solver.part1(test_file), label: "Part 1 Test")
# IO.inspect(Solver.part1(file), label: "Part 1 Real")
# IO.inspect(Solver.part2(test_file), label: "Part 2 Test")
# IO.inspect(Solver.part2(file), label: "Part 2 Real")

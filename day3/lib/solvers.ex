defmodule Part1Solver do
  alias Solver.Helpers

  def solve(input) do
    # Get instances of mul(#,#)
    input
    |> Helpers.get_mul_instances()
    # Process
    |> Helpers.process_numbers()
  end
end

defmodule Part2Solver do
  alias Solver.Helpers

  def solve(input) do
    # Get groups 
    input
    |> get_do_groups()
    |> get_muls_from_do_groups()
    |> Helpers.process_numbers()
  end

  # Works through state machine and extracts blocks in the do() category
  defp get_do_groups(input) do
    split_group(:keep, input, [])
  end

  # Isolates the mul(#,#) elements as `mul: [#, #]`
  defp get_muls_from_do_groups(input_list) do
    input_list
    |> Enum.map(fn el ->
      Helpers.get_mul_instances(el)
    end)
    |> List.flatten()
  end

  # state machine type thing

  # if the iteration has an empty string input, the output is done
  defp split_group(:keep, "", output_list) do
    output_list
  end

  defp split_group(:drop, "", output_list) do
    output_list
  end

  # break apart input string on the don't() block
  # return the good part in the output list
  defp split_group(:keep, input, output_list) do
    case String.split(input, "don't()", parts: 2) do
      [keep, rest] ->
        split_group(:drop, rest, [keep | output_list])

      [keep] ->
        split_group(:drop, "", [keep | output_list])
    end
  end

  # break apart the input string on the do() block
  # return the output list with no additions
  defp split_group(:drop, input, output_list) do
    case String.split(input, "do()", parts: 2) do
      [_drop, rest] -> split_group(:keep, rest, output_list)
      [_drop] -> split_group(:keep, "", output_list)
    end
  end
end

defmodule Solver.Helpers do
  import NimbleParsec

  muls =
    ignore(string("mul("))
    |> integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)
    |> ignore(string(")"))
    |> tag(:mul)

  defparsec(
    :parse_muls,
    repeat(
      choice([
        muls,
        utf8_char([])
      ])
    )
  )

  def get_mul_instances(input) do
    {_, list, _, _, _, _} = parse_muls(input)

    list
    |> Enum.filter(fn el ->
      case el do
        {:mul, _} -> true
        _ -> false
      end
    end)
  end

  def process_numbers(inputs) do
    inputs
    # Strip out numbers
    |> Enum.map(fn {_, nums} -> nums end)
    # Multiply numbers
    |> Enum.map(fn [l, r] -> l * r end)
    # Sum results
    |> Enum.sum()
  end
end

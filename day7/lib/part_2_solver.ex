defmodule Part2Solver do
  def solve(input) do
    input
    |> Enum.filter(fn el -> can_be_true?(el) end)
    |> Enum.map(& &1.target)
    |> Enum.sum()
  end

  defp can_be_true?(line) do
    %{target: target, digits: digits} = line

    digits |> Enum.reverse() |> check_operator(target)
  end

  defp check_operator([final_number], target) do
    final_number == target
  end

  defp check_operator([current_num | [next_num | rest_digits]], target) do
    {match, value} =
      tease_apart_numbers(target, current_num)

    check_operator([next_num | rest_digits], target - current_num) ||
      (rem(target, current_num) == 0 &&
         check_operator([next_num | rest_digits], (target / current_num) |> trunc())) ||
      (match == :match && check_operator([next_num | rest_digits], value))
  end

  defp tease_apart_numbers(target, current_num) do
    target_str = Integer.to_string(target |> trunc()) |> String.split("", trim: true)

    current_num_str =
      Integer.to_string(current_num)
      |> String.split("", trim: true)

    trim_length = length(current_num_str)

    trim = Enum.take(target_str, 0 - trim_length)

    if trim == current_num_str do
      return_str = target_str |> Enum.drop(0 - trim_length) |> Enum.join()

      case return_str do
        "" -> {:nomatch, 0}
        val -> {:match, val |> String.to_integer()}
      end
    else
      {:nomatch, 0}
    end
  end
end

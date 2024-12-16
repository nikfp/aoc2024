defmodule Part2Solver do
  def solve(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      if can_be_true?(line) do
        line.target + acc
      else
        acc
      end
    end)
  end

  defp can_be_true?(line) do
    %{target: target, digits: digits} = line

    digits |> Enum.reverse() |> check_operator(target)
  end

  defp check_operator([final_number], target) do
    final_number == target
  end

  defp check_operator([current_num | [next_num | rest_digits]], target) do
    check_operator([next_num | rest_digits], target - current_num) ||
      (rem(target, current_num) == 0 &&
         check_operator([next_num | rest_digits], (target / current_num) |> trunc())) ||
      with {:match, value} <- tease_apart_numbers(target, current_num) do
        check_operator([next_num | rest_digits], value)
      else
        _ -> false
      end
  end

  defp tease_apart_numbers(target, current_num) do
    size_b = :math.log10(current_num) |> floor() |> Kernel.+(1) |> trunc()
    divisor = :math.pow(10, size_b) |> trunc()

    case rem(target, divisor) do
      val when val == current_num -> {:match, div(target, divisor)}
      _ -> {:nomatch, 0}
    end

    #   target_str = Integer.to_string(target) |> String.split("", trim: true)
    #
    #   current_num_str =
    #     Integer.to_string(current_num)
    #     |> String.split("", trim: true)
    #
    #   trim_length = length(current_num_str)
    #
    #   trim = Enum.take(target_str, 0 - trim_length)
    #
    #   if trim == current_num_str do
    #     return_str = target_str |> Enum.drop(0 - trim_length) |> Enum.join()
    #
    #     case return_str do
    #       "" -> {:nomatch, 0}
    #       val -> {:match, val |> String.to_integer()}
    #     end
    #   else
    #     {:nomatch, 0}
    #   end
  end
end

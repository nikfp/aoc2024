defmodule Part1Solver do
  @doc """
  Input comes in as a list of lines
  each line is represented as a map as: 
    %{
      target: integer, 
      digits: [int, int, ....]
    }
  """
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

    digits
    # because of order of operations, need to reverse
    |> Enum.reverse()
    |> check_operator(target)
  end

  # base case - if final number is target it's true
  defp check_operator([final_number], target) do
    final_number == target
  end

  defp check_operator([current_num | rest_digits], target) do
    check_operator(rest_digits, target - current_num) ||
      (rem(target, current_num) == 0 &&
         check_operator(rest_digits, (target / current_num) |> trunc()))
  end
end

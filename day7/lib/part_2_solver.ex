defmodule Part2Solver do
  def solve(input) do
    input
    |> Enum.drop(4)
    |> Enum.take(1)
    |> Enum.map(fn el -> can_be_true?(el) end)

    # |> Enum.filter(fn line -> can_be_true?(line) end)
    # |> Enum.map(& &1.target)
    # |> Enum.sum()

    # %{digits: digits, target: target} =
    #   complex
    #   |> Enum.drop(4)
    #   |> List.first()
    #
    # IO.inspect(target)
    #
    # combinify_list(digits, 0, length(digits), target)

    # complex_calculated =
    #   complex
    #   |> Enum.filter(fn %{digits: digits, target: target} ->
    #     check_operator
    #   end)

    # [simple | complex_calculated]
    # |> List.flatten()
    # |> Enum.map(fn %{target: target} -> target end)
    # |> Enum.sum()
  end

  defp combinify_list(list, join_index, list_length, target) do
    if join_index + 1 >= list_length do
      false
    else
      # get the start of the list up to the join index
      head = Enum.take(list, join_index)

      # get the join number
      join =
        Enum.drop(list, join_index)
        |> Enum.take(2)
        |> Enum.join("")
        |> String.to_integer()

      # get the tail of the list after join numbers

      tail = Enum.drop(list, join_index + 2)

      merged_list =
        [head, join, tail]
        |> List.flatten()
        |> IO.inspect()

      if(check_operator(merged_list, target)) do
        true
      else
        combinify_list(list, join_index + 1, list_length, target)
      end
    end
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
      check_operator([next_num | rest_digits], target / current_num) 
  end

  defp join_numbers(left, right) do
    [left, right]
    |> Enum.join()
    |> String.to_integer()
  end
end

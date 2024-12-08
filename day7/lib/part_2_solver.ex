defmodule Part2Solver do
  def solve(input) do
    %{simple: simple, complex: complex} =
      input
      |> Enum.map(fn line -> can_be_true?(line) end)
      |> Enum.group_by(fn %{solve_pattern: pattern} -> pattern end)

    # %{digits: digits, target: target} =
    #   complex
    #   |> Enum.drop(4)
    #   |> List.first()
    #
    # IO.inspect(target)
    #
    # combinify_list(digits, 0, length(digits), target)

    complex_calculated =
      complex
      |> Enum.filter(fn %{digits: digits, target: target} -> 
        combinify_list(digits, 0, length(digits), target)
      end)

    [simple | complex_calculated]
    |> List.flatten()
    |> Enum.map(fn %{target: target} -> target end)
    |> Enum.sum()
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

    simple_solve =
      if digits |> Enum.reverse() |> check_operator(target) do
        :simple
      else
        :complex
      end

    Map.put(line, :solve_pattern, simple_solve)
  end

  defp check_operator([final_number], target) do
    final_number == target
  end

  defp check_operator([current_num | rest_digits], target) do
    check_operator(rest_digits, target - current_num) ||
      check_operator(rest_digits, target / current_num)
  end
end

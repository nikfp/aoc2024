defmodule Part1Solver do
  @doc """
  List arrives in reverse order, 
  elements are either an integer or nil
  """
  def solve(input) do
    forward = Enum.reverse(input)

    list_length = length(input)

    # We want to start walking forward on the first list
    # the first time we hit 'nil' we want to stop, and then start 
    # taking from the reverse list. Each pop from the reverse list 
    # will fill in for the nil, and the forward list advances
    # When the forward iteration counter plus the reverse iteration 
    # counter is greater than or equal to the list lenght,
    # iteration is complete
    process_lists(forward, input, [], list_length, 0, 0)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {num, index}, acc ->
      num * index + acc
    end)
  end

  # in this one, advance the reverse list
  # looking for the first non-null from the reverse list
  # only the reverse counter increments
  defp process_lists(
         [nil | forward_rest],
         [nil | reverse_rest],
         collector_list,
         list_length,
         forward_count,
         reverse_count
       ) do
    check_iteration(
      [nil | forward_rest],
      reverse_rest,
      collector_list,
      list_length,
      forward_count,
      reverse_count + 1
    )
  end

  # in this one, add the reverse element to the collector 
  # and advance the forward list 
  # also advance the reverse list
  # each counter increments by 1
  defp process_lists(
         [nil | forward_rest],
         [reverse | reverse_rest],
         collector_list,
         list_length,
         forward_count,
         reverse_count
       ) do
    check_iteration(
      forward_rest,
      reverse_rest,
      [reverse | collector_list],
      list_length,
      forward_count + 1,
      reverse_count + 1
    )
  end

  # in this one, advance the reverse list 
  # getting reverse ready for next nil in forward list
  # increment reverse count
  defp process_lists(
         forward,
         [nil | reverse_rest],
         collector_list,
         list_length,
         forward_count,
         reverse_count
       ) do
    check_iteration(
      forward,
      reverse_rest,
      collector_list,
      list_length,
      forward_count,
      reverse_count + 1
    )
  end

  # in this one, place the forward value in the collector, advance the forward list 
  # increment forward count
  defp process_lists(
         [forward | forward_rest],
         [reverse | reverse_rest],
         collector_list,
         list_length,
         forward_count,
         reverse_count
       ) do
    check_iteration(
      forward_rest,
      [reverse | reverse_rest],
      [forward | collector_list],
      list_length,
      forward_count + 1,
      reverse_count
    )
  end

  # checking this condition in each case is ungainly
  # and it's the same regardless of case
  # so make it a function and it can recurse processing
  # if the exit condition is not met
  defp check_iteration(
         forward_list,
         reverse_list,
         collector_list,
         list_length,
         forward_count,
         reverse_count
       ) do
    if forward_count + reverse_count >= list_length do
      collector_list
    else
      process_lists(
        forward_list,
        reverse_list,
        collector_list,
        list_length,
        forward_count,
        reverse_count
      )
    end
  end
end

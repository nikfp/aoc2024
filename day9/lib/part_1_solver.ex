defmodule Part1Solver do
  @doc """
  List arrives in reverse order, 
  elements are either an integer or nil
  """
  def solve(input) do
    forward = Enum.reverse(input)

    # We want to start walking forward on the first list
    # the first time we hit 'nil' we want to stop, and then start 
    # taking from the reverse list. Each pop from the reverse list 
    # will fill in for the nil, and the forward list advances
    # when the value of the forward list equals what's being popped 
    # from the reverse list, the iteration is complete
  end

  defp process_lists([nil | forward_rest], [nil | reverse_rest], collector_list) do
    # in this one, advance the reverse list
    process_lists([nil, forward_rest], [reverse_rest], collector_list)
  end

  defp process_lists([nil | forward_rest], [reverse | reverse_rest], collector_list) do
    # in this one, add the reverse element to the collector and advance the forward list 
    process_lists(forward_rest, [reverse_rest], [reverse | collector_list])
  end

  defp process_lists(forward, [nil | reverse_rest], collector_list) do
    # in this one, advance the reverse list 
    process_lists(forward, reverse_rest, collector_list)
  end

  defp process_lists([forward | forward_rest], [reverse | reverse_rest], collector_list)
       when forward == reverse do
    # This is the special case, the two input lists have caught up in the middle. 
    # Take whatever values are left of the forward value, add to collector, and return the collector.   
  end

  defp process_lists([forward | forward_rest], reverse, collector_list) do
    # in this one, place the forward value in the collector, advance the forward list 
    process_lists(forward_rest, reverse, [forward | collector_list])
  end
end

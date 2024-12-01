defmodule Part2Solver do
  def solve({left_list, right_list}) do
    right_map =
      Enum.reduce(right_list, %{}, fn el, acc ->
        Map.update(acc, el, 1, fn val -> val + 1 end)
      end)

    Enum.map(left_list, fn el -> 
      Map.get(right_map, el, 0)
      |> Kernel.*(el)
    end)
    |> Enum.sum()

  end
end

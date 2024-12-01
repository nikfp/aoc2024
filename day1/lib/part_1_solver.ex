defmodule Part1Solver do
  def solve({left, right}) do
    process(left, right, 0)
  end

  defp process([hd_l | tl_l], [hd_r | tl_r], acc) do
    new_acc = Kernel.-(hd_l, hd_r) |> abs() |> Kernel.+(acc)

    process(tl_l, tl_r, new_acc)
  end

  defp process([], [], acc) do
    acc
  end
end

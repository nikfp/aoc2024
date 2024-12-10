defmodule Parser do
  def parse(file) do
    input_list =
      File.read!(file)
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    list_length = length(input_list)
  end

  defp build_loc_map(input_list) do
  end

  defp add_elements(_, [], _, _, collector) do
    collector
  end

  defp add_elements(:filled, [current | rest_elements], file_id, next_index, collector) do
  end

  defp add_elements(:free, [current | rest_elements], file_id, next_index, collector) do
  end
end

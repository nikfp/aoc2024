defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def build_loc_list(input_list) do
    add_elements(:filled, input_list, 0, [])
  end

  defp add_elements(_, [], _, collector) do
    collector
    |> List.flatten()
  end

  defp add_elements(:filled, [current | rest_elements], file_id, collector) do
    # get N of whatever file id is in play
    # prepend those to the collector list
    # recurse passing the next file id
    add_elements(:free, rest_elements, file_id + 1, [List.duplicate(file_id, current) | collector])
  end

  defp add_elements(:free, [current | rest_elements], file_id, collector) do
    # get N of '.'
    # prepend those to collector list
    # recurse with current file id
    add_elements(:filled, rest_elements, file_id, [List.duplicate(nil, current) | collector])
  end
end

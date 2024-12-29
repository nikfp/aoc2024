defmodule Part1Solver do
  def solve(input) do
    %{grid: grid, upper_bound: _upper_bound} = input

    {updated_grid, _} =
      Map.keys(grid)
      |> Enum.reduce({grid, 0}, fn location, acc ->
        {grid, next_group} = acc

        location_info = Map.get(grid, location)

        if location_info.group do
          {grid, next_group}
        else
          flood_search(grid, %{}, [location], next_group)
        end
      end)

    updated_grid
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.group_by(fn %{group: group} -> group end)
    |> IO.inspect(label: "updated locations")
    |> Enum.map(fn {k, v} ->
      bound_count =
        Enum.map(v, fn loc -> length(loc.boundaries) end)
        |> Enum.sum()

      length(v) * bound_count
    end)
    |>IO.inspect(label: "region totals")
    |> Enum.sum()
  end

  # work through all locations
  # when you reach a location that doesn't have a group,
  # assign the next group number to it
  # flood fill search all connected elements of the same type
  # in that group. 

  defp flood_search(grid, _evaluated_locs, [], group_number) do
    {grid, group_number + 1}
  end

  defp flood_search(grid, evaluated_locs, lookup_locs, group_number) do
    [{row, col} | rest_locs] = lookup_locs
    location_details = Map.get(grid, {row, col}) |> Map.put(:group, group_number)

    {updated_location, updated_lookups} =
      # set surrounding locations
      [
        {row + 1, col},
        {row - 1, col},
        {row, col + 1},
        {row, col - 1}
      ]
      # check if locations have been evaluated
      |> Enum.filter(fn el -> Map.get(evaluated_locs, el, false) == false end)
      |> Enum.reduce({location_details, rest_locs}, fn new_loc, {details, lookups} ->
        eval_loc = Map.get(grid, new_loc, %{char: "AA", group: nil})

        case eval_loc.char do
          char when char == details.char ->
            if Map.has_key?(evaluated_locs, new_loc) do
              {details, [lookups]}
            else
              {details, [new_loc | lookups]}
            end

          _ ->
            {Map.update(details, :boundaries, [], fn list -> [new_loc | list] end), lookups}
        end
      end)

    flood_search(
      grid |> Map.put({row, col}, updated_location),
      evaluated_locs |> Map.put({row, col}, true),
      updated_lookups,
      group_number
    )
  end

  # once groups are numbered, areas are the number of elements
  # in the group. 

  # maybe perimeter of a group is everywhere it touches another group,
  # plus anywhere it touches a boundary. Can this be calculated during
  # the flood fill? o

  # FLOOD FILL - 
  # need a list of locations to evaluate
  # need a map of evaluated locations
  # get head of lookup list
  # - look up, left, down, right
  # - if found location is same character, 
  #   and not in the map of processes locations, 
  #   add to lookup list
  # - if found location is another character, add to boundary list for location
  # - once the current location is done evaluating, add to map of evaluated locations
  # - recurse on recurse by passing grid, list of to-evaluate locations,
  #   and list of seen locations
  # - Once the lookup list is empty, return the updated grid

  # FINAL CALC
  # process all locations to groupings, 
  # count members of group for area, 
  # count perimeter locations noted for each location,
  # multiply, then sum the total of all
end

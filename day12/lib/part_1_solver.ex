defmodule Part1Solver do
  def solve(input) do
    %{grid: grid, upper_bound: _upper_bound} = input

    # Take the grid keys
    {updated_grid, _} =
      Map.keys(grid)
      |> Enum.drop(5)
      |> Enum.take(1)
      |> IO.inspect()
      # Work through each one in a reducer
      |> Enum.reduce({grid, 0}, fn element, {new_grid, group_number} ->
        # Pull the location out of the grid
        location = new_grid |> Map.get(element)

        # If the location already has a group, continue
        if location.group != nil do
          {new_grid, group_number}

          # Otherwise execute a flood search on the current location
        else
          flood_search(new_grid, %{}, [element], group_number)
        end
      end)

    updated_grid
    |> IO.inspect()
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.group_by(fn el -> el.group end)
    |> Enum.map(fn {_, v} -> 
      area = length(v)
    
      perimeter = 
        Enum.flat_map(v, fn %{boundaries: bounds} -> bounds end)
        |> Enum.uniq()
        |> Enum.count()
    
      area * perimeter
    end)
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
    # Get the first element of the lookup list
    [{row, col} | rest_locs] = lookup_locs

    # Get the character we're evaluating against
    %{char: location_char} = location_info = Map.get(grid, {row, col})

    # Get surrounding locations as a list 
    {updated_lookup_locs, updated_location_details} =
      [
        {row, col - 1}, 
        {row, col + 1},
        {row - 1, col},
        {row + 1, col}
      ]

      # Iterate over locations
      |> Enum.reduce({rest_locs, location_info}, fn new_loc, {other_locs, details} ->
        # If the new location has been evaluated, ignore it and 
        # move along to the next location
        if Map.has_key?(evaluated_locs, new_loc) do
          {other_locs, details}
        else
          # If the now location has not been evaluated, we need it's character
          %{char: new_loc_char} = new_loc_details = Map.get(grid, new_loc, %{char: "AA"})

          # If the character matches, add the new location to the list of
          # Things to evaluate
          if new_loc_char == location_char do
            {[new_loc | other_locs], details}
          else
            # if the character doesn't match, 
            # add the new location to the list of locations that are boundaries
            updated_details =
              Map.update(details, :boundaries, [], fn list -> [new_loc | list] end)

            {other_locs, updated_details}
          end
        end
      end)

    location_with_group =
      updated_location_details
      |> Map.put(:group, group_number)

    updated_grid =
      grid
      |> Map.put({row, col}, location_with_group)

    updated_eval_locations =
      evaluated_locs
      |> Map.put({row, col}, true)

    flood_search(updated_grid, updated_eval_locations, updated_lookup_locs, group_number)
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

defmodule Part1Solver do
  def solve(input) do
    %{locations: locations, upper_bound: upper_bound} = input

    Map.keys(locations)
    |> Enum.reduce({locations, upper_bound, 0}, fn location, acc ->
      nil
    end)
  end

  # work through all locations
  # when you reach a location that doesn't have a group,
  # assign the next group number to it
  # flood fill search all connected elements of the same type
  # in that group. 
  defp process_location(location, grid, next_group) do
    # if location has a group, it's been processed. 
    # Return the grid

    # if the location doesn't have a group, 
  end

  # once groups are numbered, areas are the number of elements
  # in the group. 

  # maybe perimeter of a group is everywhere it touches another group,
  # plus anywhere it touches a boundary. Can this be calculated during
  # the flood fill? o

  # FLOOD FILL - 
  # get position and map of all locations
  # - look up, left, down, right
  # - if found location is same character, add to list to look at
  # - if found location is another character, add to boundary to group
  # - once the location is done evaluating, add to map of evaluated locations
  # - recurse on to-evaluate list until empty

  # FINAL CALC
  # process all locations to groupings, 
  # count members of group for area, 
  # count perimeter locations noted for each location,
  # multiply, then sum the total of all
end

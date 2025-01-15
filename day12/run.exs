IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Parser
alias Part1Solver

# Parser.parse("./inputs/test_a.txt")
# |> Part1Solver.solve()
# |> IO.inspect(label: "test part 1, test a, expects 140")
#
# Parser.parse("./inputs/test_b.txt")
# |> Part1Solver.solve()
# |> IO.inspect(label: "test part 1, test b, expects 772")
#
# Parser.parse("./inputs/test_c.txt")
# |> Part1Solver.solve()
# |> IO.inspect(label: "test part 1, test c, expects 1930")
#
# Parser.parse("./inputs/prod.txt")
# |> Part1Solver.solve()
# |> IO.inspect(label: "prod part 1")

# Part 2
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Part2Solver

Parser.parse_part_2("./inputs/test_a.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "test part 2, test a, expects 80")

# Parser.parse_part_2("./inputs/test_b.txt")
# |> Part2Solver.solve()
# |> IO.inspect(label: "test part 2, test b, expects 436")
#
# Parser.parse_part_2("./inputs/test_c.txt")
# |> Part2Solver.solve()
# |> IO.inspect(label: "test part 2, test c, expects 1206")
#
# Parser.parse_part_2("./inputs/test_d.txt")
# |> Part2Solver.solve()
# |> IO.inspect(label: "test part 2, test d, expects 368")
#
# Parser.parse_part_2("./inputs/test_e.txt")
# |> Part2Solver.solve()
# |> IO.inspect(label: "test part 2, test e, expects 236")

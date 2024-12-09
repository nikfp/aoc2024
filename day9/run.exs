IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Part1Solver

Parser.parse("./inputs/simple_test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "simple_test part 1")

# Parser.parse("./inputs/test.txt")
# |> IO.inspect(label: "test part 1")

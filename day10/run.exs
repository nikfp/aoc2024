IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex")

alias Parser

Code.require_file("./lib/part_1_solver.ex")

alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1")

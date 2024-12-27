IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve(25)
|> IO.inspect(label: "test part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve(25)
|> IO.inspect(label: "prod part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve(75)
|> IO.inspect(label: "prod part 1")

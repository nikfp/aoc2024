IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex")

alias Parser

Code.require_file("./lib/part_1_solver.ex")

alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "prod part 1")

Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Part2Solver

Parser.parse("./inputs/test.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "test part 2")

Parser.parse("./inputs/prod.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "prod part 2")

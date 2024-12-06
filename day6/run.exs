IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Parser
alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "part 1 test")
Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "part 1 prod")

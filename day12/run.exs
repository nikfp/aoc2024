IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Parser
alias Part1Solver

Parser.parse("./inputs/test_a.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1, test a, expects 140")

Parser.parse("./inputs/test_b.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1, test b, expects 772")

Parser.parse("./inputs/test_c.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1, test c, expects 1930")

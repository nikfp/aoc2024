IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

test_input = Parser.parse("./inputs/test.txt")
test_2_input = Parser.parse("./inputs/test2.txt")
prod_input = Parser.parse("./inputs/prod.txt")

test_input
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 test")

prod_input
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 prod")

test_input
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 test")

prod_input
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 prod")

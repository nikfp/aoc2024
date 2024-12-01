Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

# Part 1 solver
Parser.parse("./input/test.txt")
|> Parser.build_lists()
|> Parser.sort_lists()
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 test")

Parser.parse("./input/prod.txt")
|> Parser.build_lists()
|> Parser.sort_lists()
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 prod")

# Part 2 solver
Parser.parse("./input/test.txt")
|> Parser.build_lists()
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 test")

Parser.parse("./input/prod.txt")
|> Parser.build_lists()
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 prod")

%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(t7).
-author("ricardo a harari - ricardo.harari@gmail.com").
-export([main/0]).

-define(MAX_ROWS, 100000). % for test case
-define(MAX_COLS, 10000).  % for test case

main() ->
  FirstLine = ["element 1", "element 2", "element 3"] ++ ["first " ++ integer_to_list(X) || X <- lists:seq(1,?MAX_COLS)] ++ ["element 4"],
  L = gen_test_data([FirstLine], [["element " ++ integer_to_list(X) || X <- lists:seq(1,?MAX_COLS)]], 0),
  true.

gen_test_data(Acc, _, ?MAX_COLS) -> Acc;
gen_test_data(Acc, Line, Row) -> gen_test_data(Acc ++ Line, Line, Row + 1).
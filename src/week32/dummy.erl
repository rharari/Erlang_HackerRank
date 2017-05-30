%%%-------------------------------------------------------------------

%%%-------------------------------------------------------------------
-module(dummy).
-export([main/0]).

main() ->
  X = lists:seq(1,1000000),
  Lst = X ++ X ++ X ++ X ++ X ++ X ++ X ++ X ++ X ++ X,
  %N = 1,
  %A0 = array:new(10000001),
  S0 = gb_sets:new(),
  %Lst2 = fill(A0, N),
  io:fwrite("start~n"),
  %fill2(Lst, []),
  %fill3(Lst, S0, 0),
  fill4(Lst, 1),
  io:fwrite("end~n"),
  ok.


fill4(_, 10000000) -> ok;
fill4(Lst, N) -> _ = lists:nth(N, Lst), fill4(Lst, N+1).

fill3([], _S0, _) -> ok;
fill3([H|T], S0, N) -> fill3(T, gb_sets:add({N,"teste"}, S0), N+1).


fill2([], _Acc) -> ok;
fill2([H|T], Acc) -> fill2(T, Acc ++ [1]).

fill(Arr, 10000000) -> Arr;
fill(Arr, N) -> fill(array:set(N, 1, Arr), N+1).


%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Minimum average waiting time
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/minimum-average-waiting-time
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
          A = <<"3 0 3 1 9 2 5 3 7 4 4 4 5 4 6">>,
          X1 = binary:split(A, [<<"\n">>], [global]),
          [N|L] = [binary_to_integer(C) || C <- X1],
          Lst = gb_sets:new(),
          processQueue(N, L, Lst, -1, 0.0).
          %Lst2 = fillLst(100000, Lst),
          %io:fwrite("step 1~n"),
          %changeLst(100000, Lst2).


processQueue(N, [OrderTime,ProcTime|Orders], Gb, NxtTime, Avg) when OrderTime > NxtTime ->
  % process Gb
  gb_queue:add()


changeLst(0, Lst) -> Lst;
changeLst(N, Lst) ->
  {{En, {Size, ID}}, Lst2} = gb_sets:take_smallest(Lst),
  changeLst(N-1, gb_sets:add({En + 100000, {Size, ID}}, Lst2)).

fillLst(0, Lst) -> Lst;
fillLst(N, Lst) -> fillLst(N-1, gb_sets:add({N, {random:uniform(1000), N}}, Lst)).


getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.

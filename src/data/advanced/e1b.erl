%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% the crazy helix
%%% @end
%%% https://www.hackerrank.com/challenges/helix
%%%-------------------------------------------------------------------
-module(e1b).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  X = <<"5 10 1 1 3 2 3 3 3 1 3 5 1 2 4 3 1 3 5 2 4 1 5 5 2 2">>,
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [N,Step|Cmd] = [binary_to_integer(C) || C <- A],
  L = lists:seq(1, N),
  Lst =  lists:zip(L, L),
  processCmd(Lst, Cmd, Step).

processCmd(_, _, 0) -> ok;

processCmd(Lst, [2,A1|T], Step) ->
  % io:fwrite("element ~p is at position ~p~n", [A1, indexOf(A1, Lst, 1)]),
  processCmd(Lst, T, Step - 1);

processCmd(Lst, [3,A1|T], Step) ->
  {_, X} = lists:nth(A1, Lst),
  io:fwrite("element at position ~p is ~p~n", [A1, X]), processCmd(Lst, T, Step - 1);

processCmd(Lst, [1,A1,A2|T], Step) when A1 =:= A2 -> processCmd(Lst, T, Step - 1);

processCmd(Lst, [1,A1,A2|T], Step) ->
  {L1, L2} = lists:split(A1 - 1, Lst),
  {L3, L4} = lists:split(A2 - A1 + 1, L2),
  processCmd(lists:append(L1, lists:reverse(L3, L4)), T, Step - 1).

% O(n) -> must optimize! gb_sets?!
indexOf(X, [X|_], Pos) -> Pos;
indexOf(X, [_|T], Pos) -> indexOf(X, T, Pos+1).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
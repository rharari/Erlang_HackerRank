%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/sherlock-and-pairs/problem
%%% @end
%%% Created : 20. Aug 2019
%%%-------------------------------------------------------------------

-module(sherlock_pairs).
-author("rharari").
-export([main/0, solve/1]).
-import(os, [getenv/1]).

solve(A) ->
  Arr = compact(lists:sort(A), -1, 0, []),
  count(Arr, 0).

count([], Acc) -> Acc;
count([H|T], Acc) -> count(T, Acc + (H - 1) * H).

compact([], _, Total, Acc) -> add_total(Acc, Total);
compact([H|T], Last, Total, Acc) when H == Last -> compact(T, Last, Total + 1, Acc);
compact([H|T], _, Total, Acc) -> compact(T, H, 1, add_total(Acc, Total)).

add_total(Acc, V) when V < 2 -> Acc;
add_total(Acc, V) -> Acc ++ [V].

main() ->
  {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
  {T, _} = string:to_integer(string:chomp(io:get_line(""))),
  lists:foreach(fun(_TItr) ->
    io:get_line(""),
    A = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),
    Result = solve(A),
    io:format("~p~n", [Result]),
    io:fwrite(Fptr, "~w~n", [Result]) end,
    lists:seq(1, T)),
  file:close(Fptr),
  ok.
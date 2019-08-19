%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/counting-valleys/problem
%%% @end
%%% Created : 19. Aug 2019 01:58
%%%-------------------------------------------------------------------
%%% > c("counting_valleys.erl")

-module(counting_valleys).
-author("rharari").
-export([main/0]).
-import(os, [getenv/1]).

countingValleys(_N, S) -> count(S, 0, 0).

count([], _, Acc) -> Acc;
count([85|T], Pos, Acc) -> count(T, Pos + 1, Acc);
count([68|T], 0, Acc) -> count(T, -1, Acc + 1);
count([68|T], Pos, Acc) -> count(T, Pos-1, Acc).

main() ->
  {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
  {N, _} = string:to_integer(string:chomp(io:get_line(""))),
  S = case io:get_line("") of
        eof -> "";
        SData -> string:chomp(SData)
      end,
  Result = countingValleys(N, S),
  io:fwrite(Fptr, "~w~n", [Result]),
  file:close(Fptr),
  ok.
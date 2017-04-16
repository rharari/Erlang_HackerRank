%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 10:48 AM
%%%-------------------------------------------------------------------
-module(solC).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  exec(N).

print(0, _) -> {ok};
print(N, C) ->
  io:fwrite("~p~n", [C]),
  print(N - 1, C).

exec(N) ->
  case io:fread("", "~d") of
    eof -> {ok};
    { ok, [X]} -> print(N, X), exec(N)
  end.
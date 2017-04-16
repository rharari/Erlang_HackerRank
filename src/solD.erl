%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 11:33 AM
%%%-------------------------------------------------------------------
-module(solD).

-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [X]} = io:fread("", "~d"),
  exec(X).

print(X, N) when N >= X -> {ok};
print(_, N) ->
  io:fwrite("~p~n", [N]).

exec(X) ->
  case io:fread("", "~d") of
    eof -> {ok};
    { ok, [N]} -> print(X, N), exec(X)
  end.
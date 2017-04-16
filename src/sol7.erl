%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 7:36 AM
%%%-------------------------------------------------------------------
-module(sol7).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  print(N, 1).

print(N,M) when N<M -> ok;
print(N,M) ->
  say(" ", N - M), say("#", M), io:fwrite("~n"),
  print(N, M+1).

say(_, 0) -> {ok};
say(S, N) ->
  io:fwrite("~s", [S]),
  say(S, N-1).

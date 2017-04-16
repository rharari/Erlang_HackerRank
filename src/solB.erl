%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 10:35 AM
%%%-------------------------------------------------------------------
-module(solB).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  print(N).

print(0) -> {ok};
print(N) -> io:fwrite("Hello World~n"), print(N-1).

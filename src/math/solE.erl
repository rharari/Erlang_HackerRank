%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Jul 2016 12:27 AM
%%%-------------------------------------------------------------------
-module(solE).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"), exec(N).

exec(0) -> {ok};
exec(N) ->
  { ok, [X1,Y1,X2,Y2]} = io:fread("", "~d~d~d~d"),
  DX = abs(X1 - X2),
  DY = abs(Y1 - Y2),
  print(steps(DX, DY)),
  exec(N-1).

steps(0, D2) -> D2;
steps(D1, D2) -> steps(D2 rem D1, D1).

print(N) -> io:format("~p~n", [N-1]).
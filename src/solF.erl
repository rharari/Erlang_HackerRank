%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 2:14 PM
%%%-------------------------------------------------------------------
-module(solF).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  print(exec([])).

exec(Arr) ->
  case io:fread("", "~d") of
    eof -> Arr;
    { ok, [N] } -> Arr2 = [N | Arr], exec(Arr2)
  end.

print([]) -> {ok};
print([H|T]) -> io:fwrite("~p~n", [H]), print(T).
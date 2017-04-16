%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Jul 2016 6:38 PM
%%%-------------------------------------------------------------------
-module(solG).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> exec(0).

exec(V) ->
  case io:fread("", "~d") of
      eof -> io:fwrite("~p~n", [V]), {ok};
      { ok, [N] } -> exec(V+1)
  end.

calc(V, N) when N rem 2 =:= 0 -> V;
calc(V, N)  -> V + N.

%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Aug 2016 2:35 AM
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).
main() -> io:fwrite("~p~n", f(io:fread("", "~d~d"))).
f({ok, [N,M]}) when N == 1 orelse N == M -> [0];
f({ok, [N,M]}) -> [(M div N + 1) * N - M].

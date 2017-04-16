%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Oct 2016 12:06 AM
%%%-------------------------------------------------------------------
-module(sol2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [G]} = io:fread("", "~d"),
  go(G).

go(0) ->  {ok};
go(G) ->  {ok, [_,S]} = io:fread("", "~d~s"),
  case string:str(S, "_") =:= 0 of
    true -> [S1|TS] = S;
    false -> [S1|TS] = lists:sort(S)
  end,
  case S1 =:= 95 of
    true -> io:format("YES\n");
    false -> io:format("~s\n", [check(S1, 0, TS)])
  end,
  go(G-1).

check(_, C, []) when C > 0 -> "YES";
check(95, _, []) -> "YES";
check(_, _, []) ->  "NO";
check(_, 0, [95|_]) -> "NO";
check(_, _, [95|_]) -> "YES";
check(Sa, C, [H|T]) when H == Sa -> check(H, C + 1, T);
check(_, 0, _) ->  "NO";
check(_, _, [H|T]) -> check(H, 0, T).


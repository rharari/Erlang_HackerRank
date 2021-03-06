%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/mini-max-sum
%%% @end
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() -> {ok, [A1,A2,A3,A4,A5]} = io:fread("", "~d ~d ~d ~d ~d"),
          A = lists:sort([A1,A2,A3,A4,A5]), T = lists:sum(A),
          io:format("~p ~p~n", [T - lists:nth(5,A), T - lists:nth(1,A)]).

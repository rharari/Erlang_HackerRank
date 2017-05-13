%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/sock-merchant
%%% Hackerrank - Sock merchant
%%% @end
%%%-------------------------------------------------------------------
-module(e5).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [N]} = io:fread("", "~d"),
          io:format("~p ", [countPairs(maps:new(), N, 0)]).

countPairs(_, 0, Acc) -> Acc;
countPairs(Map, N, Acc) -> {ok, [K]} = io:fread("", "~d"),
                           case maps:is_key(K, Map) of
                             true -> countPairs(maps:remove(K, Map), N-1, Acc + 1);
                             false -> countPairs(maps:put(K, K, Map), N - 1, Acc)
                           end.

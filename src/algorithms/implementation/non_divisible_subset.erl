%%%-------------------------------------------------------------------
%%% @author ricardo a. harari - ricardo.harari@gmail.com
%%% @doc
%%%   https://www.hackerrank.com/challenges/non-divisible-subset/problem
%%% @end
%%% Created : 21. Dec 2018 05:41
%%%-------------------------------------------------------------------

-module(non_divisible_subset).
-author("rharari").
-export([main/0]).

-define(IIF(C,RT,RF), (case (C) of true -> (RT); false -> (RF) end)).

main() ->
  [_N,K|S] = kbRead(),
  io:format("~p~n", [nonDivisibleSubset(K, S)]).

nonDivisibleSubset(K, S) ->
  Arr = prepare_array(S, K, array:new(K, {default,0})),
  count(1, Arr, K div 2, K, ?IIF(K rem 2 == 0, 1, 0) + min(1, array:get(0, Arr))).

count(I, _Arr, K2, _K, Count) when I > K2 -> Count;
count(I, Arr, K2, K, Count) when I =/= K - I ->
  count(I + 1, Arr, K2, K, Count + max(array:get(I, Arr), array:get(K - I, Arr)));
count(I, Arr, K2, K, Count) -> count(I + 1, Arr, K2, K, Count).

prepare_array([], _, Arr) -> Arr;
prepare_array([H|T], K, Arr) ->
  Pos = H rem K,
  prepare_array(T, K, array:set(Pos, array:get(Pos, Arr) + 1, Arr)).

kbRead() ->
  B = getBin(),
  A = binary:split(B, [<<"\n">>, <<" ">>], [global]),
  [binary_to_list(C) || C <- A].

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
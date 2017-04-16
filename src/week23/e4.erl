%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Sep 2016 9:23 AM
%%%-------------------------------------------------------------------
-module(e4).
-author("rharari").
-export([main/0]).

main() ->
  M = 10,
  S = "aaabaaaaaaa",
  V = calc(S),
  %%{M, S, V}.
  trunc(M/V) rem 1000000007.
  %%sum(trunc(M/V), 0) rem 1000000007.

sum(M, T) when M == 0 -> T;
sum(M, T) ->
  sum(M - 1, T + 1).

calc(S) ->
  %%%{ ok, [X1,Y1,A,B]} = io:fread("", "~d~d~d~d"),
  N = length(S),
  Len = 0,
  LPS = array:new(N, {default,0}),
  I = 1,
  LPS2 = go(S, N, LPS, I, Len),
  L2 = array:get(N-1, LPS2),
  case L2 > 0 andalso (N rem (N - L2)) == 0 of
    true -> N - L2;
    false -> N
  end.

go(S,M,LPS,I, Len) when I == M -> LPS;
go(S,M,LPS,I, Len) ->
  %%if (str[i] == str[len]) {
    case string:sub_string(S, I + 1, I + 1) == string:sub_string(S, Len + 1, Len + 1) of
      true -> LPS2 = array:set(I, Len + 1, LPS ),
              go(S, M, LPS2, I+1, Len+1);
      false ->
        case Len == 0 of
          true -> go(S, M, LPS, I+1, Len);
          false -> go(S, M, LPS, I+1, array:get(Len -1, LPS))
        end
    end.
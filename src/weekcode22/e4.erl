%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Aug 2016 8:56 AM
%%%-------------------------------------------------------------------
-module(e4).
-author("rharari").

-export([main/0]).
main() ->

  %%{ok, [N]} = io:fread("", "~d"),
  N = 6,
  A = ets:new('solution', [{read_concurrency, true}]),

  %%fill(A, lists:map(fun(X) -> {Int, _} = string:to_integer(X),  Int end, string:tokens(io:get_line(""), " ")), 1),
  fill(A, [0, -1, 2, -1,3,-1], 1),

  start(A, N).
  %%try
    %%start(A, N)
  %%catch
   %% _:_ -> io:format("0")
  %%end.

start(A, N) ->
  [{_,Joker,B}] = ets:lookup(A, 1),
  checkLimit(not Joker, lists:nth(1,B), 1),
  %%if H =/= 0 -> throw("x") end,
  loop1(1, A, 2, N).

loop1(Total, _, K, N) when K > N -> Total;
loop1(Total, A, K, N) ->
  {_,Joker,B} = retrieveElement(A, K),
  io:fwrite("Loop1 ---> N=~p  K=~p   Joker=~p ~n", [N, K, Joker]),
  checkLimit(not Joker, lists:nth(1,B), K),
  NK = K + K,
  case NK > N of
    true -> loop1(Total * (K), A, K + 1, N);
    false ->
      BNew = loop2(Total, A, {NK, K, N, Joker}, B, []),
      loop1(Total * length(BNew), A, K + 1, N)
      %%S1 = length(B), S = length(BNew),
      %%case S1=/=S of
      %%  true -> ets:insert(A, {K, Joker, BNew});
      %%  false -> ok
      %%end,
  end.


checkLimit(T, A, B) when T andalso A>=B -> throw("x");
checkLimit(_, _, _) -> ok.

loop2(Total, _, {K2, _, N, _}, B, _) when K2 > N -> checkEmpty(B), B;
loop2(Total, A, {K2, K, N, Joker}, B, Bnew) ->
  io:fwrite("   Loop2 ---> K=~p   K2=~p  Joker=~p ~n", [K, K2, Joker]),
  {_,Joker2,B2} = retrieveElement(A, K2),
  BnewX = loop3(Total, A, K, B, Bnew, {K2, Joker2, B2}),
  loop2(Total * length(BnewX), A, {K2 + K, K, N, Joker}, BnewX, []).

loop3(Total, _, _, [], Bnew, _) -> Bnew;

loop3(Total, A, K, [E1|BT], Bnew, {K2, Joker2, B2}) when not Joker2 ->
  io:fwrite("     Loop3 ---> K-~p   K2=~p  Joker=~p ", [K, K2, Joker2]),
  T = is_nice(E1, lists:nth(1, B2), K),
  io:fwrite(" --> IsNice? ~p ~n", [T]),
  case T of
    true -> loop3(Total + 1, A, K, BT, Bnew ++ [E1], {K2, Joker2, B2});
    false -> loop3(Total, A, K, BT, Bnew, {K2, Joker2, B2})
  end;

loop3(Total, A, K, [E1|BT], Bnew, {K2, Joker2, B2}) when Joker2 ->
  io:fwrite("     Loop3 ---> K-~p   K2=~p  Joker=~p ~n", [K, K2, Joker2]),
  B2New = loop4(E1, B2, K, []),
  checkEmpty(B2New),
  %%S1 = length(B2), S = length(B2New),
  %%case S1=/=S of
  %%  true -> ets:insert(A, {K2, Joker2, B2New});
  %%  false -> ok
  %%end,
  loop3(Total * length(B2New), A, K, BT, Bnew, {K2, Joker2, B2New}).



loop4(_, [], _, B2new) -> B2new;
loop4(E1, [E2|B2T], K, B2new) ->
  io:fwrite("         Loop4 ---> K=~p ", [K]),
  T = is_nice(E1, E2, K),
  io:fwrite(" --> IsNice K=~p [~p,~p]? ~p ~n", [K,E1,E2,T]),
  case T of
    true -> loop4(E1, B2T, K, B2new ++ [E2]);
    false -> loop4(E1, B2T, K, B2new)
  end.



assertTrue(T) when T -> ok;
assertTrue(T) when not T -> throw("X").

checkEmpty(B) -> assertTrue(length(B) > 0).
is_nice(A1, A2, K) -> A1 =:= A2 rem K.


retrieveElement(A, K) ->
  [{N,J,B}] = ets:lookup(A, K),
  S = length(B),
  case S =:= 0 of
    false -> {N,J,B};
    true ->
      assertTrue(J),
      L = lists:seq(0, K - 1),
      ets:insert(A, {K, true, L}),
      {N,J,L}
  end.


fill(_, [], _) -> ok;
fill(A, [H|T], I) ->
  case H =:= -1 of
    true -> ets:insert(A, {I, true, []});
    false -> ets:insert(A, {I, false, [H]})
  end,
  fill(A, T, I+1).
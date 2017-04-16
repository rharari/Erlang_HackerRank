%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Sep 2016 10:10 PM
%%%-------------------------------------------------------------------
-module(e5).
-export([main/0]).

main() ->
  {N, Q, T, TS, UV} = setup(),
  go({N, Q, T, TS, UV}).

go({_,_,_,_,_,[]}) -> {ok};
go({N,Q,T,TS,[UV|UVT]}) ->
  [U,V] = [binary_to_integer(X) || X <- binary:split(UV, [<<" ">>], [global])],
  Pu = lists:nth(U, T),
  Pv = lists:nth(V, T),
  {D, In} = getDistance(Pu, Pv, 0, T),
  io:format("Pu -> ~p    D-> ~p  Pv -> ~p   T -> ~p",[Pu,D,Pv, T]),
  {_, Pv1} = Pv,

  case In of
    0 -> %%G = getSubTree(lists:sublist(T,V,N), #{Pv1 => D}, D*D);
         G = getSubTree(T, #{Pv1 => D}, D*D);
    1 -> {_, Pu1} = Pu,
         M = getMap(T, Pu, #{Pu1 => 0}, 0),
         %%G = getSubTree(lists:sublist(T,V,N), M, 0)
         G = getSubTree(T, M, 0)
  end,
  io:format("~p\n", [G]),
  go({N, Q, T, TS, UVT}).

find([{H1, H2}|T], V, P) when H2 == V -> P;
find([H|T], V, P)  -> find(T, V, P + 1).

getMap(_, {Pu0, Pu1}, M, _) when Pu0 == 1 andalso Pu1 == 1 -> M;
getMap(T, {Pu0, _}, M, Dist) ->
  M2 = maps:put(Pu0, Dist + 1, M),
  getMap(T, lists:nth(Pu0, T), M2, Dist + 1).


getSubTree([], _, G) -> G;
getSubTree([{H1, H2}|T], M, G) ->
  case maps:find(H1, M) of
    {ok, D} -> case maps:find(H2, M) of
                 {ok, D2} -> getSubTree(T, M, G + D2*D2);
                 _ -> M1 = maps:put(H2, D+1, M),
                      getSubTree(T, M1, G + (D+1)*(D+1))
               end;
    _       -> getSubTree(T, M, G)
  end.

getDistance(Pu, Pv, D, _) when Pu == Pv -> {D, 1}; %% pu is pv
getDistance({Pu0, _},     {_, Pv1}, D, _) when Pu0 == Pv1 -> {D + 1, 1}; %% Pu is child of Pv
getDistance({_, Pu1},   {Pv0, _},   D, _) when Pv0 == Pu1 -> {D + 1, 0}; %% Pu is parent of Pv
getDistance({Pu0, _}, {Pv0, _}, D, _) when Pu0 == Pv0 -> {D + 2, 0}; %% Pu is sibling of Pv
getDistance(Pu, Pv, D, T) ->
  getDistance2(Pu,Pv,D,T, #{}, #{}).

getDistance2({Pu1, Pu2}, {Pv1, Pv2}, D, T, MPu, MPv) ->


%%fromTop({1, _}, _, N) -> N + 1;
%%fromTop({P0, P1}, T, N) -> fromTop(lists:nth(P0,T), T, N+1).


%%getDistance({Pu0, Pu1}, {Pv0, Pv1}, D, T) when Pu1 > Pv1 -> getDistance(lists:nth(Pu0, T), {Pv0, Pv1}, D + 1, T); %% Pu is below than Pv
%%getDistance({Pu0, Pu1}, {Pv0, Pv1}, D, T) when Pu1 < Pv1 -> getDistance({Pu0, Pu1}, lists:nth(Pv0, T), D + 1, T). %% Pu is above than Pv

getLevelMap(T, M, N) ->
  {P1, P2} = lists:nth(N, T),
  case maps:find(P1, M) of
    {ok, Level} -> M2 = maps:put(P2, Level+1, M),
                   gelLevelMap(T, M, N+1);
    _ -> L = getLevelMap(T, M, P1),

  end

setup() ->
B = <<"5\n4 2 5 1\n3\n5 5\n2 5\n5 2">>,
%%  B = getBin(),
  [A1, Tmp, A2|UV] = binary:split(B, [<<"\n">>], [global]),
  N = binary_to_integer(A1),
  Q = binary_to_integer(A2),
  T = [{1,1}] ++ lists:zipwith(fun(X, Y) -> {binary_to_integer(X), Y} end, binary:split(Tmp, [<<" ">>], [global]), lists:seq(2, N)),
  TS = getLevelMap(T, #{1 => 1}, 1),
  TS = lists:sort(  fun( {A1,A2}, {B1,B2}) -> A1 < B1 end, T),
  {N, Q, T, TS, UV}.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.
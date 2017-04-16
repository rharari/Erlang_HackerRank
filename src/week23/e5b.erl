%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. Sep 2016 3:14 PM
%%%-------------------------------------------------------------------
-module(e5b).
-export([main/0]).

main() ->
  {N, Q, T, UVList} = setup(),
  [UV|_] = UVList,
  %% start hr
  [U,V] = [binary_to_integer(X) || X <- binary:split(UV, [<<" ">>], [global])],
  {D, Inside} = getDistance(T, {U, 0}, {V, 0}, #{U => 0}, #{V => 0}),
  case Inside of
    false -> %%G = getSubTree(lists:sublist(T,V,N), #{Pv1 => D}, D*D);
        G = findG(T, #{V => D}, D*D);
    true ->
        M = getMap(T, U, #{U => 0}, 0),
        G = findG(T, M, 0)
  end,
  {D, Inside, G}.

findG([], _, G) -> G;
findG([{H2, H1}|T], M, G) ->
  case maps:find(H1, M) of
    {ok, D} -> case maps:find(H2, M) of
                 {ok, D2} -> findG(T, M, G + D2*D2);
                 _ ->
                   M1 = maps:put(H2, D+1, M),
                   findG(T, M1, G + (D+1)*(D+1))
               end;
    _       -> findG(T, M, G)
  end.

getMap(_, U, M, _) when U == 1 -> M;
getMap(T, U, M, Dist) ->
  M2 = maps:put(U, Dist + 1, M),
  {_, P} = lists:nth(U, T),
  getMap(T, lists:nth(P, T), M2, Dist + 1).


%% getDistance -> return { Distance,  P1 is child of P2? }
%% use 2 map structure {key = node #, value = distance from start}, go up node by node until find common ancestor
getDistance(T, {P1, D1}, {P2, D2}, M1, M2) when P1 == 1 ->
  D2b = maps:get(P2, M1, -1),
  case D2b == -1 of true  ->
      {_, P2n} = lists:nth(P2, T),
      getDistance(T, {P1,D1}, {P2n, D2+1}, M1, M2);
    false -> {D2b + D2, D2b == 0}
  end;
getDistance(T, {P1, D1}, {P2, D2}, M1, M2) when P2 == 1 ->
  D1b = maps:get(P1, M2, -1),
  case D1b == -1 of
    true  ->
      {_, P1n} = lists:nth(P1, T),
      case P1n == 1 of
        true -> getDistance(T, {P1n, D1+1}, {P2, D2}, maps:put(P1n, D1+1, M1), M2); %% TODO: improve and return the result
        false -> getDistance(T, {P1n, D1+1}, {P2, D2}, M1, M2)
      end;
    false -> {D1b + D1, D1b == 0}
  end;
getDistance(T, {P1, D1}, {P2, D2}, M1, M2) ->
  D1b = maps:get(P1, M2, -1),
  D2b = maps:get(P2, M1, -1),
  case D1b + D2b of
    -2  ->
      {_, P1n} = lists:nth(P1, T),
      {_, P2n} = lists:nth(P2, T),
      getDistance(T, {P1n,D1+1}, {P2n,D2+1}, maps:put(P1n, D1+1, M1), maps:put(P2n, D2+1, M2));
    _   ->
      case D1b == -1 of
        true -> {D2b + D2, D2b == 0};
        false -> {D1b + D1, D1b == 0}
      end
  end.


setup() ->
  B = <<"9\n9 9 9 1 7 1 6 1\n1\n9 4">>,
%%  B = getBin(),
  [A1, Tmp, A2|UV] = binary:split(B, [<<"\n">>], [global]),
  N = binary_to_integer(A1),
  Q = binary_to_integer(A2),
  T = [{1,1}] ++ lists:zipwith(fun(X, Y) -> {X, binary_to_integer(Y)} end, lists:seq(2, N), binary:split(Tmp, [<<" ">>], [global])),
  {N, Q, T, UV}.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.

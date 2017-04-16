%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Sep 2016 12:19 AM
%%%-------------------------------------------------------------------
-module(e5c).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  {T, UVList} = setup(),
  Tb2 = ets:new(table2, [set]),
  ets:insert(Tb2, {1,0, []}),
  getLevel(Tb2, T),
  go(Tb2, T, UVList).

go(_, _, []) -> {ok};
go(Tb2, T, [UV|UVList]) ->
  [U,V] = [binary_to_integer(X) || X <- binary:split(UV, [<<" ">>], [global])],
  [{_, LU, _}] = ets:lookup(Tb2, U), [{_, LV, Child}] = ets:lookup(Tb2, V),
  {D, Inside, CrumbTrail} = getDistance([{1,1}] ++ T, Tb2, {U, V}, {U, LU}, {V, LV}, {#{}, 0}),
  io:format("D=~p  CrumbTrail=~p\n", [D, CrumbTrail]),
  G = calcG(Tb2, Child, D + 1, D*D, Inside, CrumbTrail),
  io:format("~p\n", [G]),
  go(Tb2, T, UVList).


calcG(_, [], _, G, _, _) -> G;
calcG(Tb2, [Ch|Ct], D, G, Inside, _) when Inside == false ->
  [{_, _, Child2}] = ets:lookup(Tb2, Ch),
  G2 = calcG(Tb2, Child2, D+1, G + D*D, false, null),
  calcG(Tb2, Ct, D, G2, false, null);

calcG(Tb2, [Ch|Ct], D, G, Inside, Trail) when Inside == true ->
  D2 = maps:get(Ch, Trail, -1),
  [{_, _, Child2}] = ets:lookup(Tb2, Ch),
  case D2 of
    -1 -> G2 = calcG(Tb2, Child2, D +1, G + D*D, false, null);
    DD -> G2 = calcG(Tb2, Child2, DD + 1, G + DD*DD, true, Trail)
  end,
  calcG(Tb2, Ct, D, G2, true, Trail).


%% TODO do not need DM
%% U is below V
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, {M, DM}) when LU > LV ->
  {_, Fu} = lists:nth(U, T),
  case Fu == Sv of
    true ->
      [{_, DSv, _}] = ets:lookup(Tb2, Sv), [{_, DSu, _}] = ets:lookup(Tb2, Su),
      {DSu - DSv, true, maps:put(U, DM, maps:put(Fu, DM + 2, M)) }; %% U is below V, in the same subtree
    false -> getDistance(T, Tb2, {Su, Sv}, {Fu, LU-1}, {V, LV}, {maps:put(U, DM, M), DM + 1}) %% go up with U
  end;
%% V is below U
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, _) when LU < LV ->
  {_, Fv} = lists:nth(V, T),
  case Fv == Su of
    true ->
      [{_, DSv, _}] = ets:lookup(Tb2, Sv), [{_, DSu, _}] = ets:lookup(Tb2, Su),
      {DSv - DSu, false, null}; %% V is below U, in the same subtree
    false -> getDistance(T, Tb2, {Su, Sv}, {U, LU}, {Fv, LV - 1}, ok)
  end;
%% U is now at same level of V
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, _) when LU == LV ->
  case U == V of
    true -> {0, false, ok}; %% U and V are the same, so far so good
    false ->
      {_, Fv} = lists:nth(V, T),
      {_, Fu} = lists:nth(U, T),
      case Fv == Fu of
        true -> [{_, Fd, _}] = ets:lookup(Tb2, Fv),
          [{_, DSv, _}] = ets:lookup(Tb2, Sv), [{_, DSu, _}] = ets:lookup(Tb2, Su),
          {DSu + DSv - 2 * Fd, false, null}; %% simon says: ancestor found!
        false -> getDistance(T, Tb2, {Su, Sv}, {Fu, LU -1}, {Fv, LV - 1}, ok) %% keep climbing, johnnie climber
      end
  end.

getLevel(Tb2, T) ->
  Ret = findLevel(Tb2, T, []),
  case Ret of
    [] -> {ok};
    R -> getLevel(Tb2, R)
  end.

findLevel(_, [], Acc) -> Acc;
findLevel(Tb2, [{H1, H2}|T], Acc) ->
  case ets:lookup(Tb2, H2) of
    [] -> findLevel(Tb2, T, Acc ++ [{H1, H2}]);
    [{_, F1L, Arr}] ->
      ets:update_element(Tb2, H2, {3, Arr ++ [H1]}),
      ets:insert(Tb2, {H1, F1L + 1, []}),
      findLevel(Tb2, T, Acc)
  end.

setup() ->
  %%B = <<"8\n1 4 2 2 4 6 3\n1\n2 4">>, %% 27 - ok!
  %%B = <<"5\n4 2 5 1\n3\n5 5\n2 5\n5 2">>, %% 14 6 13 - ok!
  %%B = <<"7\n4 2 5 1 4 6\n1\n2 5\n">>, %% 19 - throw exception  \n at end
  %%B = <<"1\n2\n1 1\n1 1\n1 1">>, %% 0 0 - ok!
  %%B = <<"12\n1 4 1 2 2 6 7 4 1 1 9\n5\n1 1\n12 1\n1 12\n2 4\n4 2">>, %%54 206 9 38 63 - ok!
  B = <<"12\n1 4 1 2 2 6 7 4 1 1 9\n1\n12 1">>,
  %%B = getBin(),
  [A1, Tmp, _|UV] = binary:split(B, [<<"\n">>], [global]),
  N = binary_to_integer(A1),
  %%Q = binary_to_integer(A2),
  case (N == 1) of
    true -> T = [];
    false -> T = lists:zipwith(fun(X, Y) -> {X, binary_to_integer(Y)} end, lists:seq(2, N), binary:split(Tmp, [<<" ">>], [global]))
  end,
  {T, UV}.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.
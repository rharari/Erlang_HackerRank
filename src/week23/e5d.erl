%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Sep 2016 3:48 PM
%%%-------------------------------------------------------------------
-module(e5d).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  {T, UVList} = setup(),
  Tb2 = #{1 => {0, []}},
  Tb3 = getLevel(Tb2, T),
  go(Tb3, T, UVList).

go(_, _, []) -> {ok};
go(Tb2, T, [UV|UVList]) ->
  [U,V] = [binary_to_integer(X) || X <- binary:split(UV, [<<" ">>], [global])],
  {LU, _} = maps:get(U, Tb2),
  {LV, Child} = maps:get(V, Tb2),
  {D, Inside, CrumbTrail} = getDistance([{1,1}] ++ T, Tb2, {U, V}, {U, LU}, {V, LV}, {#{}, 0}),
  G = calcG(Tb2, Child, D + 1, D*D, Inside, CrumbTrail),
  io:format("~p\n", [G]),
  go(Tb2, T, UVList).

calcG(_, [], _, G, _, _) -> G;
calcG(Tb2, [Ch|Ct], D, G, Inside, _) when Inside == false ->
  {_, Child2} = maps:get(Ch, Tb2),
  case Child2 == [] of
    true -> G2 = G + D*D;
    false -> G2 = calcG(Tb2, Child2, D+1, G + D*D, false, null)
  end,
  calcG(Tb2, Ct, D, G2, false, null);

calcG(Tb2, [Ch|Ct], D, G, Inside, Trail) when Inside == true ->
  D2 = maps:get(Ch, Trail, -1),
  {_, Child2} = maps:get(Ch, Tb2),
  case Child2 == [] of
    true ->
      case D2 of
        -1 -> G2 = G + D*D;
        DD -> G2 = G + DD*DD
      end;
    false ->
        case D2 of
          -1 -> G2 = calcG(Tb2, Child2, D +1, G + D*D, false, null);
          DD -> G2 = calcG(Tb2, Child2, DD + 1, G + DD*DD, true, Trail)
        end
  end,
  calcG(Tb2, Ct, D, G2, true, Trail).


%% TODO do not need DM
%% U is below V
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, {M, DM}) when LU > LV ->
  {_, Fu} = lists:nth(U, T),
  case Fu == Sv of
    true ->
      {DSv, _} = maps:get(Sv, Tb2),  {DSu, _} = maps:get(Su, Tb2),
      {DSu - DSv, true, maps:put(U, DM, maps:put(Fu, DM + 2, M)) }; %% U is below V, in the same subtree
    false -> getDistance(T, Tb2, {Su, Sv}, {Fu, LU-1}, {V, LV}, {maps:put(U, DM, M), DM + 1}) %% go up with U
  end;
%% V is below U
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, _) when LU < LV ->
  {_, Fv} = lists:nth(V, T),
  case Fv == Su of
    true ->
      {DSv, _} = maps:get(Sv, Tb2), {DSu, _} = maps:get(Su, Tb2),
      {DSv - DSu, false, null}; %% V is below U, in the same subtree
    false -> getDistance(T, Tb2, {Su, Sv}, {U, LU}, {Fv, LV - 1}, ok)
  end;
%% U is now at same level of V
getDistance(T, Tb2, {Su, Sv}, {U, LU}, {V, LV}, _) when LU == LV ->
  case U == V of
    true -> {0, false, ok}; %% U and V are the same, so far so good
    false ->
      {_, Fv} = lists:nth(V, T), {_, Fu} = lists:nth(U, T),
      case Fv == Fu of
        true -> {Fd, _} = maps:get(Fv, Tb2),
          {DSv, _} = maps:get(Sv, Tb2), {DSu, _} = maps:get(Su, Tb2),
          {DSu + DSv - 2 * Fd, false, null}; %% simon says: ancestor found!
        false -> getDistance(T, Tb2, {Su, Sv}, {Fu, LU -1}, {Fv, LV - 1}, ok) %% keep climbing, johnnie climber
      end
  end.

getLevel(Tb2, T) ->
  {Tb3,Ret} = findLevel(Tb2, T, []),
  case Ret of
    [] -> Tb3;
    R -> getLevel(Tb3, R)
  end.

findLevel(Tb2, [], Acc) -> {Tb2,Acc};
findLevel(Tb2, [{H1, H2}|T], Acc) ->
  case maps:get(H2, Tb2, null) of
    null -> findLevel(Tb2, T, Acc ++ [{H1, H2}]);
    {F1L, Arr} -> Tb3 = maps:put(H2, {F1L, Arr ++ [H1]}, Tb2),
                  findLevel(maps:put(H1, {F1L + 1, []}, Tb3), T, Acc)
  end.

setup() ->
  %%B = <<"8\n1 4 2 2 4 6 3\n1\n2 4">>, %% 27 - ok!
  %%B = <<"5\n4 2 5 1\n3\n5 5\n2 5\n5 2">>, %% 14 6 13 - ok!
  %%B = <<"7\n4 2 5 1 4 6\n1\n2 5\n">>, %% 19 - ok - throw exception  \n at end
  %%B = <<"1\n2\n1 1\n1 1\n1 1">>, %% 0 0 - ok!
  %%B = <<"12\n1 4 1 2 2 6 7 4 1 1 9\n5\n1 1\n12 1\n1 12\n2 4\n4 2">>, %%54 206 9 38 63 - ok!
  B = getBin(),
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

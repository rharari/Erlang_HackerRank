%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - 3D Surface Area
%%% @end
%%% https://www.hackerrank.com/contests/w35/challenges/3d-surface-area
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  X = getBin(),
  [H,W|L] = [binary_to_integer(C) || C <-binary:split(X, [<<"\n">>, <<" ">>], [global])],
  io:format("~p", [(calcSide1(1, 1, 0, {H, W, L}, 0) + calcSide2(1, 1, 0, {H, W, L}, 0) + H * W) * 2]),
  {ok}.

calcSide2(_, J, _, {H, _, _}, V) when J > H -> V;
calcSide2(I, J, _, {H, W, L}, V) when I > W -> calcSide2(1, J + 1, 0, {H, W, L}, V);
calcSide2(I, J, S0, {H, W, L}, V) ->
  Sij = getValue(I, J, L, W), Delta = Sij - S0,
  case Delta > 0 of
    true -> calcSide2(I + 1, J, Sij, {H, W, L}, V + Delta);
    false -> calcSide2(I + 1, J, Sij, {H, W, L}, V)
  end.

calcSide1(I, _, _, {_, W, _}, V) when I > W -> V;
calcSide1(I, J, _, {H, W, L}, V) when J > H -> calcSide1(I + 1, 1, 0, {H, W, L}, V);
calcSide1(I, J, S0, {H, W, L}, V) ->
  Sij = getValue(I, J, L, W), Delta = Sij - S0,
  case Delta > 0 of
    true -> calcSide1(I, J + 1, Sij, {H, W, L}, V + Delta);
    false -> calcSide1(I, J + 1, Sij, {H, W, L}, V)
  end.

getValue(I, J, L, W) -> lists:nth((J - 1) * W + I, L).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.

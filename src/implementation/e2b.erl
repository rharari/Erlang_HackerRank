%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/matrix-rotation-algo
%%% Hackerrank - Matrix Layer Rotation
%%% @end
%%%-------------------------------------------------------------------
-module(e2b).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [M,N,R|Arr] = [binary_to_integer(C) || C <- A],
  %   M = 300, N = 300, R = 999999999, Arr = lists:seq(1,90000),
  Arr2 = array:from_list(Arr),
  Lst = ets:new(matrix, [set]),
  start(M, N, R, Arr2, Lst).

start(M, N, R, Arr, Lst) ->
  NumVec = min(M,N) div 2,
  go({M,N,R}, NumVec, 0, Arr, Lst),
  print(Lst, 1, N, N, M*N).

print(_, _, _, _, 0) -> {ok};
print(Lst, I, N, N1, QTD) ->
  [{_,V}] = ets:lookup(Lst, I),
  print(Lst, I + 1, format(N, N1, V), N1, QTD - 1).

format(1, N1, V) -> io:format("~p~n", [V]), N1;
format(N, _, V) -> io:format("~p ", [V]), N-1.

go(_, NumVec, CurrVec, _, _) when NumVec =:= CurrVec -> {ok};
go({M,N,R}, NumVec, CurrVec, Arr, Lst) ->
  Step = R rem (2 * (M + N - 4 * CurrVec) - 4),
  Ml = M - 2 * CurrVec, Nl = N - 2 * CurrVec,
  L = getPos(N, Ml, Nl, CurrVec),
  {L1, L2} = lists:split(Step, L),
  L3 = L2 ++ L1,
  fill(L3, L, Arr, Lst),
  go({M,N,R}, NumVec, CurrVec + 1, Arr, Lst).

fill([], _, _, _) -> true;
fill([H|T], [H2|T2], Source, Dest) ->
  V = array:get(H-1, Source),
  ets:insert(Dest, {H2, V}),
  fill(T, T2, Source, Dest).

getPos(N, Ml, Nl, CurrVec) ->
  Pos = CurrVec * (N + 1) + 1,
  Pos2 = Pos + Nl + N - 1,
  Pos3 = Pos2 + (Ml - 2) * N - 1,
  Pos4 = Pos3 - Nl - N + 2,
  L1 = genPos(Pos, 1, Nl - 1, []),
  L2 = genPos(Pos2, N, Ml - 2, []),
  L3 = genPos(Pos3, -1, Nl - 2, []),
  L4 = genPos(Pos4, - N, Ml - 3, []),
  L1 ++ L2 ++ L3 ++ L4.

genPos(_, _, I, Acc) when I < 0 -> Acc;
genPos(NxtPos, Inc, Nl, Acc) -> genPos(NxtPos + Inc, Inc, Nl - 1, Acc ++ [NxtPos]).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
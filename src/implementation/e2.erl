%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/matrix-rotation-algo
%%% Hackerrank - Matrix Layer Rotation
%%% fail! 2 slow - need more math, see e2b.erl
%%% @end
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [M,N,R|Arr] = [binary_to_integer(C) || C <- A],
  %   M = 300, N = 300, R = 999999999, Arr = lists:seq(1,90000),
  Lst = ets:new(matrix, [set, public, {write_concurrency,true}]),
  fill_ets(0, Arr, Lst),
  start(M, N, R, Lst).

start(M,N,R,Lst) ->
  NumVec = min(M,N) div 2,
  go({M,N,R}, NumVec, 0, Lst),
  print(Lst, 0, N, N, M*N).

print(_, _, _, _, 0) -> {ok};
print(Lst, I, N, N1, QTD) ->
  [{_,V}] = ets:lookup(Lst, I),
  print(Lst, I + 1, format(N, N1, V), N1, QTD - 1).

format(1, N1, V) -> io:format("~p~n", [V]), N1;
format(N, _, V) -> io:format("~p ", [V]), N-1.

fill_ets(_, [], _) -> true;
fill_ets(N, [H|T], Lst) -> ets:insert(Lst, {N, H}), fill_ets(N + 1, T, Lst).

go(_, NumVec, CurrVec, _) when NumVec =:= CurrVec -> {ok};
go({M,N,R}, NumVec, CurrVec, Lst) when NumVec - CurrVec > 7 ->
  R1 = spawn_set({M,N,R}, CurrVec, Lst),
  R2 = spawn_set({M,N,R}, CurrVec + 1, Lst),
  R3 = spawn_set({M,N,R}, CurrVec + 2, Lst),
  R4 = spawn_set({M,N,R}, CurrVec + 3, Lst),
  R5 = spawn_set({M,N,R}, CurrVec + 4, Lst),
  R6 = spawn_set({M,N,R}, CurrVec + 5, Lst),
  R7 = spawn_set({M,N,R}, CurrVec + 6, Lst),
  R8 = spawn_set({M,N,R}, CurrVec + 7, Lst),
  receive_set(R1), receive_set(R2), receive_set(R3), receive_set(R4),
  receive_set(R5), receive_set(R6), receive_set(R7), receive_set(R8),
  go({M,N,R}, NumVec, CurrVec + 8, Lst);
go({M,N,R}, NumVec, CurrVec, Lst) ->
  R1 = spawn_set({M,N,R}, CurrVec, Lst),
  receive_set(R1),
  go({M,N,R}, NumVec, CurrVec + 1, Lst).

spawn_set({M,N,R}, CurrVec, Lst) ->
  Ref = make_ref(),
  SelfPid = self(),
  spawn(fun() -> SelfPid ! {Ref,
    do_rotation({M,N,R}, CurrVec, R rem (2 * (M + N - 4 * CurrVec) - 4), 0, Lst)
  } end),
  Ref.

receive_set(Ref) ->
  receive
    {Ref, L} -> L
  end.


do_rotation(_, _, NumStep, CurrStep, _) when NumStep =:= CurrStep -> true;
do_rotation({M,N,R}, CurrVec, NumStep, CurrStep, Lst) ->
  rotate_north(CurrVec * (N + 1), N - 1 - 2 * CurrVec, Lst),
  rotate_west(N, N * (CurrVec + 1) - CurrVec - 1, M - 2 * CurrVec - 1, Lst),
  rotate_south(N * (M - CurrVec) - 1 - CurrVec, N - 2 * CurrVec - 1, Lst),
  rotate_east(N, N * (M - CurrVec - 1) + CurrVec, M - 2 - 2 * CurrVec, Lst),
  do_rotation({M,N,R}, CurrVec, NumStep, CurrStep + 1, Lst).

rotate_east(_, _, 0, _) -> true;
rotate_east(N, I0, I1, Lst) ->
  [{_, V0}] = ets:lookup(Lst, I0), [{_, V1}] = ets:lookup(Lst, I0 - N),
  ets:insert(Lst, {I0, V1}), ets:insert(Lst, {I0 - N, V0}),
  rotate_east(N, I0 - N, I1 - 1, Lst).

rotate_south(_, 0, _) -> true;
rotate_south(I0, I1, Lst) ->
  [{_, V0}] = ets:lookup(Lst, I0), [{_, V1}] = ets:lookup(Lst, I0 - 1),
  ets:insert(Lst, {I0, V1}), ets:insert(Lst, {I0 - 1, V0}),
  rotate_south(I0 - 1, I1 - 1, Lst).

rotate_west(_, _, 0, _) -> true;
rotate_west(N, I0, I1, Lst) ->
  [{_, V0}] = ets:lookup(Lst, I0), [{_, V1}] = ets:lookup(Lst, I0 + N),
  ets:insert(Lst, {I0, V1}), ets:insert(Lst, {I0 + N, V0}),
  rotate_west(N, I0 + N, I1 - 1, Lst).

rotate_north(_, 0, _) -> true;
rotate_north(I0, I1, Lst) ->
  [{_, V0}] = ets:lookup(Lst, I0), [{_, V1}] = ets:lookup(Lst, I0 + 1),
  ets:insert(Lst, {I0, V1}), ets:insert(Lst, {I0 + 1, V0}),
  rotate_north(I0 + 1, I1 - 1, Lst).


getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
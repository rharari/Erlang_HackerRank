%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Lighthouse
%%% @end
%%% Created : 13. Sep 2016 10:31 PM
%%%-------------------------------------------------------------------
-module(e2).
-export([main/0, set2/2, genCircle/1]).

main() ->
  { ok, [N]} = io:fread("", "~d"),
  Frame = readAll(N, []),
  Radius = trunc((N-1)/2),
  start(Radius, Frame, N).

start(0, _, _) -> 0;
start(Radius, Frame, N) ->
  io:format("start - Radius: ~p -- N:~p ~n", [Radius, N]),
  Circle = genCircle(Radius),
  Len = length(Circle),
  case check(N-Len, Radius, Frame, N, Circle, Len) of
    0 -> start(Radius -1, Frame, N);
    R -> R
  end.

check(-1, _, _, _, _, _) -> 0;
check(Cols, Radius, Frame, N, Circle, Len) ->
  io:format("   check Cols:~p,  Radius:~p,   N:~p,    Len:~p~n", [Cols, Radius, N, Len]),
  case checkOverlap(Radius, N - Len, 1, Frame, Circle) of
    0 -> check(Cols - 1, Radius, Frame, N, [X bsl 1 || X <- Circle], Len);
    R -> R
  end.

%% TODO: improvement opportunity - should 1st start checking from largest '.' lines
checkOverlap(Radius, -1, _, _, _) -> 0;
checkOverlap(Radius, N, Line, Frame, Circle) ->
  Len = length(Circle),
  SubFrame = lists:sublist(Frame, Line, Len),
  LenP = length(SubFrame),
  io:format("         checkOverlap  Radius: ~p   N:~p   CircleLen: ~p   SubFrameLen: ~p~n", [Radius, N, Circle, SubFrame]),
  case checkCircle(SubFrame, Circle) of
    true -> Radius;
    false -> checkOverlap(Radius, N - 1, Line +1, Frame, Circle)
  end.


checkCircle([], []) -> true;
checkCircle([Sh|St], [Ch|Ct]) when Sh band Ch == Ch -> checkCircle(St, Ct);
checkCircle(_, _) -> false.

set2(N, Bin) ->
  %%io:format("         ...setBit: ~p", [N]),
  <<L:N/bits, _:1, R/bits>> = Bin,
  <<L/bits, 1:1, R/bits>>.

readAll(0, R) -> R;
readAll(N, R) -> { ok, [S]} = io:fread("", "~s"),
                 <<X:64>> = getNum(S, 1, <<0:64>>),
                 readAll(N-1, R ++ [X]).

%% TODO: symmetric - each 1/4 of the circle can be replicated and reduce the amount of calculation
genCircle(Radius) ->
   Lines = Radius * 2 + 1,
   genArray(Radius, Lines, 1, Radius + 1, Radius +1, []).

genArray(_, Lines, Y1, _, _, R) when Y1 > Lines -> R;
genArray(Radius, Lines, Y1, Px, Py, R) ->
  %%io:format("~n    ..... setLine: ~p~n", [Y1]),
  <<RL:64>> = setLine(Radius, 1, Y1, Px, Py, <<0:64>>),
  genArray(Radius, Lines, Y1 + 1, Px, Py, R ++ [RL]).

setLine(_, X1, _, Px, _, R) when X1 == Px * 2 -> R;
setLine(Radius, X1, Y1, Px, Py, R) ->
  D = math:sqrt(math:pow(Px-X1,2) + math:pow(Py-Y1,2)),
  case D =< Radius of
    true -> setLine(Radius, X1 + 1, Y1, Px, Py, set2(X1, R));
    false -> setLine(Radius, X1 + 1, Y1, Px, Py, R)
  end.


getNum([], _, Bit) -> Bit;
getNum([H|T], P, Bit) when H == $* -> getNum(T, P+1, Bit);
getNum([H|T], P, Bit) when H == $. -> getNum(T, P+1, set2(P, Bit)).



getChar(S, N, Row, Col) ->
  I = (Row - 1) * N + Col,
  string:sub_string(S, I, I).

bbsl(Bin,Shift) -> <<_:Shift,Rest/bits>> = Bin, <<Rest/bits,0:Shift>>.math


%% check(readAll(N, ""), N, 0, 2, 2).

%%start(_, N, Max, Prow, _) when Prow > N - 1 -> Max;
%%start(S, N, Max, Prow, Pcol) ->
%%  M2 = check(S, N, Prow, Pcol, 0).

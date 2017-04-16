%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Lighthouse
%%% @end
%%% Created : 14. Sep 2016 2:49 AM
%%%-------------------------------------------------------------------
-module(e2b).

%% TODO: improvement opportunity - should 1st start checking from largest '.' lines
%% TODO: symmetric - each 1/4 of the circle can be replicated and reduce the amount of calculation
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [N]} = io:fread("", "~d"),
          io:format("~p", [go(trunc((N-1)/2), readAll(N, []), N)]).

go(0, _, _) -> 0;
go(Radius, Frame, N) -> case check(N - Radius * 2 + 1, Radius, Frame, N, genCircle(Radius), Radius * 2 + 1) of
                          0 -> go(Radius - 1, Frame, N);
                          R -> R
                        end.

check(-1, _, _, _, _, _) -> 0;
check(Cols, Radius, Frame, N, Circle, Len) ->
  case check2(Radius, N - Len, 1, Frame, Circle) of
    0 -> check(Cols - 1, Radius, Frame, N, [X bsr 1 || X <- Circle], Len);
    R -> R
  end.

check2(_, -1, _, _, _) -> 0;
check2(Radius, N, Line, Frame, Circle) ->
  SubFrame = lists:sublist(Frame, Line, length(Circle)),
  case check3(SubFrame, Circle) of
    true -> Radius;
    false -> check2(Radius, N -1, Line +1, Frame, Circle)
  end.

check3([], []) -> true;
check3([Sh|St], [Ch|Ct]) when Sh band Ch == Ch -> check3(St, Ct);
check3(_, _) -> false.

setBit(N, Bin) -> <<L:N/bits, _:1, R/bits>> = Bin, <<L/bits, 1:1, R/bits>>.

readAll(0, R) -> R;
readAll(N, R) -> { ok, [S]} = io:fread("", "~s"),
  <<X:64>> = getNum(S, 1, <<0:64>>),
  readAll(N-1, R ++ [X]).

genCircle(Radius) ->
  Lines = Radius * 2 + 1,
  genArray(Radius, Lines, 1, Radius + 1, Radius +1, []).

genArray(_, Lines, Y1, _, _, R) when Y1 > Lines -> R;
genArray(Radius, Lines, Y1, Px, Py, R) ->
  <<RL:64>> = setLine(Radius, 1, Y1, Px, Py, <<0:64>>),
  genArray(Radius, Lines, Y1 + 1, Px, Py, R ++ [RL]).

setLine(_, X1, _, Px, _, R) when X1 == Px * 2 -> R;
setLine(Radius, X1, Y1, Px, Py, R) ->
  D = math:sqrt(math:pow(Px-X1,2) + math:pow(Py-Y1,2)),
  case D =< Radius of
    true -> setLine(Radius, X1 + 1, Y1, Px, Py, setBit(X1, R));
    false -> setLine(Radius, X1 + 1, Y1, Px, Py, R)
  end.

getNum([], _, Bit) -> Bit;
getNum([H|T], P, Bit) when H == $* -> getNum(T, P+1, Bit);
getNum([H|T], P, Bit) when H == $. -> getNum(T, P+1, setBit(P, Bit)).
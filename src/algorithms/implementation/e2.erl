%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% Encryption
%%% @end
%%% https://www.hackerrank.com/challenges/encryption
%%%-------------------------------------------------------------------
-module(e2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [S]} = io:fread("", "~s"),
  L = length(S),
  Lsqrt = math:sqrt(L),
  Lfloor = trunc(Lsqrt),
  Cols = getCols(L, Lfloor, ceil(Lsqrt, Lfloor)),
  print(S, L, Cols, 1, 1).

print(S, L, Cols, Pos, Step) when Pos > L ->
  NewPos = Step + 1,
  case NewPos > Cols of
    true  -> {ok};
    false -> io:format(" "),
             print(S, L, Cols, NewPos, NewPos)
  end;

print(S, L, Cols, Pos, Step) ->
  io:format("~s", [string:sub_string(S, Pos, Pos)]),
  print(S, L, Cols, Pos + Cols, Step).

ceil(A, B) when A - B == 0 -> B;
ceil(_, B) -> B + 1.

getCols(L, F, _) when F * F >= L -> F;
getCols(_, _, C) -> C.
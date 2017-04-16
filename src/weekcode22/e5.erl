%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Aug 2016 3:19 AM
%%%-------------------------------------------------------------------
-module(e5).
-author("rharari").
-export([main/0]).

-define( MIN_CUT_LENGTH, 64 ).

main() ->
  {ok, [N,M]} = io:fread("", "~d~d"),
  A = lists:duplicate(round(math:pow(2,N)), 0),
  process(N,M,A,0).

process(_,0,_,_) -> ok;
process(N,M,A,S0) ->
  R = string:tokens(io:get_line(""), " "),
  C = lists:nth(1,R),
  case C of
    "3" ->
      {ok, [Z], _} = io_lib:fread("~2u", lists:nth(2,R)),
      case Z of
        0 -> io:fwrite("~p~n", [S0]);
        _Else -> io:fwrite("~p~n", [lists:nth(Z, A)])
      end,
      process(N, M-1, A, S0);
    _Else ->
      {X, _} = string:to_integer(lists:nth(2,R)),
      {ok, [Z], _} = io_lib:fread("~2u", lists:nth(3,R)),
      Start = getStart(Z, 1),
      Size = length(A),
      {H1,T1} = lists:split(Start - 1, A),
      Cut2 = Size - Start,
      {H2,T2} = lists:split(Cut2, T1),
      A2 = setParallel({C, Start, X, Z}, H2),
      process(N, M-1, H1 ++ A2 ++ T2, valempty(C,S0,X))
  end.

setParallel({C, I0, X, I1}, List) ->
  V = length(List) div 2,
  case V > ?MIN_CUT_LENGTH of
    false -> set({C, I0, X, I1}, List, []);
    true ->
      {L, R} = lists:split(V, List),
      Ref1 = spawn_set({C, I0, X, I1}, L),
      Ref2 = spawn_set({C, I0 + V, X, I1}, R),
      L1 = receive_set(Ref1),
      R1 = receive_set(Ref2),
      L1 ++ R1
  end.

spawn_set({C, I0, X, I1}, List) ->
  Ref = make_ref(),
  SelfPid = self(),
  spawn(fun() -> SelfPid ! {Ref, set({C, I0, X, I1}, List, [])} end),
  Ref.

receive_set(Ref) ->
  receive
    {Ref, L} -> L
  end.

valempty("1",_,X) -> X;
valempty("2",S0,X) -> X bxor S0.

set({_,_, _, _}, [], Acc) -> Acc;
set({Op, I, X, Z}, [H|T], Acc) when I band Z /= I -> set({Op, I+1, X, Z}, T, Acc ++ [H]);
set({Op, I, X, Z}, [H|T], Acc) -> set({Op, I+1, X, Z}, T, Acc ++ [calc(Op, X, H)]).

calc("1", A, _) -> A;
calc(_, A, B) -> A bxor B.

getStart(Z, I) when Z band 1 =:= 1 -> I;
getStart(Z, I) -> getStart(Z bsr 1, I*2).

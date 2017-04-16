%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Aug 2016 7:52 AM
%%%-------------------------------------------------------------------
-module(e5b).
-author("r_harari").
-export([main/0]).

main() ->
  Lines = kbRead(),
  T1 = [binary_to_integer(C) || C <- Lines],
  {ok, [N,M]} = io:fread("", "~d~d"),
  A = ets:new('solution', [{read_concurrency, true}]),
  process(round(math:pow(2,N)),M,A,0).

process(_,0,_,_) -> ok;
process(N,M,A,S0) ->
  R = string:tokens(io:get_line(""), " "),
  C = lists:nth(1,R),
  execute(C, R, N, M, A, S0).

execute("3", R, N, M, A, S0) ->
  {ok, [Z], _} = io_lib:fread("~2u", lists:nth(2,R)),
  case Z of
    0 -> io:fwrite("~p~n", [S0]);
    _Else -> io:fwrite("~p~n", [getElem(A, Z)])
  end,
  process(N, M-1, A, S0);
execute(C, R, N, M, A, S0) ->
  {X, _} = string:to_integer(lists:nth(2,R)),
  {ok, [Z], _} = io_lib:fread("~2u", lists:nth(3,R)),
  set(C, Z, getStart(Z, 0), A, X, Z),
  process(N, M-1, A, valempty(C,X, S0)).

valempty("1",X,_) -> X;
valempty("2",X,Y) -> X bxor Y.

getElem(A, K) ->
  X = ets:lookup(A, K),
  case X of
    [] -> 0;
    _Else -> [{_,V}] = X, V
  end.

set(_,N, I, _, _, _) when I > N -> ok;
set(Op,N,I, A, X, Z) when I band Z /= I -> set(Op, N, I+1, A, X, Z);
set(Op,N,I, A, X, Z) ->
  case Op of
    "1" -> ets:insert(A, {I, X});
    "2" -> ets:insert(A, {I, getElem(A, I) bxor X})
  end,
  set(Op, N, I+1, A, X, Z).

getStart(Z, I) when Z band 1 =:= 1 -> I;
getStart(Z, I) -> getStart(Z bsr 1, I*2).

kbRead() ->
  B = getBin(),
  A = binary:split(B, [<<"\n">>, <<" ">>], [global]),
  T = [binary_to_list(C) || C <- A],
  T.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
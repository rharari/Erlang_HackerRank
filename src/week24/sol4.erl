%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Oct 2016 6:04 PM
%%%-------------------------------------------------------------------
-module(sol4).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> %%X1 = getBin(),
          X1 = <<"5 40\n1 2 3 4 5 6 7 8 9 4">>,
          X2 = binary:split(X1, [<<"\n">>, <<" ">>], [global]),
          [N, M | A] = [binary_to_integer(C) || C <- X2],
          case allZero(N,M) of
            true -> prt0(N);
            false -> go(M -1, A)
          end.

allZero(N, M) -> (M > N) andalso (N band (N-1) == 0).

go (0, A)  -> prt(A);
go (G, A) ->
  Fr = lists:nth(1, A),
  {B, AllZero} = doXor(Fr, A, [], true),
  case AllZero of
    true -> prt(B);
    false ->
      prt(B),
      go(G - 1, B)
  end.

prt0(0) -> io:format("0"), {ok};
prt0(G) -> io:format("0 "), prt0(G - 1).

prt([H|[]]) -> io:format("~p~n", [H]), {ok};
prt([H|T]) -> io:format("~p\t", [H]), prt(T).

doXor(Fr, [H|[]], Arr, AllZero) ->
  V = H bxor Fr,
  {Arr ++ [V], AllZero andalso V == 0};
doXor(Fr, [H|T], Arr, AllZero) ->
  V = H bxor lists:nth(1, T),
  doXor(Fr, T, Arr ++ [V], AllZero andalso V == 0 ).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.

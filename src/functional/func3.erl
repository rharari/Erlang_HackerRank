%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Mirko at the Construction Site
%%% @end
%%% Created : 03. Aug 2016 2:22 AM
%%%-------------------------------------------------------------------
-module(func3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {N,Q,H,I,D} = kbRead(),
          S = lists:seq(1,N),
          go(D,H,I,S).

go([],_,_,_) -> {ok};
go([Dh|Dt],H,I,S) ->
  A2 = lists:zipwith3(fun(A,B,C) -> {A + B * Dh, C} end, H, I, S),
  {_,Sa} = lists:max(A2),
  io:format("~p~n", [Sa]),
  go(Dt, H, I, S).

kbRead() ->
  B = getBin(),
  A = binary:split(B, [<<"\n">>, <<" ">>], [global]),
  T = [binary_to_list(C) || C <- A],
  T1 = [binary_to_integer(C) || C <- T],
  %% T1 = lists:map(fun s2i/1, T),
  {[N,Q], Tmp} = lists:split(2,T1),
  {H, Tmp2} = lists:split(N, Tmp),
  {I, D} = lists:split(N, Tmp2),
  {N,Q,H,I,D}.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
s2i(S) -> element(1,string:to_integer(S)).

%%getTall([], _, _, _, _, MaxPos) -> MaxPos;
%%getTall([H1|T1], [H2|T2], D, Max, Pos, MaxPos) ->
%%  C = H1 + H2 * D,
%%  case C >= Max of
%%    true -> getTall(T1, T2, D, C, Pos + 1, Pos);
%%    false -> getTall(T1, T2, D, Max, Pos + 1, MaxPos)
%%  end.
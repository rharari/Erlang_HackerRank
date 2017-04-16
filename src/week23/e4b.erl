%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Sep 2016 5:43 PM
%%%-------------------------------------------------------------------
-module(e4b).
-export([main/0]).

main() ->
  B = getBin(),
  [S|[M1]] = binary:split(B, [<<"\n">>], [global]),
  M = binary_to_integer(M1),
  io:format("~p", [trunc(M/calc(S)) rem 1000000007]).

calc(S) ->
  N = size(S),
  L2 = array:get(N-1, go(S, N, array:new(N, {default,0}), 1, 0)),
  case L2 > 0 andalso (N rem (N - L2)) == 0 of
    true -> N - L2;
    false -> N
  end.

go(_, M, PTS, I, _) when I == M -> PTS;
go(S, M, PTS, I, Len) ->
  case binary:at(S, I) == binary:at(S, Len) of
    true -> go(S, M, array:set(I, Len + 1, PTS ), I+1, Len+1);
    false -> case Len == 0 of
              true ->  go(S, M, PTS, I+1, Len);
              false -> go(S, M, PTS, I+1, array:get(Len -1, PTS))
             end
  end.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Feb 2017 21:57
%%%-------------------------------------------------------------------
-module(p2).
-author("rharari").

%% API
-export([main/0]).

main() -> L1 = binary:split(getBin(), [<<"\n">>], [global]),
  [_|L2] = [binary_to_integer(C) || C <- L1],
  L3 = lists:sort(L2),
  [io:format("~p~n",[X])|| X <- L3].

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
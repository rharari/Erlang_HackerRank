%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @doc
%%% Array DS
%%%
%%% @end
%%% https://www.hackerrank.com/challenges/arrays-ds
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> [_|L] = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
          [A|B] = lists:reverse(L),
          io:format("~s", [A]),
          lists:foreach(fun(X) -> io:format(" ~s", [X]) end, B).

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
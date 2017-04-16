%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. Aug 2016 11:00 AM
%%%-------------------------------------------------------------------
-module(test).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> B=lists:nth(1,[<<"3 6\n7 5 1\n1 2 3\n0\n1\n2\n3\n4\n5\n">>]),
          A = binary:split(B, [<<"\n">>, <<" ">>], [global]),
          A.


getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 28) of
               {ok, D} -> <<T/bytes, D/bytes>>;
               eof -> T
             end.
%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/big-sorting/problem
%%% Hackerrank - Big Sorting
%%% @end
%%%-------------------------------------------------------------------
-module(big_sorting).
-author("ricardo.harari@gmail.com").
-import(os, [getenv/1]).

%% API
-export([main/0]).

main() ->
  {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),
  A = binary:split(getBin(), [<<"\n">>], [global]),
  [_N|Arr] = [binary_to_list(C) || C <- A],
  Result = bigSorting(Arr),
  io:fwrite(Fptr, "~s~n", [lists:join("\n", Result)]),
  file:close(Fptr),
  ok.

bigSorting(Unsorted) -> lists:sort(fun string_len/2, Unsorted).

string_len(S1, S2) when erlang:length(S1) < erlang:length(S2) -> true;
string_len(S1, S2) when erlang:length(S1) =:= erlang:length(S2) -> S1 =< S2;
string_len(_S1, _S2) -> false.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.



%%                      print(Fptr, T).
%%% c("big_sorting.erl").
%%% big_sorting:main().
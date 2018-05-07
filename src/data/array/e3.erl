%%%-------------------------------------------------------------------
%%% @author ricardo a harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% sparse arrays
%%% @end
%%% https://www.hackerrank.com/challenges/sparse-arrays
%%%-------------------------------------------------------------------
-module(e3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> {ok, [N]} = io:fread("", "~d"),
          Tr = fillTree(gb_trees:empty(), N),
          {ok, [M]} = io:fread("", "~d"), print(Tr, M).

print(_, 0) -> ok;
print(Tr, M) -> {ok, [S]} = io:fread("", "~s"),
                case gb_trees:lookup(S, Tr) of
                  none -> io:fwrite("0~n");
                  {value, X} -> io:fwrite("~p~n", [X])
                end,
                print(Tr, M - 1).

fillTree(Tr, 0) -> Tr;
fillTree(Tr, N) -> {ok, [S]} = io:fread("", "~s"),
                   case gb_trees:lookup(S, Tr) of
                      none -> fillTree(gb_trees:enter(S, 1, Tr), N - 1);
                      {value, X} -> fillTree(gb_trees:enter(S, X + 1, Tr), N - 1)
                   end.
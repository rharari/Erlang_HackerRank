%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari - ricardo.harari@gmail.com
%%% @doc
%%% https://www.hackerrank.com/challenges/strange-grid/problem
%%% @end
%%% Created : Oct 2019 02:12
%%%-------------------------------------------------------------------
-module(strange_grid).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() -> { ok, [R,C]} = io:fread("", "~d~d"), io:format("~w", [get_value(R, C, R rem 2 =:= 0)]).

get_value(R, C, true) -> (R - 2) * 5 + 1 + (C - 1) * 2;
get_value(R, C, false) -> (R - 1) * 5 + (C - 1) * 2.
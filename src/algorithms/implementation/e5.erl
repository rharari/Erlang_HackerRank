%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% https://www.hackerrank.com/challenges/lisa-workbook - Lisa's Workbook
%%% @end
%%% Created : 13. Aug 2017 08:32
%%%-------------------------------------------------------------------
-module(e5).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() -> {ok, [I,J,K]} = io:fread("", "~d ~d ~d"), go(I, J, K, 0).

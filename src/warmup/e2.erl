%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. Aug 2016 3:01 AM
%%%-------------------------------------------------------------------
-module(e2).
-author("rharari").

%% API
-export([main/0]).

main() -> {ok, [S]} = io:fread("", "~s"),
          print(string:sub_string(S,1,8), string:sub_string(S,9,10)).
print([49,50|T],"AM") -> io:fwrite("00" ++ T);
print(S,"AM") -> io:fwrite(S);
print([49,50|T],"PM") -> io:fwrite("12" ++ T);
print(S,"PM") -> io:fwrite(integer_to_list((lists:nth(1, S) - 48 ) * 10 + lists:nth(2, S) - 36) ++ string:sub_string(S, 3)).


%%%-------------------------------------------------------------------
%%% @author ricardo alberto harari
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%% Hacker Rank
%%% https://www.hackerrank.com/challenges/migratory-birds/problem - Migratory Birds
%%% @end
%%% Created : 01. April 2018 18:32
%%%-------------------------------------------------------------------
-module(e6).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() ->
  %%% X = <<"6 1 4 4 4 5 3">>,
  A = binary:split(getBin(), [<<"\n">>, <<" ">>], [global]),
  [_|Lst] = A,
  {N1, N2, N3, N4, N5} = count({0,0,0,0,0}, Lst),
  print_result(N1, N2, N3, N4, N5).

print_result(N1, N2, N3, N4, N5) when N1 >= N2 andalso N1 >= N3 andalso N1 >= N4 andalso N1 >= N5 -> io:fwrite("1");
print_result(_, N2, N3, N4, N5) when N2 >= N3 andalso N2 >= N4 andalso N2 >= N5 -> io:fwrite("2");
print_result(_, _, N3, N4, N5) when N3 >= N4 andalso N3 >= N5 -> io:fwrite("3");
print_result(_, _, _, N4, N5) when N4 >= N5 -> io:fwrite("4");
print_result(_, _, _, _, _) -> io:fwrite("5").

count(Acc, []) -> Acc;
count({N1, N2, N3, N4, N5}, [<<"1">>|T]) -> count({N1 + 1, N2, N3, N4, N5}, T);
count({N1, N2, N3, N4, N5}, [<<"2">>|T]) -> count({N1, N2 + 1, N3, N4, N5}, T);
count({N1, N2, N3, N4, N5}, [<<"3">>|T]) -> count({N1, N2, N3 + 1, N4, N5}, T);
count({N1, N2, N3, N4, N5}, [<<"4">>|T]) -> count({N1, N2, N3, N4 + 1, N5}, T);
count({N1, N2, N3, N4, N5}, [<<"5">>|T]) -> count({N1, N2, N3, N4, N5 + 1}, T).


getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of
               {ok, D} -> getBin(<<T/bytes, D/bytes>>);
               eof -> T
             end.
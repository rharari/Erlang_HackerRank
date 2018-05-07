%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%% hacker rank - Lucky Purchase
%%% @end
%%% https://www.hackerrank.com/contests/w35/challenges/lucky-purchase
%%%-------------------------------------------------------------------
-module(e1).
-author("ricardo.harari@gmail.com").

%% API
-export([main/0]).

main() ->
  % X = <<"1 HackerBook 14217 l 99147 a 212717 b 27184214 c 271827187 d 37823728 e 4 f 4774">>,
  X = getBin(),
  [_|A] = binary:split(X, [<<"\n">>, <<" ">>], [global]),
  io:format("~s", [go(A, "-1", 999999999999)]), {ok}.

go([], Name, _) -> Name;
go([N,Vb|T], Name, V) ->
  V0 = binary_to_integer(Vb),
  case V0 =< V of
    false -> go(T, Name, V);
    true -> check(N, Vb, V0, Name, V, T)
  end.

check(N, Vb, V0, Name, V, T) ->
  {F1,F2} = count(binary_to_list(Vb), 0, 0),
  case F1 == F2 andalso F1 > 0 of
    true -> go(T, N, V0);
    false -> go(T, Name, V)
  end.

count([], A, B) -> {A, B};
count([52|T], A, B) -> count(T, A + 1, B);
count([55|T], A, B) -> count(T, A, B + 1);
count(_, _, _) -> {0,0}.

getBin()  -> io:setopts(standard_io, [binary]), getBin(<<>>).
getBin(T) -> case file:read(standard_io, 65536) of {ok, D} -> getBin(<<T/bytes, D/bytes>>); eof -> T  end.

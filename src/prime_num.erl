%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Jul 2016 9:08 AM
%%%-------------------------------------------------------------------
-module(prime_num).
-author("rharari").


-export([prime_numbers/1]).

% Sieve of Eratosthenes algorithm for finding all prime numbers up to N.
% http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

prime_numbers(N) when is_number(N) ->
  prime_numbers(N, generate(N)).

prime_numbers(Max, [H|T]) when H * H =< Max ->
  [H | prime_numbers(Max, [R || R <- T, (R rem H) > 0])];

prime_numbers(_, T) -> T.

generate(N) -> generate(N, 2).

generate(Max, Max) -> [Max];

generate(Max, X) -> [X | generate(Max, X + 1)].

%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. Aug 2016 3:21 AM
%%%-------------------------------------------------------------------
-module(int2).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  { ok, [_,M]} = io:fread("", "~d~d"),
  In = io:get_line(""),
  Prog = rdPrg(M, []),
  Mem = array:new({default,0}),
  try
    exec(In, Mem, Prog, [], {1, 1, 1})
  catch
    _:_ -> {ok}
  end.

exec(_, _, Prog, _, {Ln, _, Counter} ) when Counter > 100000 ->
  case length(Prog) < Ln of
    true -> {ok};
    false -> io:format("~nPROCESS TIME OUT. KILLED!!!"), throw(error)
  end;
exec(In, Mem, Prog, Stack, {Ln, Dpt, Counter} ) ->
  Cmd = lists:nth(Ln, Prog),
  case Cmd of
    $> -> exec(In, Mem, Prog, Stack, {Ln + 1, Dpt + 1, Counter+1});
    $< -> exec(In, Mem, Prog, Stack, {Ln + 1, Dpt -1, Counter+1});
    $+ -> exec(In, procMem(Mem, Dpt, 1), Prog, Stack, {Ln + 1, Dpt, Counter+1});
    $- -> exec(In, procMem(Mem, Dpt, -1), Prog, Stack, {Ln + 1, Dpt, Counter+1});
    $. -> io:format("~c", [array:get(Dpt, Mem)]), exec(In, Mem, Prog, Stack, {Ln + 1, Dpt, Counter+1});
    $, -> [H|T] = In, exec(T, array:set(Dpt, H, Mem), Prog, Stack, {Ln + 1, Dpt, Counter+1});
    $[ -> case array:get(Dpt, Mem) of
            0 -> Pos = floop(string:sub_string(Prog, Ln + 1), 0, 0, {$[, $]}),
                 exec(In, Mem, Prog, Stack, {Ln + Pos + 1 , Dpt, Counter + 2 });
            _ -> exec(In, Mem, Prog, [Ln | Stack], {Ln + 1, Dpt, Counter + 1})
          end;
    $] -> [Pos|Stack2] = Stack,
          case array:get(Dpt, Mem) of
            0 -> exec(In, Mem, Prog, Stack2, {Ln + 1, Dpt, Counter+1});
            _ -> exec(In, Mem, Prog, Stack2, {Pos, Dpt, Counter + 1 })
          end
  end.

floop([H|_], N, S, {_, C2}) when H == C2 andalso N == 0 -> S + 1;
floop([H|T], N, S, {C1, C2}) when H == C1 -> floop(T, N + 1, S + 1, {C1, C2});
floop([H|T], N, S, {C1, C2}) when H == C2 -> floop(T, N -1, S + 1, {C1, C2});
floop([_|T], N, S, {C1, C2}) -> floop(T, N, S + 1, {C1, C2}).

procMem(M, D, V) ->
  V2 = array:get(D, M) + V,
  case V2 of
    -1 -> array:set(D, 255, M);
    256 -> array:set(D, 0, M);
    _ -> array:set(D, V2, M)
  end.

rdPrg(0, Arr) -> Arr;
rdPrg(M, Arr) -> rdPrg(M -1, Arr ++ lists:filter(fun(X) -> lists:member(X, "><+-.,[]") end, io:get_line(""))).



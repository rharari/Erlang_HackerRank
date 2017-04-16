%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% While Language
%%% @end
%%% Created : 02. Aug 2016 11:03 PM
%%%-------------------------------------------------------------------
-module(int3).
-author("ricardo.harari@gmail.com").
-export([main/0]).

main() ->
  Prog = "fact := 1 ;val := 10000 ;", %%rdPrg([]),
  Mem = ets:new(memory, [named_table,ordered_set,private]),
  try
    exec(Mem, Prog, 1),
    print(Mem),
    ets:delete(memory)
  catch
    _:_ -> ets:delete(memory), {ok}
  end.

exec(Mem, Prog, Pos) -> {ok}.

printKey(Mem, '$end_of_table') -> {ok};
printKey(Mem, Key) ->
  Val = ets:lookup(Mem, Key),
  io:format("~s ~s", [Key, Val]),
  printKey(Mem, ets:next(Mem, Key)).

print(Mem) ->
  Key = ets:first(Mem),
  printKey(Mem, Key).


rdProg(B) ->
  case io:fread("", "~s") of
    eof -> B;
    {ok, [S]} -> rdProg(B ++ lists:filter(fun(X) -> not lists:member(X, " ") end,S))
  end.


putMem(Mem, Var, Val) -> ets:insert(Mem, {Var, Val}), {ok}.
getMem(Mem, Var) ->
  try
    {_, Val} = ets:lookup(Mem, Var), Val
  catch
    _:_ -> 0
  end.

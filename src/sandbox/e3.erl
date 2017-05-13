%%%-------------------------------------------------------------------
%%% @author rharari
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(e3).
-author("rharari").
-export([main/0, pong/0, ping/2, print/1]).

main() ->
  Pong_PID = spawn(e3, pong, []),
  spawn(e3, ping, [3, Pong_PID]),
  io:format("Ok"),
  Ref2 = spawn_set(2),
  Ref1 = spawn_set(1),
  Ref3 = spawn_set(3),
  L2 = receive_set(Ref2),
  L3 = receive_set(Ref3),
  L1 = receive_set(Ref1),
  {ok,Pong_PID}.

go(0) -> {ok};
go(N) ->
  Ref1 = spawn_set(N),
  L1 = receive_set(Ref1),
  go(N-1).

spawn_set(V) ->
  Ref = make_ref(),
  SelfPid = self(),
  spawn(fun() -> SelfPid ! {Ref, print(V), print(V)} end),
  Ref.

receive_set(Ref) ->
  receive
    {Ref, L} -> L
  end.

print(V) -> io:format("Valor -> ~p~n", [V]), {ok, "Valor=" ++ V}.


ping(0, Pong_PID) ->
  Pong_PID ! finished,
  io:format("ping finished~n", []);

ping(N, Pong_PID) ->
  Pong_PID ! {ping, self()},
  receive
    pong ->
      io:format("Ping received pong~n", [])
  end,
  ping(N - 1, Pong_PID).


pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Ping_PID} ->
      io:format("Pong received ping~n", []),
      Ping_PID ! pong,
      pong()
  end.

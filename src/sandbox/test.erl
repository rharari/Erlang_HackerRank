%%%-------------------------------------------------------------------
%%% @author rharari
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : Sep 2019
%%%-------------------------------------------------------------------
-module(test).
-author("rharari").

%% API
-export([go/0, count/2]).

go() -> G = digraph:new(),
        {ok, Device} = file:open("/temp/a.txt", [read]),
        try get_all_lines(Device, G)
          after file:close(Device)
        end,
        L = digraph_utils:strong_components(G),
        L2 = count(L, []),
        lists:sort(L2).
        % digraph_utils:cyclic_strong_components(G).

count([], Acc) -> Acc;
count([H|T], Acc) -> count(T, [length(H)] ++ Acc).

get_all_lines(Device, G) ->
  case io:get_line(Device, "") of
    eof  -> [];
    Line -> [A1, A2|_] = string:split(Line, " ", all),
            {N1, []} = string:to_integer(A1),
            {N2, []} = string:to_integer(A2),
            V1 = digraph:add_vertex(G, N1),
            V2 = digraph:add_vertex(G, N2),
            digraph:add_edge(G, V1, V2),
            get_all_lines(Device, G)
  end.
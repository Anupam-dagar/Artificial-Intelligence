:- use_module(library(clpfd)).

convert_int_to_char(1):-
    write('A').
convert_int_to_char(2):-
    write('B').
convert_int_to_char(3):-
    write('C').
convert_int_to_char(4):-
    write('D').
convert_int_to_char(5):-
    write('E').
convert_int_to_char(6):-
    write('F').
convert_int_to_char(7):-
    write('G').
convert_int_to_char(8):-
    write('H').
convert_int_to_char(9):-
    write('I').

printproblem([]).
printproblem([H|T]) :-
    printList(H),
    printproblem(T).

printList([]) :-
    nl.
printList([H|T]) :-
    convert_int_to_char(H),
    write(' | '),
    printList(T).

combinatorial(Matrix) :-
    flatten(Matrix, Numbers), Numbers ins 1..9,
    Rows = Matrix,
    transpose(Rows, Columns),
    blocks(Rows, Blocks),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
    maplist(label, Rows),
    printproblem(Matrix).

blocks([A, B, C, D, E, F, G, H, I], Blocks) :-
    blocks(A, B, C, Block1), blocks(D, E, F, Block2), blocks(G, H, I, Block3),
    append([Block1, Block2, Block3], Blocks).

blocks([], [], [], []).
blocks([A, B, C| BS1],[D, E, F| BS2],[G, H, I| BS3], [Block | Blocks]) :-
    Block = [A, B, C, D, E, F, G, H, I],
    blocks(BS1, BS2, BS3, Blocks).
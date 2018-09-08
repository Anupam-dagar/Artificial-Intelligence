start([3,2,1,0,0,0,left]).
end([0,0,0,3,2,1,right]).

% H refers to humans
% SM refers to small monkey
% BM refers to big monkey
% L and R refers to left and right respectively

is_ok(HL,SML,BML,HR,SMR,BMR) :-
    HL >= 0, SML >= 0, BML >= 0, HR >= 0, SMR >= 0, BMR >= 0,
    HL =< 3, SML =< 2, BML =< 1, HR =< 3, SMR =< 2, BMR =< 1,
    (HL >= SML + BML ; HL = 0),
    (HR >= SMR + BMR ; HR = 0).

% one big and one small monkey moves from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL, SML2, BML2, HR, SMR2, BMR2, right]):-
    SML2 is SML - 1,
    BML2 is BML - 1,
    SMR2 is SMR + 1,
    BMR2 is BMR + 1,
    is_ok(HL, SML2, BML2, HR, SMR2, BMR2). 

% one big and one small monkey moves from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL, SML2, BML2, HR, SMR2, BMR2, left]):-
    SML2 is SML + 1,
    BML2 is BML + 1,
    SMR2 is SMR - 1,
    BMR2 is BMR - 1,
    is_ok(HL, SML2, BML2, HR, SMR2, BMR2).

% two humans move from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL2, SML, BML, HR2, SMR, BMR, right]):-
    HL2 is HL - 2,
    HR2 is HR + 2,
    is_ok(HL2, SML, BML, HR2, SMR, BMR).

% two humans move from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL2, SML, BML, HR2, SMR, BMR, left]):-
    HL2 is HL + 2,
    HR2 is HR - 2,
    is_ok(HL2, SML, BML, HR2, SMR, BMR).

% one human and one big monkey moves from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL2, SML, BML2, HR2, SMR, BMR2, right]):-
    HL2 is HL - 1,
    BML2 is BML - 1,
    HR2 is HR + 1,
    BMR2 is BMR + 1,
    is_ok(HL2, SML, BML2, HR2, SMR, BMR2).

% one human and one big monkey moves from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL2, SML, BML2, HR2, SMR, BMR2, left]):-
    HL2 is HL + 1,
    BML2 is BML + 1,
    HR2 is HR - 1,
    BMR2 is BMR - 1,
    is_ok(HL2, SML, BML2, HR2, SMR, BMR2).

% one human and one small monkey moves from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL2, SML2, BML, HR2, SMR2, BMR, right]):-
    HL2 is HL - 1,
    HR2 is HR + 1,
    SML2 is SML - 1,
    SMR2 is SMR + 1,
    is_ok(HL2, SML2, BML, HR2, SMR2, BMR).

% one human and one small monkey moves from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL2, SML2, BML, HR2, SMR2, BMR, left]):-
    HL2 is HL + 1,
    HR2 is HR - 1,
    SML2 is SML + 1,
    SMR2 is SMR - 1,
    is_ok(HL2, SML2, BML, HR2, SMR2, BMR).

% one human moves from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL2, SML, BML, HR2, SMR, BMR, right]):-
    HL2 is HL - 1,
    HR2 is HR + 1,
    is_ok(HL2, SML, BML, HR2, SMR, BMR).

% one human moves from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL2, SML, BML, HR2, SMR, BMR, left]):-
    HL2 is HL + 1,
    HR2 is HR - 1,
    is_ok(HL2, SML, BML, HR2, SMR, BMR).

% one big monkey moves from right to left
move_from([HL, SML, BML, HR, SMR, BMR, right], [HL, SML, BML2, HR, SMR, BMR2, left]):-
    BML2 is BML + 1,
    BMR2 is BMR - 1,
    is_ok(HL,SML,BML2,HR,SMR,BMR2).

% one big monkey moves from left to right
move_from([HL, SML, BML, HR, SMR, BMR, left], [HL, SML, BML2, HR, SMR, BMR2, right]):-
    BML2 is BML - 1,
    BMR2 is BMR + 1,
    is_ok(HL,SML,BML2,HR,SMR,BMR2).

printanswer([]):- nl.
printanswer([[A,B] | Moves]):-
    printanswer(Moves),
    write(' Move from '), write(B), write(' --> '), write(' to '), write(A), nl.

state([HL,SML,BML,HR,SMR,BMR,Boat], [HL1,SML1,BML1,HR1,SMR1,BMR1,Boat1], Visited, List_of_moves):-
    move_from([HL,SML,BML,HR,SMR,BMR,Boat], [HL2,SML2,BML2,HR2,SMR2,BMR2,Boat2]),
    not(member([HL2,SML2,BML2,HR2,SMR2,BMR2,Boat2], Visited)),
    state([HL2,SML2,BML2,HR2,SMR2,BMR2,Boat2], [HL1,SML1,BML1,HR1,SMR1,BMR1,Boat1], [[HL2,SML2,BML2,HR2,SMR2,BMR2,Boat2]|Visited], [[[HL2,SML2,BML2,HR2,SMR2,BMR2,Boat2], [HL,SML,BML,HR,SMR,BMR,Boat]]|List_of_moves]).


state([0,0,0,3,2,1,right], [0,0,0,3,2,1,right], _, List_of_moves):-
    printanswer(List_of_moves).


solution:- state([3,2,1,0,0,0,left],[0,0,0,3,2,1,right],[[3,2,1,0,0,0,left]],_).
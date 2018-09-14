% input transformers  
  
% turns a term in which variables are repsentede as Prolog vars  
varvars(A,X):-
  must_be(ground,A),
  maxvar(A,L0),L is L0+1,
  functor(D,x,L),
  varvars(A,X,D).

varvars((A,B),(X->Y),D):-!,varvars(A,X,D),varvars(B,Y,D).
varvars(A->B,X->Y,D):-!,varvars(A,X,D),varvars(B,Y,D).
varvars(false,false,_):-!.
varvars(A,V,D):-I is A+1,arg(I,D,V).


% variable with larges index

maxvar(X,M):-var(X),!,M=0.
maxvar(false,M):-!,M=0.
maxvar((A->B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
maxvar((A v B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
maxvar((A & B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
maxvar((A <-> B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
maxvar((~A),R):-!,maxvar(A,R).
maxvar((A,B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
maxvar(I,R):-must_be(integer,I),R=I.

% turns a term into a ground one by banding
% logic variables in it to 0,1,...

natvars(T):-natvars(0,T).

natvars(Min,T):-
  must_be(acyclic,T),
  term_variables(T,Vs),
  length(Vs,L1),
  L1>0,
  !,
  L is L1-1,
  Max is Min+L,
  numlist(Min,Max,Vs).
natvars(_,_).

% same, but throws in atom "false"
% as first variable to bind
classvars(T):-
  must_be(acyclic,T),
  term_variables(T,[false|Vs]),
  length(Vs,L1),
  L is L1-1,
  numlist(0,L,Vs).  
  
imp2eqs(Imp,R-Es):-imp2eqs(Imp,R,Es,[]).

imp2eqs(A->B,R)-->!,
  imp2eqs(A,X),
  imp2eqs(B,Y),
  [R=X-Y].
imp2eqs(A,A)-->[].


false2neg(false,R):-!,R = ~ (0->0).
false2neg(X,R):-atomic(X),!,R=X.
false2neg((X->false),R):-!,false2neg(X,A),R= ~A.
false2neg((X->Y),(A->B)):-false2neg(X,A),false2neg(Y,B).

ftest1:-
  tautology(0 -> 1 ->0),
  tautology( ~ ~ 0 -> 0),
  tautology((0->1->2)->(0->1)->0->2).
  
flattenImpl(A,B,Bs):-
  maxvar(A,M),
  flattenImpl(A,B,0,Vs,[]),
  name_vars(Vs,M,Bs,[]).
  
name_vars([],_)-->[].
name_vars([(I1=T)|Vs],I)-->{I1 is I+1},[(I1->T),(T->I1)],name_vars(Vs,I1).  


flattenImpl(A,A,_)-->{atomic(A)},!.
flattenImpl(A->B,A->B,_)-->{atomic(A),atomic(B)},!.
flattenImpl((A->(B->C)),(A->(B->C)),0)-->{atomic(A),atomic(B),atomic(C)},!.
flattenImpl(((A->B)->C),((A->B)->C),0)-->{atomic(A),atomic(B),atomic(C)},!.

flattenImpl((A->B),(A->H),D)-->{atomic(A),DB is D+1},!,[H=BB],flattenImpl(B,BB,DB).

flattenImpl(A->B,H->B,D)-->{atomic(B),DA is D+1},!,[H=AA],
  flattenImpl(A,AA,DA).
flattenImpl(A->B,H->G,D)-->[H=AA],[G=BB],{DD is D+1},
  flattenImpl(A,AA,DD),flattenImpl(B,BB,DD).

flattenFull(T0,R,Bs):-
  expand_full_neg(T0,T),
  flattenFull(T,R0,[],Es0),
  ( atomic(R0)->R=R0,Es=Es0
  ; R=X,Es=[X=R0|Es0]
  ),
  expand_vars(Es,100,Bs,[]),
  show_expanded(R,Bs),
  true.

show_expanded(T,Es):-
  nl,
  write(T),write(':-'),nl,
  do((
    member(E,Es),
    tab(2),
    writeln(E)
  )).
  
  
%flattenFull(A&B,R,Es1,Es2):-(atomic(A))
flattenFull(A<->B,R,Es1,Es2):-!,
  flattenFull((A->B)&(B->A),R,Es1,Es2).
flattenFull(OpAB,R,Es1,Es4):-compound(OpAB),!,
  OpAB=..[Op,A,B],
  ( atomic(A),atomic(B)->X=A,Y=B,Es1=Es4
  ; atomic(A)->X=A,flattenFull(B,FB,Es1,Es2),Es4=[Y=FB|Es2]
  ; atomic(B)->Y=B,flattenFull(A,FA,Es1,Es2),Es4=[X=FA|Es2]
  ; flattenFull(A,FA,Es1,Es2),
    flattenFull(B,FB,Es2,Es3),
    Es4=[X=FA,Y=FB | Es3]
  ),
  R=..[Op,X,Y].
flattenFull(A,A,Es,Es).

expand_vars([],_)-->[].
expand_vars([(I1=T)|Vs],I)-->
  {I1 is I+1},
  expand_eq((I1->T)),
  expand_eq((T->I1)),
  expand_vars(Vs,I1).  

%expand_eq(E)-->{ppp(E),fail}.
expand_eq((A&B->C))-->!,[(A->B->C)].
expand_eq((A->B&C))-->!,[(A->B),(A->C)].
expand_eq((C v D -> B)) -->!,[(C->B),(D->B)].
expand_eq(E)-->[E].

  
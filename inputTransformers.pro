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

maxvar(false,0):-!.
maxvar((A->B),R):-!,maxvar(A,I),maxvar(B,J),R is max(I,J).
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

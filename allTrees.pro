% Generates all trees of with N internal nodes and
% it  collects their leaves to a list of logic variables

genTree(N,Tree,Leaves):-genTree(Tree,N,0,Leaves,[]).

genTree(V,N,N)-->[V].
genTree((A->B),SN1,N3)-->{SN1>0,N1 is SN1-1},
  genTree(A,N1,N2),
  genTree(B,N2,N3).

% OEIS 1,2,5,14,42,132,429,1430,4862,16796 
genHorn(N,Tree,Leaves):-genHorn(Tree,N,0,Leaves,[]).

genHorn(V,N,N)-->[V].
genHorn((A:-[B|Bs]),SN1,N3)-->{succ(N1,SN1)},
  [A],
  genHorn(B,N1,N2),
  genHorns(Bs,N2,N3).
  
genHorns([],N,N)-->[].
genHorns([B|Bs],SN1,N3)-->{succ(N1,SN1)},
  genHorn(B,N1,N2),
  genHorns(Bs,N2,N3).

countGenHorn(M,Rs):-
  findall(R,(
    between(1,M,N),
    sols(genHorn(N,_,_),R)
  ),Rs).
  
/*  
% [1,2,7,38,266,2263,22300,247737]
genSortedHorn(N,Tree,Leaves):-
  genSortedHorn(Tree,N,0,Leaves,[]).

genSortedHorn(V,N,N)-->[V].
genSortedHorn((A:-[B|Bs]),SN1,N3)-->{succ(N1,SN1)},
  [A],
  genSortedHorn(B,N1,N2),
  genSortedHorns(Bs,N2,N3),
  {sorted([B|Bs])}.
  
genSortedHorns([],N,N)-->[].
genSortedHorns([B|Bs],SN1,N3)-->{succ(N1,SN1)},
  genSortedHorn(B,N1,N2),
  genSortedHorns(Bs,N2,N3).
  
sorted([]):-!.
sorted([_]):-!.
sorted([X,Y|Xs]):-X@<Y,sorted([Y|Xs]).  
*/

% A105633: [1,2,4,9,22,57,154,429,1223,3550,10455,31160,93802,284789]
genSortedHorn(N,Tree,Leaves):-
  genSortedHorn(Tree,N,0,Leaves,[]).

genSortedHorn(V,N,N)-->[V].
genSortedHorn((A:-[B|Bs]),SN1,N3)-->{succ(N1,SN1)},
  [A],
  genSortedHorn(B,N1,N2),
  genSortedHorns(B,Bs,N2,N3).
  
genSortedHorns(_,[],N,N)-->[].
genSortedHorns(B,[C|Bs],SN1,N3)-->{succ(N1,SN1)},
  genSortedHorn(C,N1,N2),
  {B@<C},
  genSortedHorns(C,Bs,N2,N3).
  
genSortedHorn3(N,Tree,Leaves):-
  genSortedHorn3(3,Tree,N,0,Leaves,[]).

genSortedHorn3(_,V,N,N)-->[V].
genSortedHorn3(SK,(A:-[B|Bs]),SN1,N3)-->{succ(N1,SN1),succ(K,SK)},
  [A],
  genSortedHorn3(K,B,N1,N2),
  genSortedHorn3s(SK,B,Bs,N2,N3).
  
genSortedHorn3s(_,_,[],N,N)-->[].
genSortedHorn3s(K,B,[C|Bs],SN1,N3)-->{succ(N1,SN1)},
  genSortedHorn3(K,C,N1,N2),
  {B@<C},
  genSortedHorn3s(K,C,Bs,N2,N3).

% 1,2,4,8,20,47,122,316,845,2284,6264,17337,48424,136196,385548  
countSortedHorn3(M,Rs):-
  findall(R,(
    between(1,M,N),
    sols(genSortedHorn3(N,_,_),R)
    ),Rs).  


genHorn3(N,Tree):-
  genHorn3(3,Tree,N,0).

genHorn3(_,_V,N,N).
genHorn3(SK,(_A:-[B|Bs]),SN1,N3):-succ(N1,SN1),succ(K,SK),
  genHorn3(K,B,N1,N2),
  genHorn3s(SK,B,Bs,N2,N3).
  
genHorn3s(_,_,[],N,N).
genHorn3s(K,_B,[C|Bs],SN1,N3):-succ(N1,SN1),
  genHorn3(K,C,N1,N2),
  genHorn3s(K,C,Bs,N2,N3).

% [1,1,2,5,13,37,109,331,1027,3241,10367,33531,109463] this
% [1,1,2,5,14,42,132,429,1430,4862,16796,58786,208012] vs Catalans
countHorn3(M,Rs):-
  findall(R,(
    between(1,M,N),
    sols(genHorn3(N,_),R)
    ),Rs).  
  

genOpTree(N,Tree,Leaves):-genOpTree(N,[(~),(->),(<->),(&),(v)],Tree,Leaves).

genOpTree(N,Ops,Tree,Leaves):-genTree(Ops,Tree,N,0,Leaves,[]).

genTree(_,V,N,N)-->[V].
genTree(Ops,~A,SN1,N2)-->{memberchk((~),Ops),SN1>0,N1 is SN1-1},
  genTree(Ops,A,N1,N2).
genTree(Ops,OpAB,SN1,N3)-->
  { SN1>0,N1 is SN1-1,
    member(Op,Ops),Op\=(~),make_op(Op,A,B,OpAB)
  },
  genTree(Ops,A,N1,N2),
  genTree(Ops,B,N2,N3).
  
make_op(Op,A,B,OpAB):-functor(OpAB,Op,2),arg(1,OpAB,A),arg(2,OpAB,B).


genSortedTree(N,Tree,Leaves):-
   genSortedTree(N,[(~),(->)],[(<->),(&),(v)],
   Tree,Leaves).

genSortedTree(N,Ops,Cops,Tree,Leaves):-
  genSortedTree(Ops,Cops,Tree,N,0,Leaves,[]).

genSortedTree(_,_,V,N,N)-->[V].
genSortedTree(Ops,Cops,~A,SN1,N2)-->
  {memberchk((~),Ops),SN1>0,N1 is SN1-1},
  genSortedTree(Ops,Cops,A,N1,N2).
genSortedTree(Ops,Cops,OpAB,SN1,N3)-->
  {SN1>0,N1 is SN1-1,
    member(Op,Ops),Op\=(~),make_op(Op,A,B,OpAB)
  },
  genSortedTree(Ops,Cops,A,N1,N2),
  genSortedTree(Ops,Cops,B,N2,N3).
genSortedTree(Ops,Cops,OpAB,SN1,N3)-->
  {SN1>0,N1 is SN1-1,member(Op,Cops),make_op(Op,A,B,OpAB)},
  genSortedTree(Ops,Cops,A,N1,N2),
  genSortedTree(Ops,Cops,B,N2,N3),
  {A@<B}.
  

 genTrimmedTree(N,Tree,Leaves):-
   genTrimmedTree(N,[(->)],[(<->),(&),(v)],Tree,Leaves).
 
add_neg_ops(OpAB,OpAB,N,N).
add_neg_ops(OpAB,~OpAB,SN,N):-succ(N,SN).
add_neg_ops(OpAB, ~ ~OpAB,SSN,N):-SSN>1,N is SSN-2.

genTrimmedTree(N,Ops,Cops,Tree,Leaves):-
  genTrimmedTree(Ops,Cops,Tree,N,0,Leaves,[]). 

%genTrimmedTree(_,_,T,N,_)-->{ppp(N:T),fail}.
genTrimmedTree(_,_,V,N1,N2)-->[V0],
  {add_neg_ops(V0,V,N1,N2)}.
genTrimmedTree(Ops,Cops,OpAB,SN1,N4)-->
  { SN1>0,N1 is SN1-1,
    member(Op,Ops),make_op(Op,A,B,OpAB0),
    add_neg_ops(OpAB0,OpAB,N1,N2)
  },
  genTrimmedTree(Ops,Cops,A,N2,N3),
  genTrimmedTree(Ops,Cops,B,N3,N4).
genTrimmedTree(Ops,Cops,OpAB,SN1,N4)-->
  { SN1>0,N1 is SN1-1,
    member(Op,Cops),
    make_op(Op,A,B,OpAB0),
    add_neg_ops(OpAB0,OpAB,N1,N2)
  },
  genTrimmedTree(Ops,Cops,A,N2,N3),
  genTrimmedTree(Ops,Cops,B,N3,N4),
  {A@<B}.  
  

% [1,5,10,49,134,614,1996,8773,31590,135898,521188,2221802]
% Motzkin trees, with binary nodes 4-colored and unary nodes
countFull(M,Rs):-
  findall(R,(
    between(0,M,N),
    sols(genOpTree(N,_,_),R)
    ),Rs).  
  
countFullSorted(M,Rs):-
  findall(R,(
    between(0,M,N),
    sols(genSortedTree(N,_,_),R)
    ),Rs).     
    
countFullTrimmed(M,Rs):-
  findall(R,(
    between(0,M,N),
    sols(genTrimmedTree(N,_,_),R)
    ),Rs).    
    
   
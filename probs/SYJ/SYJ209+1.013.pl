%--------------------------------------------------------------------------
% File     : SYJ209+1.013 : ILTP v1.1.2
% Domain   : Intuitionistic Syntactic
% Problem  : Formulae requiring many contractions
% Version  : Especial.
%            Problem formulation : Inuit. Invalid.   Size 13
% English  : ((&&_{i-1..N} p(i) v ~~p(1)->f v vv_{i-2..N} (p(i)->f))->f)->f

% Refs     : [Dyc97] Roy Dyckhoff. Some benchmark formulas for
%                    intuitionistic propositional logic. At
%                    http://www.dcs.st-and.ac.uk/~rd/logic/marks.html
%          : [Fr88]  T. Franzen, Algorithmic Aspects of intuitionistic
%                    propositional logic, SICS Research Report R87010B,
%                    1988.
%          : [Fr89]  T. Franzen, Algorithmic Aspects of intuitionistic
%                    propositional logic II, SICS Research Report
%                    R-89/89006, 1989.
% Source   : [Dyc97]
% Names    : con_n13 : Dyckhoff's benchmark formulas (1997)
%
% Status (intuit.) : Unsolved
% Rating (intuit.) : 1.00 v1.0.0
%

% Comments : "proof in LJ needs n contractions" [Dyc97]
%--------------------------------------------------------------------------
fof(axiom1,axiom,(
( ( ( p1 & ( p2 & ( p3 & ( p4 & ( p5 & ( p6 & ( p7 & ( p8 & ( p9 & ( p10 & ( p11 & ( p12 & p13 ) ) ) ) ) ) ) ) ) ) ) ) v ( ( ~(~(p1)) -> f)  v ( ( p2 -> f)  v ( ( p3 -> f)  v ( ( p4 -> f)  v ( ( p5 -> f)  v ( ( p6 -> f)  v ( ( p7 -> f)  v ( ( p8 -> f)  v ( ( p9 -> f)  v ( ( p10 -> f)  v ( ( p11 -> f)  v ( ( p12 -> f)  v ( p13 -> f)  ) ) ) ) ) ) ) ) ) ) ) ) ) -> f) )).

fof(con,conjecture,(
f
)).

%--------------------------------------------------------------------------

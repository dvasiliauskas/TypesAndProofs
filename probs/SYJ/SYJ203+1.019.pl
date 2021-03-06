%--------------------------------------------------------------------------
% File     : SYJ203+1.019 : ILTP v1.1.2
% Domain   : Intuitionistic Syntactic
% Problem  : Formulae requiring many contractions
% Version  : Especial.
%            Problem formulation : Intuit. Valid  Size 19
% English  : (((&&_{i-1..N} p(i)) v (vv_{i-1..N} (p(i)->f)))->f)->f

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
% Names    : con_p19 : Dyckhoff's benchmark formulas (1997)
%
% Status (intuit.) : Theorem
% Rating (intuit.) : 0.00 v1.0.0
%

% Comments : "proof in LJ needs n contractions" [Dyc97]
%--------------------------------------------------------------------------
fof(axiom1,axiom,(
( ( ( p1 & ( p2 & ( p3 & ( p4 & ( p5 & ( p6 & ( p7 & ( p8 & ( p9 & ( p10 & ( p11 & ( p12 & ( p13 & ( p14 & ( p15 & ( p16 & ( p17 & ( p18 & p19 ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) v ( ( p1 -> f)  v ( ( p2 -> f)  v ( ( p3 -> f)  v ( ( p4 -> f)  v ( ( p5 -> f)  v ( ( p6 -> f)  v ( ( p7 -> f)  v ( ( p8 -> f)  v ( ( p9 -> f)  v ( ( p10 -> f)  v ( ( p11 -> f)  v ( ( p12 -> f)  v ( ( p13 -> f)  v ( ( p14 -> f)  v ( ( p15 -> f)  v ( ( p16 -> f)  v ( ( p17 -> f)  v ( ( p18 -> f)  v ( p19 -> f)  ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) -> f) )).

fof(con,conjecture,(
f
)).

%--------------------------------------------------------------------------

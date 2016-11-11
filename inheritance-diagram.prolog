/* typeはHaskellで定義しうる全ての型です。 */

/* nullitypeはカインド(*)を持つ全ての型です。unitypeはカインド(* -> *)を持つ全ての型です。以下、dutype、tritypeと続きます。 */

/* Non Source Code */

ex(type, unitype).

ex(type, nullitype).

ex(type, dutype).

ex(type, tritype).

/* Wrapper */

ex(unitype, wrapper).

ex(unitype, unwrapper).

ex(wrapper, identity).
ex(unwrapper, identity).

/* Conquer */

ex(unitype, conquer).

ex(unitype, unquer).

ex(conquer, contity).
ex(unquer, contity).

/* Functor */

ex(unitype, invariant).

ex(invariant, functor).

ex(invariant, contravariant).

ex(functor, nonvariant).
ex(contravariant, nonvariant).

/* Monad */

ex(wrapper, pointed).
ex(functor, pointed).

ex(functor, apply).

ex(pointed, applicative).
ex(apply, applicative).

ex(apply, bind).

ex(applicative, monad).
ex(bind, monad).

/* Comonad */

ex(unwrapper, copointed).
ex(functor, copointed).

ex(functor, coapply).

ex(copointed, extract).
ex(coapply, extract).

ex(coapply, extend).

ex(extract, comonad).
ex(extend, comonad).

/* Divide */

ex(conquer, contrapointed).
ex(contravariant, contrapointed).

ex(contravariant, divide).

ex(contrapointed, divisible).
ex(divide, divisible).


/* Codivide */

ex(unquer, untrapointed).
ex(contravariant, untrapointed).

ex(contravariant, codivide).

ex(untrapointed, codivisible).
ex(codivide, codivisible).

/* Semigroupoid */

ex(dutype, semigroupoid).

/* ソースコードに含まれない関係 */

/* 圏論における余の関係 */
co(invariant, invariant).

co(functor, functor).
co(wrapper, unwrapper).
co(apply, coapply).
co(pointed, copointed).
co(bind, extend).
co(applicative, extract).
co(monad, comonad).

co(contravariant, contravariant).
co(conquer, unquer).
co(divide, codivide).
co(contrapointed, untrapointed).
co(divisible, codivisible).

/* 圏論における反変の関係 */
contra(invariant, invariant).
contra(functor, contravariant).

contra(wrapper, conquer).
contra(apply, divide).
contra(pointed, contrapointed).
contra(applicative, divisible).

contra(unwrapper, unquer).
contra(coapply, codivide).
contra(copointed, untrapointed).
contra(extract, codivisible).

/* 同値関係 */
eq(unitype, unquer).
eq(conquer, contity).
eq(contravariant, untrapointed).
eq(codivide, codivisible).

/* contact - Yから二項関係をたどってZに到達出来るかどうか調べる */
contact(X, Y, Z) :- call(X,Y,Z);
                    call(X,Y,W), contact(X,W,Z).

/* cl - 二つの値が等しい場合を除く */
cl(X, Y, Z) :- call(X, Y, Z), Y \= Z.

/* bind - 二つの値がXにより結びついているかどうか調べる */
bind(X,Y,Z) :- call(X,Y,Z); call(X,Z,Y).

/* brother - YとZが兄弟かどうか調べる */
brother(X, A, Y, Z) :- cl(X, A, Y), cl(X, A, Z), Y \= Z.

/* rehtorb - YとZが共通の子を持つかどうか調べる */
rehtorb(X, Y, Z, A) :- cl(X, Y, A), cl(X, Z, A), Y \= Z.

/* diamond - 菱形継承パターンが存在するか調べる */
diamond(X, A, B, C, D) :- brother(X, A, B, C), rehtorb(X, B, C, D), A \= D.

/* diamond3 - 三つに分かれた継承パターンが存在するか調べる */
diamond3(W, A, X, Y, Z, B) :- diamond(W,A,X,Y,B),diamond(W,A,Y,Z,B), X \= Z.

/* radderX - 梯子型の継承パターンが存在するか調べる。
   
   A -> B -> C 
   |    |    | 
   v    v    v 
   D -> E -> F 

   こういうの */
radder2(X, A, A_, B, B_, C, C_) :- diamond(X,A,A_,B,B_), diamond(X,B,B_,C,C_), A \= C, A \= C_, A_ \= C, A_ \= C_.

radder3(X,A,A_,B,B_,C,C_,D,D_) :- radder2(X,A,A_,B,B_,C,C_), radder2(X,B,B_,C,C_,D,D_), A \= D, A \= D_, A_ \= D, A_ \= D_.
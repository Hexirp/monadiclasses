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

/* ソースコードに含まれない関係 */

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

contra(functor, contravariant).

contra(wrapper, conquer).
contra(apply, divide).
contra(pointed, contrapointed).
contra(applicative, divisible).

contra(unwrapper, unquer).
contra(coapply, codivide).
contra(copointed, untrapointed).
contra(extract, codivisible).
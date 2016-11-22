{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Functor.Monad.Continuation (
    Continuation(..)
) where
    import Structure.Function
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Functor.Monad

    class (Monad m) => Continuation m where
        callCC :: ((a -> m b) -> m a) -> m a
        callCC = undefined
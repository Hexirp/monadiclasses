{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Functor.Monad.Failure (
    Failure(..)
) where
    import Prelude (String)
    import Structure.Function
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Functor.Monad

    class (Monad m) => Failure m where
        fail :: String -> m a
        fail = undefined
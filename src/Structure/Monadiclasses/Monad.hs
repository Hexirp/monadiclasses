{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Monad (
    Apply(..),
    Pointed(..),
    Bind(..),
    Applicative(..),
    Monad(..)
) where
    import Structure.Monadiclasses.Function
    import Structure.Monadiclasses.Unit
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor

    class (Functor f) => Apply f where
        fapp :: f (a -> b) -> f a -> f b
        fapp = lift2 ($)

        lift2 :: (a -> b -> c) -> f a -> f b -> f c
        lift2 f x y = fmap f x `fapp` y

        cift2 :: (And and) => (and a b -> c) -> and (f a) (f b) -> f c
        cift2 = uncurry . lift2 . curry

    class (Apply f) => Bind f where
        bind :: (a -> f b) -> (f a -> f b)
        bind f = join . fmap f

        join :: f (f a) -> f a
        join = bind id

    class (Wrapper f, Functor f) => Pointed f where
        --

    class (Pointed f, Apply f) => Applicative f where
        --

    class (Applicative f, Bind f) => Monad f where
        --
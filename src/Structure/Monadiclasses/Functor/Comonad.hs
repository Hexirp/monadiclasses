{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Functor.Comonad (
    Coapply(..),
    Copointed(..),
    Extend(..),
    Extract(..),
    Comonad(..)
) where
    import Structure.Monadiclasses.Function
    import Structure.Monadiclasses.Unit
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor

    class (Functor f) => Coapply f where
        cict2 :: (Or or) => (or a b -> c) -> or (f a) (f b) -> f c
        cict2 = undefined

    class (Coapply f) => Extend f where
        extend :: (f a -> b) -> (f a -> f b)
        extend f = fmap f . extract

        extract :: f a -> f (f a)
        extract = extend id

    class (Unwrapper f, Functor f) => Copointed f where
        --

    class (Copointed f, Coapply f) => Extract f where
        --

    class (Extract f, Extend f) => Comonad f where
        --
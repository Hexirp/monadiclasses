{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Functor.Comonad (
    Coapply(..),
    Copointed(..),
    Extend(..),
    Extract(..),
    Comonad(..)
) where
    import Structure.Function
    import Structure.Commutative
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor

    class (Functor f) => Coapply f where
        cict2 :: (Disum t) => (t a b -> c) -> t (f a) (f b) -> f c
        cict2 = undefined

    class (Coapply f) => Extend f where
        extend :: (f a -> b) -> (f a -> f b)
        extend f = fmap f . duplicate

        duplicate :: f a -> f (f a)
        duplicate = extend id

    class (Unwrapper f, Functor f) => Copointed f where
        --

    class (Copointed f, Coapply f) => Extract f where
        --

    class (Extract f, Extend f) => Comonad f where
        --
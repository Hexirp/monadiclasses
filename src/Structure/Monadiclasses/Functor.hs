{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Functor (
    Invariant(..),
    Functor(..),
    Contravariant(..),
    Nonvariant(..)
) where 
    import Structure.Monadiclasses.Function

    class Invariant f where
        invar :: (a -> a) -> (a -> f a)
        invar = undefined

    class (Invariant f) => Functor f where
        fmap :: (a -> b) -> (f a -> f b)
        fmap = undefined

    class (Invariant f) => Contravariant f where
        contra :: (a -> b) -> (f b -> f a)
        contra = undefined

    class (Functor f, Contravariant f) => Nonvariant f where
        --
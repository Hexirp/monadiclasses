{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Contravariant.Codivide (
    Codivide(..),
    Untrapointed(..),
    Codivisible(..)
) where
    import Structure.Function
    import Structure.Commutative
    import Structure.Monadiclasses.Conquer
    import Structure.Monadiclasses.Functor

    class (Contravariant f) => Codivide f where
        codivide :: (Disum t) => (c -> t a b) -> (t (f a) (f b) -> f c)
        codivide = undefined

    class (Unquer f, Contravariant f) => Untrapointed f where
        --

    class (Untrapointed f, Codivide f) => Codivisible f where
        --
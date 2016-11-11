{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Contravariant.Divide (
    Divide(..),
    Contrapointed(..),
    Divisible(..)
) where
    import Structure.Function
    import Structure.Commutative
    import Structure.Monadiclasses.Conquer
    import Structure.Monadiclasses.Functor

    class (Contravariant f) => Divide f where
        divide :: (Diproduct t0, Diproduct t1) => (t0 a b -> c) -> (f c -> t1 (f a) (f b))
        divide = undefined

    class (Conquer f, Contravariant f) => Contrapointed f where
        --

    class (Contrapointed f, Divide f) => Divisible f where
        --
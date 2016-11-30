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
        divide :: (Diproduct t) => (c -> t a b) -> (t (f a) (f b) -> f c)
        divide = undefined

    class (Conquer f, Contravariant f) => Contrapointed f where
        --

    class (Contrapointed f, Divide f) => Divisible f where
        --
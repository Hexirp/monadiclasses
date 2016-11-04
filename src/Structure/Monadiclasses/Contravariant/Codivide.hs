{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Contravariant.Codivide (
    Codivide(..),
    Untrapointed(..),
    Codivisible(..)
) where
    import Structure.Monadiclasses.Function
    import Structure.Monadiclasses.Unit
    import Structure.Monadiclasses.Conquer
    import Structure.Monadiclasses.Functor

    class (Contravariant f) => Codivide f where
        codivide :: (Or or) => (or a b -> c) -> (f c -> or (f a) (f b))
        codivide = undefined

    class (Unquer f, Contravariant f) => Untrapointed f where
        --

    class (Untrapointed f, Codivide f) => Codivisible f where
        --
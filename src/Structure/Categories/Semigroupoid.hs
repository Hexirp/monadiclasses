{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Categories.Semigroupoid (
    Semigroupoid(..),
    Category(..),
    Parallel(..)
) where
    import Structure.Function (undefined)
    import Structure.Commutative

    class Semigroupoid arr where
        compose :: arr b c -> arr a b -> arr a c
        compose = undefined

    class (Semigroupoid arr) => Category arr where
        id :: arr a a
        id = undefined

    class Parallel arr where
        first :: (Diproduct and) => arr a b -> arr (and a c) (and b c)
        first = undefined

        second :: (Diproduct and) => arr a b -> arr (and a c) (and b c)
        second = undefined
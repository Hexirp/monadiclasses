{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Categories.Semigroupoid (
    Semigroupoid(..)
) where
    import Structure.Function

    class Semigroupoid arr where
        compose :: arr b c -> arr a b -> arr a c
        compose = undefined
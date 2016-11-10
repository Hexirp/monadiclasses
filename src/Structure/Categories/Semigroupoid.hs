{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Categories.Semigroupoid (
    Semigroupoid(..)
) where
    import Structure.Function
    import Structure.Unit

    class Semigroupoid arr where
        compose :: arr b c -> arr a b -> arr a c
        compose = undefined
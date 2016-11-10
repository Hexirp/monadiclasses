{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Wrapper (
    Wrapper(..),
    Unwrapper(..),
    Identity(..)
) where
    import Structure.Function
    import Structure.Unit

    class Wrapper f where
        wrap :: a -> f a
        wrap = undefined
        -- wrap = wrap' . const

        wrap' :: (Unit t) => (t -> a) -> f a
        wrap' = wrap . ($ unit)

    class Unwrapper f where
        unwrap :: f a -> a
        unwrap = undefined
        -- unwrap = ($ unit) . unwrap'

        unwrap' :: (Unit t) => f a -> (t -> a)
        unwrap' = const . unwrap

    class (Wrapper f, Unwrapper f) => Identity f where
        --
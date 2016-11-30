{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Function where
    import qualified GHC.Err as Err (undefined)

    undefined :: a
    undefined = Err.undefined

    const :: a -> b -> a
    const = \a -> \_ -> a

    infixr 0 $
    ($) :: (a -> b) -> a -> b
    ($) = id

    id :: a -> a
    id = \a -> a

    infixr 9 .
    (.) :: (a -> b) -> (c -> a) -> c -> b
    (.) = \f -> \g -> \x -> f (g x)

    copy :: (a -> a -> b) -> a -> b
    copy = \f -> \a -> f a a

    flip :: (a -> b -> c) -> b -> a -> c
    flip f x y = f y x
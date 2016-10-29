{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Function where
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
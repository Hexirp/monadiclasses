{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Conquer (
    Conquer(..),
    Unquer(..),
    Contity(..)
) where
    import Structure.Monadiclasses.Function
    import Structure.Monadiclasses.Unit

    class Conquer f where
        conquer :: f a
        conquer = undefined

        conquer' :: (Unit t) => (a -> t) -> f a
        conquer' = const $ conquer

    class Unquer f where
        -- 本来はここに書かれるべきだがGHCの警告に従い型クラスの構成要素から外す
        -- unquer :: (Unit t) => t
        -- unquer = undefined

        unquer' :: (Unit t) => f a -> (a -> t)
        unquer' = const $ const $ unit

    unquer :: (Unit unit) => unit
    unquer = unit

    class Contity f where
        --
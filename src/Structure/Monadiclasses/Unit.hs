{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Unit where
    import Structure.Monadiclasses.Function

    -- | ()を抽象化した型クラス
    class Unit t where
        unit :: t
        unit = undefined

    instance Unit () where
        unit = ()

    -- | 交換可能な値
    class Swap s where
        swap :: s a b -> s b a
        swap = undefined

    -- (,)を抽象化したクラス
    class (Swap and) => And and where
        product :: a -> b -> and a b
        product a b = foesac (const a) (const b) undefined

        foesac :: (a -> b) -> (a -> c) -> (a -> and b c)
        foesac f g x = product (f x) (g x)

        first :: and a b -> a
        first = second . swap

        second :: and a b -> b
        second = first . swap

    curry :: (And t) => (t a b -> c) -> a -> b -> c
    curry f a b = f $ product a b

    uncurry :: (And t) => (a -> b -> c) -> t a b -> c
    uncurry f x = f (first x) (second x)

    instance Swap (,) where
        swap (a, b) = (b, a)

    instance And (,) where
        product = (,)

        first (a,b) = a

    -- | Eitherを抽象化したクラス
    class (Swap or) => Or or where
        caseof :: (a -> c) -> (b -> c) -> (or a b -> c)
        caseof f g x = undefined

        left :: a -> or a b
        left = swap . right

        right :: a -> or b a
        right = swap . left

    data Either a b = Left a | Right b

    instance Swap Either where
        swap (Left x) = Right x
        swap (Right x) = Left x

    instance Or Either where
        caseof f g (Left x) = f x
        caseof f g (Right x) = g x

        left = Left
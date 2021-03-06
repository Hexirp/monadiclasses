{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Unit where
    import Structure.Function

    -- | ()を抽象化した型クラス
    class Unit t where
        unit :: t
        unit = undefined

    instance Unit () where
        unit = ()
{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Unit where
    import Structure.Monadiclasses.Function

    -- | ()を抽象化した型クラス
    class Unit t where
        unit :: t
        unit = undefined

    instance Unit () where
        unit = ()
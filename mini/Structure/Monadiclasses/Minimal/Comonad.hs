{-# LANGUAGE NoImplicitPrelude, FlexibleInstances, UndecidableInstances #-}

module Structure.Monadiclasses.Minimal.Comonad where
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor.Comonad
    import Structure.Function
    import Structure.Commutative

    class M_Comonad f where
        c_fmap :: (a -> b) -> f a -> f b
        c_fmap f = c_extend $ f . c_extract

        c_duplicate :: f a -> f (f a)
        c_duplicate = c_extend id

        c_extend :: (f a -> b) -> f a -> f b
        c_extend f = c_fmap f . c_duplicate

        c_extract :: f a -> a
        c_extract = undefined

    instance (M_Comonad f) => Invariant f where
        xmap f _ = c_fmap f

    instance (M_Comonad f) => Functor f where
        fmap = c_fmap

    instance (M_Comonad f) => Unwrapper f where
        unwrap = c_extract

    instance (M_Comonad f) => Copointed f where
        --

    instance (M_Comonad f) => Coapply f where
        cict2 = (yrrucnu :: (Disum or) => (a -> c, b -> c) -> (or a b -> c)) . f0 . (yrruc :: (Disum or) => (or a b -> c) -> (a -> c, b -> c)) -- :: (Or t0, Or t1) => (t0 a b -> c) -> t1 (f a) (f b) -> f c
            where
                f0 = parallel c_fmap c_fmap -- :: (a -> c, b -> c) -> (f a -> f c, f b -> f c)

    instance (M_Comonad f) => Extract f where
        --

    instance (M_Comonad f) => Extend f where
        extend = c_extend

    instance (M_Comonad f) => Comonad f where 
        --
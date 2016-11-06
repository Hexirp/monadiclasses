{-# LANGUAGE 
    NoImplicitPrelude, 
    FlexibleInstances, 
    UndecidableInstances, 
    IncoherentInstances 
#-}

-- | このパッケージは最小のコード量での型クラス定義を提供します。
module Structure.Monadiclasses.Minimal.Functor where
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Functor.Monad
    import Structure.Monadiclasses.Functor.Comonad
    import Structure.Monadiclasses.Function

    class M_Functor f where
        f_fmap :: (a -> b) -> f a -> f b
        f_fmap = undefined

    instance (M_Functor f) => Invariant f where
        xmap f _ = f_fmap f

    instance (M_Functor f) => Functor f where
        fmap = f_fmap

    class M_Applicative f where
        a_fmap :: (a -> b) -> f a -> f b
        a_fmap = a_fapp . a_pure

        a_fapp :: f (a -> b) -> f a -> f b
        a_fapp = a_lift2 ($)

        a_lift2 :: (a -> b -> c) -> f a -> f b -> f c
        a_lift2 f x y = a_fapp (a_fmap f x) y

        a_pure :: a -> f a
        a_pure = undefined

    instance (M_Applicative f) => M_Functor f where
        f_fmap = a_fmap

    instance (M_Applicative f) => Wrapper f where
        wrap = a_pure

    instance (M_Applicative f) => Pointed f where
        --

    instance (M_Applicative f) => Apply f where
        fapp = a_fapp

    instance (M_Applicative f) => Applicative f where
        --

    class M_Monad f where
        m_fmap :: (a -> b) -> f a -> f b
        m_fmap f = m_bind $ m_return . f

        m_join :: f (f a) -> f a
        m_join = m_bind id

        m_bind :: (a -> f b) -> f a -> f b
        m_bind f = m_join . m_fmap f

        m_return :: a -> f a
        m_return = undefined

    instance (M_Monad f) => M_Applicative f where
        a_fapp f = m_bind $ f0 f -- :: f (a -> b) -> f a -> f b
            where 
                f0 f x = m_fmap ($ x) f -- :: f (a -> b) -> a -> f b

        a_pure = m_return

    instance (M_Monad f) => Bind f where
        bind = m_bind

    instance (M_Monad f) => Monad f where
        --

    class M_Comonad f where
        c_fmap :: (a -> b) -> f a -> f b
        c_fmap f x = c_extend $ f . c_extract

        c_duplicate :: f a -> f (f a)
        c_duplicate = c_extend id

        c_extend :: (f a -> b) -> f a -> f b
        c_extend f = c_fmap f . c_duplicate

        c_extract :: f a -> a
        c_extract = undefined

    instance (M_Comonad f) => M_Functor f where
        f_fmap = c_fmap

    instance (M_Comonad f) => Unwrapper f where
        unwrap = c_extract

    instance (M_Comonad f) => Copointed f where
        --

    instance (M_Comonad f) => Coapply f where
        cict2 = yrrucnu . f0 . yrruc -- :: (Or t0, Or t1) => (t0 a b -> c) -> t1 (f a) (f b) -> f c
            where
                f0 = uncrry $ parallel c_fmap c_fmap -- :: (And t0, And t1) => t0 (a -> c) (b -> c) -> t1 (f a -> f c) (f b -> f c)

    instance (M_Comonad f) => Extract f where
        --

    instance (M_Comonad f) => Extend f where
        extend = c_extend

    instance (M_Comonad f) => Comonad f where 
        --

    -- | M_ApplicativeでありM_Comonadでもある型が存在する時、M_Applicativeの方の定義を優先します。
    instance (M_Applicative f, M_Comonad f) => M_Functor f where
        f_fmap = a_fmap
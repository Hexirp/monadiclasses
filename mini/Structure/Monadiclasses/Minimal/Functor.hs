{-# LANGUAGE NoImplicitPrelude, FlexibleInstances, UndecidableInstances #-}

module Structure.Monadiclasses.Minimal.Functor where
    import Structure.Monadiclasses.Wrapper
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Functor.Monad
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

    instance (M_Applicative f) => Apply f where
        fapp = a_fapp

    instance (M_Applicative f) => Wrapper f where
        wrap = a_pure

    instance (M_Applicative f) => Pointed f where
        --

    instance (M_Applicative f) => Applicative f where
        --

    class M_Monad f where
        m_fmap :: (a -> b) -> f a -> f b
        m_fmap f x = m_bind (m_return . f) x

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

    instance (M_Monad f) => Bind f where
        bind = m_bind

    instance (M_Monad f) => Monad f where
        --
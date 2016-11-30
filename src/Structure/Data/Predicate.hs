{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Data.Predicate where
    import Structure.Function
    import Structure.Commutative
    import Structure.Monadiclasses.Functor
    import Structure.Monadiclasses.Conquer
    import Structure.Monadiclasses.Contravariant.Divide

    data Bool = False | True

    (&&) :: Bool -> Bool -> Bool
    True && _ = True
    _ && True = True
    _ && _ = False

    newtype Predicate a = Predicate { runPredicate :: a -> Bool }

    instance Invariant Predicate where
        xmap _ g (Predicate x) = Predicate $ x . g

    instance Contravariant Predicate where
        contra g x = xmap undefined g x

    instance Conquer Predicate where
        conquer = Predicate $ const True

    instance Divide Predicate where
        -- @@
        --   +--|--+
        -- --f  x  &-->
        --   +--|--+
        -- @@
        divide f x = Predicate $ uncurry (&&) . uncurry (|||) (runPredicate ||| runPredicate $ x) . f
            where 
                infixl 8 |||
                (|||) = parallel

    instance Contrapointed Predicate where
        --

    instance Divisible Predicate where
        --
{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Test where
    import Prelude
    import Test.QuickCheck
    import Structure.Monadiclasses

    iden :: (Eq a) => a -> Bool
    iden a = a == a

    test :: IO ()
    test = quickCheck (iden :: Int -> Bool)
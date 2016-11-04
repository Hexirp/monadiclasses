{-# LANGUAGE NoImplicitPrelude #-}

module Structure.Monadiclasses.Test where
    import qualified Prelude as Pre
    import Test.QuickCheck
    import Structure.Monadiclasses

    iden :: (Pre.Eq a) => a -> Pre.Bool
    iden a = a Pre.== a

    test :: Pre.IO ()
    test = quickCheck (iden :: Pre.Int -> Pre.Bool)
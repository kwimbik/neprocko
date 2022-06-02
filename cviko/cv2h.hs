{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}



fibs :: [Integer]
fibs = 0:1:zipWith (+) fibs (tail fibs)


pokus :: [Integer]
pokus = 1:2:zipWith (+) pokus (tail pokus)

horner :: Num a => [a] -> a
horner = foldl (\x y -> 10*x + y) 0


subst :: [a] -> Int -> Int -> [a]
subst s a b = drop a  (take b s)

my_foldl :: (a -> b -> a) -> a -> [b] -> a
my_foldl _ a [] = a
my_foldl f b (a:as) = my_foldl f (f b a) as


--main :: IO ()
-- main =
    --do
        --interract navelkapismena

-- valekka :: String ->
-- navelka = map toUpper 


-- words [string]   -> rozdeli seznam na slova
-- lines [strinng]  -> na radky
-- :h dokumentace, :doc 
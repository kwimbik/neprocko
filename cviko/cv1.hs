{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use map" #-}
fact :: Integer -> Integer  -- typ
fact n  | n < 1     = error "To teda ne"    -- pro zaporna cisla neni definovan
        | n == 1    = 1                     -- faktorial 0 je 1
        | otherwise = n * fact (n-1)        -- faktorial n je n*faktorial n-1

plus a b = a + b
p3 :: Integer -> Integer
p3 = plus 3

my_map :: (a -> b) -> [a] -> [b]
my_map f []     = []
my_map f (x:xs) = f x:my_map f xs



myFilter::(a -> Bool) ->[a]->[a]
myFilter _ [] = []
myFilter p (x:xs)   | p x   = x:myFilter p xs
                    | otherwise  = myFilter p xs


myZip::[a]->[b]->[(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y):myZip xs ys


modIs0 a b = mod a b == 0

prime:: Integer -> Bool
prime n  = not (any (modIs0 n) [2..(n-1)])
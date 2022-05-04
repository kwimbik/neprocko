{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
import Data.Char
insert :: Int -> [Int] -> [Int]
insert r [] = [r]
insert a (x:xs) | a < x = a:x:xs
                | a == x = x:xs
                | otherwise = x:insert a xs

insertion_sort :: [Int] -> [Int]
insertion_sort [] = []
insertion_sort (x:xs) = insert x (insertion_sort xs)


capitalize :: String -> String
capitalize (a:ax)   | a == ' ' =  a:capitalize ax
                    |otherwise = toUpper a:capitalize_rest ax

capitalize_rest :: String -> String
capitalize_rest [] = []
capitalize_rest [a] = [a]
capitalize_rest (a1:a2:ax)   | a1 == ' ' && a2 /= ' '  = a1 : toUpper a2:capitalize_rest ax
                        | otherwise = a1:capitalize_rest (a2:ax)
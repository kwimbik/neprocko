-- 21: Insert an element at a given position into a list.
-- * (insertAt 'alfa '(a b c d) 2)
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
import Data.Ord (comparing)
import Data.List
import Data.Sequence (Seq(Empty))
import System.IO
import Distribution.Compat.CharParsing (CharParsing(string))
import System.Win32 (COORD(y))


insertAt :: a -> [a] -> Int -> [a]
insertAt x xs n = take (n-1) xs ++ [x] ++ drop (n-1) xs


-- 26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list
-- combinations 3 "abcdef"

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..length xs-1]
                                  , x <- combinations (n-1) (drop (i+1) xs) ]

-- 28 Sorting a list of lists according to length of sublists
--lsort ["abc","de","fgh","de","ijkl","mn","o"]
lsort :: [[a]] -> [[a]]
lsort = sortBy (comparing length)


-- 55 Construct completely balanced binary trees
--cbalTree 4
data Tree a = Prazdny | Branch a (Tree a) (Tree a)
              deriving (Show, Eq)

cbalTree :: Int -> [Tree Char]
cbalTree 0 = [Prazdny]
cbalTree n = let (q, r) = (n - 1) `quotRem` 2
        in [Branch 'x' left right | i     <- [q .. q + r],
                                left  <- cbalTree i,
                                right <- cbalTree (n - i - 1)]


-- todo pomoci foldr
nejdelsiPrefix :: (a -> Bool) -> [a] -> [a]
nejdelsiPrefix p (x:xs) | p x = x: nejdelsiPrefix p xs
                        | otherwise = []

--todo pomoci foldr
najdiPrvni :: (a -> Bool) -> [a] -> Maybe a
najdiPrvni p [] = Nothing
najdiPrvni p (x:xs)      | p x = Just x
                         | otherwise = najdiPrvni p xs


-- TODO: Naprogramujte pomocí 'foldr'
moznaMapuj :: (a -> Maybe b) -> [a] -> [b]
moznaMapuj f = foldr (\x xs -> maybe xs (:xs) (f x) ) []



--Na vstupu je zadán text jako hodnota typu String. Naším cílem je definovat binární funkci
--stat text n
--která

--obdrží takový text a přirozené číslo n
--a vrátí všechna slova z tohoto textu o délce alespoň n, setříděná lexikograficky
--každé slovo s čísly řádků, kde se slovo vyskytuje
data SlovoARadek = SlovoARadek {
   slovo :: String,
   radek :: Int
}

-- jak to udelat pro vsechny z listu atd
stat :: String  -> Int -> [[String]]
stat a  num= k
        where   x = radky a
                y = map slova x
                z = map (selectCorrectWords num 1) y
                k = map printAllSR z

printSR :: SlovoARadek -> String
printSR x = (++) (slovo x)  ((++) "je slovo a cislo radku je " (show (radek x)))

printAllSR :: [SlovoARadek] -> [String]
printAllSR = foldr ((:) . printSR) []


radky :: String -> [String]
radky = lines

slova :: String -> [String]
slova = words

selectCorrectWords :: Int -> Int -> [String] -> [SlovoARadek]
selectCorrectWords n l = foldr (\x xs -> (if length x > n then  SlovoARadek x l:xs else xs)) []

-- uz chybi jen implementace cislo radku




--4. VOLITELNÁ (Haskell): Čísla se zadanými číslicemi

--Je dána multimnožina číslic desítkové soustavy, každá číslice se v ní může vyskytovat vícekrát nebo také vůbec. Uvažme čísla, která lze sestavit použitím (ne nutně všech) číslic z této multimnožiny. Naším cílem je sestavit definice funkcí

--multi1, která k zadanému přirozenému číslu n a multimnožině m vrátí n-té takové číslo (v přirozeném uspořádání dle velikosti
--a inverzní funkci multi2, která k takovému číslu x a multimnožině m vrátí jeho pořadí.
--(a) Definujte datový typ pro reprezentaci takové multimnožiny číslic.

-- nevim co to znamena, netusim co zadani rika

--a) Pro zadanou posloupnost čísel najděte spojitý úsek, jehož součet je největší. Vydejte souřadnice začátku a konce úseku a dosažený součet.
--maxSubarray2 :: Num a => [a] → (Int, Int, a)
--maxSubarray2 [-1,1,2,3,-4]
-- (1,3,6)

maxSubarray2 :: (Num a, Ord a) => [a] -> (Int, Int,a)
maxSubarray2 = maxSubarray2' 0 0 0 0 0 0 0
    where
        maxSubarray2' maxSoFar maxEndingHere i startMax endMax start end []= (startMax, endMax, maxSoFar)
        maxSubarray2' maxSoFar maxEndingHere i startMax endMax start end (x:xs) =
            let i' = i + 1
                maxEndingHere' = maxEndingHere + x
            in
            if maxSoFar < maxEndingHere'
                then maxSubarray2' maxEndingHere' maxEndingHere' i' start i start i xs
            else
                if maxEndingHere' < 0
                    then maxSubarray2' maxSoFar 0  i' startMax endMax i' i' xs
                else maxSubarray2' maxSoFar 0  i' startMax endMax start i xs



-- Jen pro zajimavost funkcni konstrukce, mohla by se hodit
test :: Int -> (Int, Int)
test = f
        where f a = (a,a)


--scanl, scanr useful fce, jako foldl/r ale list vsech uspesnych volani

--Na vstupu je daný seznam S obsahující dvojice (položka, orientace), kde položky jsou obecné informace nějakého typu (například geny v chromozomu), a orientace je typu Bool
--(pro sousměrně a protisměrně). Volání funkce otoceni S má vydat seznam všech výsledků Vs jako seznam seznamů dvojic stejného typu,
--kde jeden výsledek vznikne otočením nějaké souvislé části S, přičemž v otočené části změníte informaci o směru.
--Délka otočené části je od 1 do délky S, tj. otáčenou spojitou část vybíráte všemi možnými způsoby.

--otočení [('a',True),('b',True),('c',False)]
--[[('a',False),('b',True),('c',False)],[('a',True),('b',False),('c',False)],[('b',False),('a',False),('c',False)],
--[('a',True),('b',True),('c',True)],[('a',True),('c',True),('b',False)],[('c',True),('b',False),('a',False)]]

otoceni :: [(a,Bool)] -> [[(a,Bool)]]
otoceni x = flip1 ( allSlices x)
            where
                flip1 = map flip
                flip = map (\x -> (if snd x then (fst x, False) else (fst x, True)) )

allSlices :: [a] -> [[a]]
allSlices n = [take y (drop x n) | x <- [0..length n], y <- [0..length n - x]]


otoceni2 :: [(a,Bool )] -> [[(a,Bool)]]
otoceni2 [] = [[]]
otoceni2 (x:xs) = map ([x] ++) (otoceni2 xs) ++ map (otoc x ++) (otoceni2 xs)
    where
        otoc (a,True) = [(a,False)]
        otoc (a,False) = [(a,True)]



-- Max incresing podposloupnost
maxIncreasing :: (Num a, Ord a) => [a] -> (Int, Int)
maxIncreasing = maxIncreasing' 0 0 0 0 0 0 0 0
    where
        maxIncreasing' prevChar  maxLength currLength i startMax endMax start end []= (startMax, endMax)
        maxIncreasing' prevChar  maxLength  currLength i startMax endMax start end (x:xs) =
            let i' = i + 1
            in
            if prevChar < x
                then
                if currLength +1 > maxLength
                    then maxIncreasing' x  (currLength +1)  (currLength +1) i' start i start i xs
                else maxIncreasing' x  maxLength  (currLength +1)  i' startMax endMax start i xs
            else
                maxIncreasing' x maxLength 0  i' startMax endMax i i xs



-- nejdelsi posloupnost nul a -1 jednicek tak, ze soucet je 0
replaceChars :: (Eq a) => [a] -> a -> a-> [a]
replaceChars xs a b = map (\x -> (if x == a then b else x)) xs

longestBalancedSum :: [Int] -> (Int, Int)
longestBalancedSum y = longestSeq (longestBal y)
                where
                    longestBal x =
                        drop 1 (scanl (+) 0 x)

-- tohle by se ubillo podobne, jako funkce vic nahore a trochu jednoduseji, jakmile bych vracel korektni prvni a posledni index
-- coz taky neni zadna raketova veda
longestSeq :: [Int] -> (Int, Int)
longestSeq x = (0,0)

getIndexAndRevIndex :: [Int] -> Int -> (Int,Int)
getIndexAndRevIndex = firstAndLastElem

-- fce first and last index of elem returns first and last elem of a list
firstAndLastElem :: [Int] -> Int -> (Int, Int)
firstAndLastElem a b = (0,0)



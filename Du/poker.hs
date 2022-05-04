import Data.List
better :: [Int] -> [Int] -> Bool
better a b  | t1 == 3 && t2 == 3 && t3 == 2 && t4 == 2 =  c > d
            | t1 == 3 && t2 == 3 && t3 /= 2 && t4 /= 2 =  c > d
            | t1 == 3 && t2 == 3 = c1 > d1
            | t1 == 2 && t2 == 2 && t3 == 2 && t4 == 2 =  c > d
            | t1 == 2 && t2 == 2 && t3 /= 2 && t4 /= 2 =  c > d
            | t1 == 2 && t2 == 2 = c1 > d1
            | otherwise  =  (c:c1:cs) > (d:d1:ds) 
            where   h1 = handValue a
                    h2 = myLexiOrder h1
                    (c:c1:cs) = reverse h2
                    p1 = handValue b
                    p2 = myLexiOrder p1
                    (d:d1:ds) = reverse p2
                    t1 = firstOfTuple c
                    t2 = firstOfTuple d
                    t3 = firstOfTuple c1
                    t4 = firstOfTuple d1


handValue :: [Int] ->[(Int, Int)]
handValue [] = []
handValue (x:xs) =  (t,x):handValue ns
                    where   t = count x (x:xs)
                            ns = remove x xs

count   :: Int -> [Int] -> Int
count _ [] =  0
count y (x:xs)  | x == y        =  1 +  count y xs
                | otherwise     =       count y xs

remove :: Int -> [Int] -> [Int]
remove element = filter (/= element)

firstOfTuple :: (Int, Int) -> Int 
firstOfTuple (a,b) = a

myLexiOrder :: Ord a => [a] -> [a]
myLexiOrder a =  sort a





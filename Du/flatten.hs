flatten ::[[a]] -> [a]
flatten [] = []
flatten ([]:xs)  = flatten xs
flatten ((x:xs):hs) = x:flatten (xs:hs)


dezip :: [(a, b)] -> ([a], [b])
dezip [] = ([], [])
dezip ((x,y):xs) = (x:c, y:d)
        where (c, d) = dezip xs

rev :: [a] -> [a]
rev xs = foldl (\x y -> y:x) [] xs 
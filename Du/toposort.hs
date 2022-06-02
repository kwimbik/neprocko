data Graf a = Graf {vrcholy::[a], naslednici::[(a,[a])]} deriving Show

--graf1 = Graf [1,2,3] [(1,[2,3]),(2,[]),(3,[])]
--graf2 = Graf [1,2,3,4,5] [(1,[2,3]),(2,[4,5]),(3,[5]),(4,[]),(5,[])]
--graf3 = Graf [1,2,3,4,5,6,7,8,9] [(1,[5]),(2,[1,4,3]),(3,[4]),(4,[9]),(5,[9]),(6,[3,7,8]),(7,[8]),(8,[9]),(9,[])]


-- program nevydava presny ukazkovy output, nicmene TU snad ano (nebo aspon na mnou testovanych datech), implementuji 
-- https://en.wikipedia.org/wiki/Topological_sorting Kahnuv algoritmus
-- -1 detonating that graphs is cyclic 


topoSort :: (Eq a, Num a) => Graf a ->  [a]
topoSort a = ksort initState  initNodes
           where    init = invertGraph (vrcholy a) (naslednici a)
                    initState = firstIteration init
                    initNodes = clearEmptyEntries init

--finds vertices with no ingoins edges
firstIteration ::  [(a, [a])] -> [a]
firstIteration [] = []
firstIteration ((a,b):ax)   | null b = a:firstIteration ax
                            | otherwise = firstIteration ax


remove :: Eq a => a -> [a] -> [a]
remove element = filter (/=element)

--actually sorting alghoritm viz link in header
ksort :: (Eq a, Num a) => [a] -> [(a,[a])] -> [a]
ksort [] [] = []
ksort [] _ = [-1]
ksort (n:sx) x  =  n:ksort ns nl 
                where   nt =  removeEdges n x
                        ns = sx ++ addNewVertices nt
                        nl = clearEmptyEntries nt

clearEmptyEntries :: Eq a => [(a,[a])] -> [(a,[a])]
clearEmptyEntries [] = []
clearEmptyEntries ((a,b):ax)    | null b = clearEmptyEntries ax
                                | otherwise = (a,b):clearEmptyEntries ax

removeEdges :: Eq a => a -> [(a,[a])] -> [(a,[a])]
removeEdges _ [] = []
removeEdges n ((a,b):ax)    | n `elem` b = (a, remove n b):removeEdges n ax
                            |otherwise = (a,b):removeEdges n ax

addNewVertices :: Eq a => [(a,[a])] -> [a]
addNewVertices [] = []
addNewVertices ((a,b):ax)   | null b = a:addNewVertices ax
                            | otherwise = addNewVertices ax

 
invertGraph :: Eq a => [a] -> [(a,[a])] -> [(a,[a])]
invertGraph [] _ = []
invertGraph (a:ax) x = (a,getVerticesToN a x):invertGraph ax x


getVerticesToN :: Eq a => a -> [(a,[a])] -> [a]
getVerticesToN _ [] = []
getVerticesToN a ((b,xs):rx)  | a `elem` xs = b:getVerticesToN a rx
                                | otherwise = getVerticesToN a rx





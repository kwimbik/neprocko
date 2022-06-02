rozeledeniSeznamu:: [a] -> [([a], [a])]
rozeledeniSeznamu a = map (split a) [0..length a]
    where  
        split a n = (take n a, drop n a)

-- rozdeli list stejne jako v prologu member

-- map (enumFromTo 1) [1..5]
-- [1..5] >>= enumFromTo 1


-- safeSqrtLog x = do
    --y <- safeLog x
    --saFeSqrt y
    
generujJ :: (Num b, Enum b) => b -> [(b, b)]
generujJ n = do
    x <- [1..n]
    y <- [1..n]
    return (x,y)

-- uspodvojce xs ys = [(x,y)] x <- xs, y <- ys]
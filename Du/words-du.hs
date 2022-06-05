import Data.Char


--join "..." ["key", "lime", "pie"]
--"key...lime...pie"
join :: String -> [String] -> String
join _ [] = []
join s (a:ax)   | ax == [] = a 
                | otherwise = a ++ s ++ join s ax



capitalize :: String -> String
capitalize (a:ax)   | a == ' ' =  a:capitalize ax
                    |otherwise = toUpper a:capitalize_rest ax

capitalize_rest :: String -> String
capitalize_rest [] = []
capitalize_rest [a] = [a]
capitalize_rest (a1:a2:ax)   | a1 == ' ' && a2 /= ' '  = a1 : toUpper a2:capitalize_rest ax
                        | otherwise = a1:capitalize_rest (a2:ax)

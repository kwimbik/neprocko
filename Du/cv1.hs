fact :: Integer -> Integer  -- typ
fact n  | n < 1     = error "To teda ne"    -- pro zaporna cisla neni definovan
        | n == 1    = 1                     -- faktorial 0 je 1
        | otherwise = n * fact (n-1)        -- faktorial n je n*faktorial n-1
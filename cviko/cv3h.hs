data Strom a = Nil | Uzel (Strom a) a (Strom a) deriving (Show)

data Mozna a = Nic | Proste a deriving (Ord, Eq, Show)
-- Strom tedy je bud `Nil`, nebo `Uzel`, ktery obsahuje dva podstromy a jednu 
-- hodnotu typu `a`.

-- Ted by se nam moc hodilo napsat si binarni vyhledavaci strom. Zacneme napred
-- pridanim do stromu.

pridej :: Ord a => Strom a -> a -> Strom a
pridej Nil y                        = Uzel Nil y Nil
pridej (Uzel x b y) z   | z < b     = Uzel (pridej x z) b y
                        | otherwise = Uzel x b (pridej y z)


treeMap :: (a -> b) -> Strom a -> Strom b
treeMap _ Nil           = Nil
treeMap f (Uzel l u p)  = Uzel (treeMap f l) (f u) (treeMap f p)

seznamNaBST :: Ord a => [a] -> Strom a
seznamNaBST = foldl pridej Nil


instance Foldable Strom where
    foldMap f Nil = mempty
    foldMap f (Uzel l h p) = foldMap f l <> f h <> foldMap f p


safeLog ::(Ord a, Floating a) =>  a -> Mozna a
safeLog x   | x <= 0        = Nic
            |  otherwise    =  Proste $ log x
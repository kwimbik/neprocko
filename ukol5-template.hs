import System.IO ()

-----------------------------------------------------------------------------------
--                                  ZADÁNÍ                                        |
-----------------------------------------------------------------------------------
--
-- Naimplementujte zadané funkce v Haskellu.
-- U každé části je krátký popis toho co máte dělat.
-- U každé funkce kterou máte implementovat je TODO a testy.
--
-- Testy můžete spustit v GHCi zavoláním funkce 'main'.
-- Testy pro část 1 můžete spustit zavoláním funkce 'testPart1', atd.
--
-- Nezapomeňte na rozumné formátování a idiomatický kód
-- (Style Guide najdete v zadání minulého úkolu).
-- Nesmíte nic importovat.
--
-- Deadline je cvičení dva týdny po zadání, tedy 4. 5. 08:59
--
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--                              1. ČÁST - FOLD                       [ 8 bodů ]   |
-----------------------------------------------------------------------------------
--
-- Naimplementujte následující funkce pomocí funkce 'foldr':                      
-- 1 bod za 'nejdelsiPrefix', 'najdiPrvni', 'spoj'                  
-- 2 body za 'moznaMapuj' 
-- 3 body za 'jePrefixem'                                                         
--
-----------------------------------------------------------------------------------

-- | 'nejdelsiPrefix' vezme predikát 'p' a seznam 'xs'
-- a vrátí nejdelší prefix 'xs', v němž všechny prvky splňují 'p'.
--
-- TODO: Naprogramujte pomocí 'foldr'
nejdelsiPrefix :: (a -> Bool) -> [a] -> [a]
nejdelsiPrefix p = foldr (\x xs -> (if p x then x:xs else [])) []

nejdelsiPrefixTesty :: [Test [Int]]
nejdelsiPrefixTesty =
  [ nejdelsiPrefix (< 0)  [1, 2, 3]
    === []
    @@@ "nejdelsiPrefix (< 0) [1, 2, 3] === []"
  , nejdelsiPrefix (== 0) [0, 0, 1, 0, 0]
    === [0, 0]
    @@@ "nejdelsiPrefix (== 0) [0, 0, 1, 0, 0] === [0, 0]"
  , nejdelsiPrefix (> 0)  [1, 2, 0, 1, 2, 3]
    === [1, 2]
    @@@ "nejdelsiPrefix (> 0) [1, 2, 0, 1, 2, 3] === [1, 2]"
  , nejdelsiPrefix (> 1)  [1, 2, 3]
    === []
    @@@ "nejdelsiPrefix (> 1) [1, 2, 3] === []"
  ]

-- | 'najdiPrvni' vezme predikát 'p' a seznam 'xs'
-- a vrátí první prvek, který splňuje predikát
--
-- TODO: Naprogramujte pomocí 'foldr'
najdiPrvni :: (a -> Bool) -> [a] -> Maybe a
najdiPrvni p = foldr (\x xs -> if p x then Just x else xs) Nothing

najdiPrvniTesty :: [Test (Maybe Int)]
najdiPrvniTesty =
  [ najdiPrvni even [1, 2, 3, 4, 5]
    === Just 2
    @@@ "najdiPrvni even [1, 2, 3, 4, 5] === Just 2"
  , najdiPrvni even [1, 3, 5]
    === Nothing
    @@@ "najdiPrvni even [1, 3, 5] === Nothing"
  , najdiPrvni even [1, 3, 5, 6, 7]
    === Just 6
    @@@ "najdiPrvni even [1, 3, 5, 6, 7] === Just 6"
  , najdiPrvni even [] === Nothing @@@ "najdiPrvni even [] === Nothing"
  ]

-- | 'moznaMapuj' na každý prvek seznamu aplikuje funkci,
-- která se nemusí povést (pokud se nepovede, vrátí 'Nothing').
-- Ve výsledku jsou jen ty transformované prvky, které se "povedly".
--
-- TODO: Naprogramujte pomocí 'foldr'
moznaMapuj :: (a -> Maybe b) -> [a] -> [b]
moznaMapuj p = foldr (\x xs -> maybe xs (:xs) (p x)) []

moznaMapujTesty :: [Test [Double]]
moznaMapujTesty =
  [ moznaMapuj odmocnina [0.0, -1.0, 4.0]
    === [0.0, 2.0]
    @@@ "moznaMapuj odmocnina [0.0, -1.0, 4.0] === [0.0, 2.0]"
  , moznaMapuj odmocnina [-1.0, -2.0, -3.0]
    === []
    @@@ "moznaMapuj odmocnina [-1.0, -2.0, -3.0] === []"
  , moznaMapuj odmocnina [] === [] @@@ "moznaMapuj odmocnina [] === []"
  , moznaMapuj Just            [1.0, -1.0, 0.0]
    === [1.0, -1.0, 0.0]
    @@@ "moznaMapuj Just [1.0, -1.0, 0.0] === [1.0, -1.0, 0.0]"
  , moznaMapuj (const Nothing) [1.0, -1.0, 0.0]
    === []
    @@@ "moznaMapuj (const Nothing) [1.0, -1.0, 0.0] === []"
  ]
 where
  odmocnina d | d < 0.0   = Nothing
              | otherwise = Just (sqrt d)

-- | 'spoj' spojí dva seznamy dohromady
--
-- TODO: Naprogramujte pomocí 'foldr'
spoj :: [a] -> [a] -> [a]
spoj a b = foldr (++) b [a]

spojTesty :: [Test [Int]]
spojTesty =
  [ spoj [42, 51] [0, 12]
    === [42, 51, 0, 12]
    @@@ "spoj [42, 51] [0, 12] === [42, 51, 0, 12]"
  , spoj [] [] === [] @@@ "spoj [] [] === []"
  , spoj [42] [] === [42] @@@ "spoj [42] [] === [42]"
  , spoj [] [0] === [0] @@@ "spoj [] [0] === [0]"
  , spoj [0, 0, 0, 0] [0, 0]
    === [0, 0, 0, 0, 0, 0]
    @@@ "spoj [0, 0, 0, 0] [0, 0] === [0, 0, 0, 0, 0, 0]"
  , take 10 (spoj [1 ..] [1 ..])
    === [1 .. 10]
    @@@ "take 10 (spoj [1 ..] [1 ..]) === [1 .. 10]"
  ]

-- | Funkce 'jePrefixem' je pravdivá, pokud první argument je prefixem druhého
--
-- Nápověda: Akumulátor ve 'foldr' může být také funkce!
-- (podobně jako 'zip' na cvičení)
--
-- TODO: Naprogramujte pomocí 'foldr'
jePrefixem :: String -> String -> Bool
jePrefixem _ _ = False

jePrefixemTesty :: [Test Bool]
jePrefixemTesty =
  [ "Ahoj"
    `jePrefixem` "Ahoj světe!"
    ===          True
    @@@          "\"Ahoj\" `jePrefixem` \"Ahoj světe!\" === True"
  , "Ahoj"
    `jePrefixem` "Ahoj"
    ===          True
    @@@          "\"Ahoj\" `jePrefixem` \"Ahoj\" === True"
  , "Ahoj" `jePrefixem` "" === False @@@ "\"Ahoj\" `jePrefixem` \"\" === False"
  , "" `jePrefixem` "" === True @@@ "\"\" `jePrefixem` \"\" === True"
  , ""
    `jePrefixem` "Ahoj světe!"
    ===          True
    @@@          "\"\" `jePrefixem` \"Ahoj světe!\" === True"
  , "světe"
    `jePrefixem` "Ahoj světe!"
    ===          False
    @@@          "\"světe\" `jePrefixem` \"Ahoj světe!\" === False"
  ]

-----------------------------------------------------------------------------------
--                    2. ČÁST - FOLD S OCÁSKEM                  [ 5 bodů ]        |
-----------------------------------------------------------------------------------
--
-- Naimplementujte funkci 'ocaskovyFold' [2 body]                                         
--
-- Potom pomocí ní naimplementujte zbytek funkcí v této části:                    
-- 1 bod za 'sufixyPomociOcasku' a 2 body za 'jeSufixem'.
--
-----------------------------------------------------------------------------------

foldRight :: (a -> b -> b) -> b -> [a] -> b
foldRight _ acc [] = acc
foldRight f acc (x:xs) = f x (foldRight f acc xs)

-- | 'ocaskovyFold' je jako 'foldr', ale umožňuje přístup nejen k hlavě
-- zpracovávaného seznamu, ale i k ocásku.
--
-- TODO: Naprogramujte pomocí pattern matchování.
-- Hint: Inspirujte se definicí funkce 'foldr'
ocaskovyFold :: (a -> [a] -> b -> b) -> b -> [a] -> b
ocaskovyFold _ z _ = z

ocaskovyFoldTesty :: [Test Int]
ocaskovyFoldTesty =
  [ boolToInt (ocaskovyFold (\x _ acc -> even x || acc) False [1 ..])
    === 1
    @@@ "boolToInt (ocaskovyFold (\\x _ acc -> even x || acc) False [1 ..]) === 1"
  , ocaskovyFold (\x xs acc -> (x + product xs) * acc) 1 [1, 2, 3]
    === 140
    @@@ "ocaskovyFold (\\x xs acc -> (x + product xs) * acc) 1 [1, 2, 3] === 140"
  ]
 where
  boolToInt :: Bool -> Int
  boolToInt True  = 1
  boolToInt False = 0

-- | 'sufixy' vrací všechny sufixy daného seznamu
sufixy :: [a] -> [[a]]
sufixy []       = [[]]
sufixy (x : xs) = (x : xs) : sufixy xs

-- | Tato funkce by se měla chovat stejně jako 'sufixy',
-- ale měla by být implementována pomocí 'ocaskovyFold'
--
-- TODO: Naprogramujte pomocí 'ocaskovyFold'
sufixyPomociOcasku :: [a] -> [[a]]
sufixyPomociOcasku _ = []

sufixyTesty :: [Test [String]]
sufixyTesty =
  [ sufixyPomociOcasku "ahoj"
    === ["ahoj", "hoj", "oj", "j", ""]
    @@@ "sufixyPomociOcasku \"ahoj\" === [\"ahoj\", \"hoj\", \"oj\", \"j\", \"\"] "
  , sufixyPomociOcasku "" === [""] @@@ "sufixyPomociOcasku \"\" === [\"\"]"
  , sufixyPomociOcasku "E"
    === ["E", ""]
    @@@ "sufixyPomociOcasku \"E\" === [\"E\", \"\"]"
  ]

-- | 'jeSufixem' je pravdivé, pokud je řetězec vlevo sufixem řetězce vpravo
-- 
-- TODO: Naprogramujte pomocí 'ocaskovyFold'
jeSufixem :: String -> String -> Bool
jeSufixem _ _ = False

jeSufixemTesty :: [Test Bool]
jeSufixemTesty =
  [ "!"
    `jeSufixem` "Ahoj světe!"
    ===         True
    @@@         "\"!\" `jeSufixem` \"Ahoj světe!\" === True"
  , ""
    `jeSufixem` "Ahoj světe!"
    ===         True
    @@@         "\"\" `jeSufixem` \"Ahoj světe!\" === True"
  , "Ahoj"
    `jeSufixem` "Ahoj"
    ===         True
    @@@         "\"Ahoj\" `jeSufixem` \"Ahoj\" === True"
  , "Ahoj"
    `jeSufixem` "Ahoj světe"
    ===         False
    @@@         "\"Ahoj\" `jeSufixem` \"Ahoj světe\" === False"
  ]

-----------------------------------------------------------------------------------
--                            3. ČÁST - STROMY                     [ 8 bodů ]     |
-----------------------------------------------------------------------------------
--
-- Naimplementujte zadané funkce: 'stromMap', 'spojStromy', 'otocStrom'
-- a 'stromSplnuje'. Každá funkce je za 2 body.
--
-----------------------------------------------------------------------------------

-- | 'Strom' je binární strom, který má data v interních vrcholech (v nelistech)
data Strom a
    = Konec
    | Vetev a (Strom a) (Strom a)
    deriving (Show, Eq)

-- Testovací strom:
-- @@
--              1
--             / \
--            2   3
-- @@           
testovaciStrom :: Strom Int
testovaciStrom = Vetev 1 (Vetev 2 Konec Konec) (Vetev 3 Konec Konec)

-- | 'map' pro 'Strom':
--
-- TODO: naprogramujte tuto funkci
-- Hint: použijte obyčejný pattern matching
stromMap :: (a -> b) -> Strom a -> Strom b
stromMap _ _ = Konec

stromMapTesty :: [Test (Strom Int)]
stromMapTesty =
  [ stromMap (+ 1) testovaciStrom
    === Vetev 2 (Vetev 3 Konec Konec) (Vetev 4 Konec Konec)
    @@@ "stromMap (+1) testovaciStrom === Vetev 2 (Vetev 3 Konec Konec) (Vetev 4 Konec Konec)"
  , stromMap (* 2) testovaciStrom
    === Vetev 2 (Vetev 4 Konec Konec) (Vetev 6 Konec Konec)
    @@@ "stromMap (*2) testovaciStrom === Vetev 2 (Vetev 4 Konec Konec) (Vetev 6 Konec Konec)"
  , stromMap id    testovaciStrom
    === testovaciStrom
    @@@ "stromMap id testovaciStrom === testovaciStrom"
  , stromMap id Konec === Konec @@@ "stromMap id Konec === Konec"
  , stromMap (* 2) Konec === Konec @@@ "stromMap (*2) Konec === Konec"
  ]

-- | 'fold' pro 'Strom':
-- Všimněte si, že jde zase odvodit mechanicky, podobně jako jsme
-- na cvičení společně odvodili typ `foldr`:
stromFold :: (a -> b -> b -> b) -> b -> Strom a -> b
stromFold _ z Konec         = z
stromFold f z (Vetev x l r) = f x (stromFold f z l) (stromFold f z r)

-- | Vezme dva stromy a nahradí všechny 'Konec' v jednom stromu napojením kopie druhého stromu.
--
-- TODO: Naprogramujte pomocí 'stromMap' a/nebo 'stromFold' 
spojStromy :: Strom a -> Strom a -> Strom a
spojStromy strom _ = strom

spojStromyTesty :: [Test (Strom Int)]
spojStromyTesty =
  [ Konec `spojStromy` Konec === Konec @@@ "Konec `spojStromy` Konec === Konec"
  , Konec
    `spojStromy` Vetev 1 Konec Konec
    === Vetev 1 Konec Konec
    @@@ "Konec `spojStromy` Vetev 1 Konec Konec === Vetev 1 Konec Konec"
  , Vetev 1 Konec Konec
    `spojStromy` Vetev 2 Konec Konec
    === Vetev 1 (Vetev 2 Konec Konec) (Vetev 2 Konec Konec)
    @@@ "Vetev 1 Konec Konec `spojStromy` Vetev 2 Konec Konec === Vetev 1 (Vetev 2 Konec Konec) (Vetev 2 Konec Konec)"
  , Vetev 1 Konec Konec
    `spojStromy` Konec
    === Vetev 1 Konec Konec
    @@@ "Vetev 1 Konec Konec `spojStromy` Konec === Vetev 1 Konec Konec"
  ]

-- | Otočí dvojici hodnot ve stromě
--
-- TODO: Naprogramujte pomocí 'stromMap' a/nebo 'stromFold' 
otocStrom :: Strom (a, b) -> Strom (b, a)
otocStrom _ = Konec

otocStromTesty :: [Test (Strom (Int, Char))]
otocStromTesty =
  [ otocStrom Konec === Konec @@@ "otocStrom Konec === Konec"
  , otocStrom (Vetev ('a', 1) Konec Konec)
    === Vetev (1, 'a') Konec Konec
    @@@ "otocStrom (Vetev ('a', 1) Konec Konec) === Vetev (1, 'a') Konec Konec"
  ]

-- | Strom splňuje predikát `p`, pokud jej splňují všechny jeho vrcholy
--
-- TODO: Naprogramujte pomocí 'stromMap' a/nebo 'stromFold' 
stromSplnuje :: (a -> Bool) -> Strom a -> Bool
stromSplnuje _ _ = False

stromSplnujeTesty :: [Test Bool]
stromSplnujeTesty =
  [ stromSplnuje (const True)  Konec
    === True
    @@@ "stromSplnuje (const True) Konec === True"
  , stromSplnuje (const True)  testovaciStrom
    === True
    @@@ "stromSplnuje (const True) testovaciStrom === True"
  , stromSplnuje (const False) testovaciStrom
    === False
    @@@ "stromSplnuje (const False) testovaciStrom === False"
  , stromSplnuje (>= 1)        testovaciStrom
    === True
    @@@ "stromSplnuje (>= 1) testovaciStrom === True"
  , stromSplnuje (> 9999)      Konec
    === True
    @@@ "stromSplnuje (> 9999) Konec === True"
  ]

-----------------------------------------------------------------------------------
--                             HERE BE DRAGONS                                    |
----------------------------------------------------------------------------------
--
-- Níže následuje malinkatý framework pro unit testy, který jsem napsal,
-- abyste si mohli otestovat svůj kód. :)
-- Zavolejte 'main' v GHCi a vypíše se vám hezký přehled.
--
-- Kód níže samozřejmě můžete zkoumat a upravovat, odevzdávat jej nemusíte... ;)
--
-----------------------------------------------------------------------------------

-- | A 'Test' is a pair of (expected value, actual value)
-- together with an optional description
data Test a = Test
  { expected    :: a
  , actual      :: a
  , description :: Maybe String
  }
  deriving (Show, Eq)

-- | A binary operator for creating a basic test without a description
--
-- Example:
-- >>> 2 + 8 === 10
(===) :: (Eq a, Show a) => a -> a -> Test a
actualValue === expectedValue = Test expectedValue actualValue Nothing

-- | A binary operator for annotating a test with a description
--
-- Example:
-- >>> 2 + 8 === 10 @@@ "Two plus eight should be ten!"
(@@@) :: Test a -> String -> Test a
test @@@ desc = test { description = Just desc }

-- | Gets a description of a 'Test'.
--
-- Returns @expected === actual@ if the given test has no description.
getTestDescription :: Show a => Test a -> String
getTestDescription t = case description t of
  Just someDescription -> someDescription
  Nothing              -> show (expected t) ++ " === " ++ show (actual t)

-- | A 'TestResult' is either 'OK' or 'Fail'
--
-- This type is different from 'Bool' to avoid boolean blindness...
-- See this article by Bob Harper: https://existentialtype.wordpress.com/2011/03/15/boolean-blindness/
data TestResult
  = OK
  | Fail
  deriving (Show, Eq)

-- | Takes a list of 'TestResult' and returns a pair of numbers,
-- where the first number is the number of 'OK's
-- and the second number is the number of 'Fail's
sumTestResults :: [TestResult] -> (Int, Int)
sumTestResults results = go results (0, 0)
 where
  go []          (oks, fails) = (oks, fails)
  go (OK   : rs) (oks, fails) = go rs (oks + 1, fails)
  go (Fail : rs) (oks, fails) = go rs (oks, fails + 1)

-- | Runs a test producing a 'TestResult'
runTest :: (Eq a, Show a) => Test a -> TestResult
runTest t | expected t == actual t = OK
          | otherwise              = Fail

-- | Takes a 'Test' and its 'TestResult' and produces a 'String'
-- with details about the test and its success/failure
describeTest :: Show a => Test a -> TestResult -> String
describeTest t OK   = getTestDescription t ++ " ... OK "
describeTest t Fail = unlines
  [ getTestDescription t ++ " ... FAIL"
  , "    " ++ "Expected: " ++ show (expected t)
  , "    " ++ "Actual:   " ++ show (actual t)
  ]

-- | Takes a list of 'Test a', runs it and returns a single 'String'
-- describing the result and a pair of two 'Int's -- number of 'OK' and number of 'Fail' resp.
runTests :: (Eq a, Show a) => [Test a] -> (String, (Int, Int))
runTests tests = (resultsString, resultsSum)
 where
  results       = map runTest tests
  resultsSum    = sumTestResults results
  resultsString = unlines $ zipWith describeTest tests results



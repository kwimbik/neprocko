-- jednořádkový komentář

{- 
   více
   řádkový
   komentář
-}   

-- Výrazy se v Haskellu píšou s malým písmenkem na začátku.

-- Na levé straně je jméno hodnoty. Používáme =, abychom definovali výraz pod nějakým jménem jako:

ctyricetDva = 42

pozdrav = "Ahoj"

-- Funkce jsou v Haskellu také hodnoty
prictiJednicku = \x -> x + 1

-- Ekvivalentní zápisy z jiných jazyků:

-- Python: prictiJednicku = lambda x: x + 1
-- C#: Func<int, int> prictiJednicku = x => x + 1;
-- C++: auto prictiJednicku = [](auto x) -> auto { return x + 1 }

-- Funkce více argumentů můžeme udělat tak, že uděláme funkci,
-- která vrátí funkci
prictiJednickuASecti = \x -> (\y -> prictiJednicku x + prictiJednicku y)
-- Poznámka:           Tahle ^ závorka není nutně potřeba!

dvakrat = \x -> x * 2

-- Aplikace funkce je _zleva_ asociativní a má velmi vysokou precedenci:

-- >>> dvakrat (prictiJednicku 42)
-- C++> dvakrat(prictiJednicku(42))
-- 86

-- >>> dvakrat prictiJednicku 42
-- to samé jako
-- >>> ((dvakrat prictiJednicku) 42)
-- C++> (dvakrat(prictiJednicku))(42)
-- (tady nedává smysl)

-- Definice funkce je tak častá, že Haskell má i syntaktický cukr
-- tedy místo `dvakrat = \x -> x * 2` stačí napsat:
dvakrat' x = x * 2

-- Podobně pro další funkce:
prictiJednicku' x = x + 1
prictiJednickuASecti' x y = prictiJednicku x + prictiJednicku y

-- Obecně:
-- >>> foo x y = ...
-- je syntaktický cukr pro
-- >>> foo = \x -> \y -> ...

-- Tedy definice funkce vypadá takhle:
-- <název funkce> <arg1> <arg2> ... <argN> = <tělo funkce>

-- Funkce se vyhodnocují stejně jako v lambda kalkulu.
-- Více viz předchozí cvičení (hezky jsem to tam rozepsal...)
ctyricetCtyri  = prictiJednicku (prictiJednicku ctyricetDva)
{-
Příklad vyhodnocení:
ctyricetCtyri = (\x -> x + 1) (prictiJednicku ctyricetDva)   [ vložíme definici `prictiJednicku` ]
              = ((prictiJednicku ctyricetDva) + 1)           [ dosadíme x := prictiJednicku ctyricetDva ]
              = (((\x -> x + 1) ctyricetDva) + 1)            [ vložíme definici `prictiJednicku` ]
              = ((ctyricetDva + 1) + 1)                      [ dosadíme x := ctyricetDva ]
-}


-- Obvod obdélníku:

obvod a b = 2 * (a + b)

-- Obsah obdelniku

obsah a b = a * b




-- Dvojice (pairs) se píšou v Haskellu následovně:
-- Každý prvek dvojice může mít různý typ!

dvojice = (42, "Ahoj!")

-- >>> :t dvojice
-- (Int, String)

-- Následující příklad ukazuje základní použití všech věcí, které jsme si zatím ukazovali:

-- | Vyřeší kvadratickou rovnici tvaru `ax^2 + bx + c = 0`,
--   vrací obě řešení jako pár (dvojici)
vyresKvadratickouRovnici :: Double -> Double -> Double -> (Double, Double)
vyresKvadratickouRovnici a b c = (reseni (+), reseni (-))
    where
        diskriminant = b^2 - 4 * a * c
        -- `reseni` je funkce, která bere další funkci jako svůj argument
        reseni op = (-b `op` sqrt diskriminant) / (2 * a)

-- Cvičení: Podívejte se na funkci výše a pochopte jak funguje.
-- Nápovědou vám budiž všechny předchozí soubory!
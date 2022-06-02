/* 	Napište predikát vlozOperatory/3, takový, že vlozOperatory(Seznam, Hodnota, Vyraz) uspěje,
	pokud Hodnota je hodnota vyrazu Vyraz, který vznikne ze seznamu Seznam vložením závorek
	a operátorů +, -, *, / mezi jeho prvky.	*/

% seznam o jednom prvku může vyhodnotit pouze daný prvek

vlozOperatory([X], X, X).

% nedeterministicky rozdělíme číselný seznam do 2 samostatných seznamů, z nichž každý obsahuje alespoň jedno číslo
% rekurzivně hledáme výraz pro každý seznam, kde se výraz vyhodnotí na základě daného operátoru

vlozOperatory(Seznam, Hodnota, Vyraz):- append([X|Xs], [Y|Ys], Seznam),  	
                                        vlozOperatory([X|Xs], _, Operand1),	
					vlozOperatory([Y|Ys], _, Operand2),
                                        (Vyraz = Operand1 + Operand2;
					 Vyraz = Operand1 - Operand2;
					 Vyraz = Operand1 * Operand2;
					(Vyraz = Operand1 / Operand2 -> Operand2 =\= 0)),
	  				 Hodnota is Vyraz.

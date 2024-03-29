// main
					Input
                    Store 		number
                    JnS			wynik_clear
					Load 		number
                    JnS			negative_input
                    JnS			wynik_print
                    Halt

// Branch gdy liczba jest ujemna
negative_input,		HEX			0
                    Skipcond	000
					Jump 		positive_input
                    
                    Add 		ONE
                    JnS			Abs
                    Store 		number
					JnS 		tohex
					JnS			makeneg
                    JumpI		negative_input

// Branch gdy liczba jest dodatnia
positive_input,		JnS 		tohex
					JumpI		negative_input

// Wejsciowa wartosc
number,             DEC         0

wynik_iter,			HEX			015
wynik,				HEX			015
wynik_ptr,			HEX			0
					HEX			0
                    HEX			0
                    HEX			0
                                        
// Constants
ONE,				DEC			1
FIFTEEN,			DEC			15
SIXTEEN,			DEC			16
FORTYEIGHT,			DEC			48
FIFTYFIVE,			DEC			55
NINE,				DEC			9
FOUR,				DEC			4

// Funkcja obliczajaca reszte z dzielenia
// Zapisuje reszte do DivMod oraz wynik do DivWynik
DivA,				HEX		0 // dzielna
DivB,				DEC		16 // dzielnik
DivWynik,			HEX		0 // wynik dzielenia
DivMod,				HEX		0 // reszta z dzielenia
Divide,				HEX		0 // wskaznik na funkcje
					Clear
                    Store DivWynik
                    Store DivMod
While_Div,			Load DivA
					Subt DivB
                    Skipcond 000
                    Jump Do_Div
                    
                    // Zapisujemy reszte z dzielenia
                    Add DivB
                    Store DivMod
                    
                    JumpI Divide
                    
Do_Div,				Store DivA
					Load DivWynik
                    Add ONE
                    Store DivWynik
                    Jump While_Div


// Funkcja wypelniajaca tablice wynik kolejnymi
// cyframi reprezentacji hexadecymalnej wprowadzonej liczby
length,				HEX			0
tohex,              HEX			0
					Load 		number
// Oddzielny branch dla 0
if_zero,			Skipcond 	400
					Jump if_non_zero
                    Clear
                    Add FORTYEIGHT
                    Output
                    JumpI tohex
// Jesli liczba jest niezerowa
if_non_zero,		Store 		DivA
while_tohex,		Load 		number
					Skipcond 	400
                    Jump 		do_tohex
                    JumpI 		tohex                    
do_tohex,			Load 		number
					Store 		DivA
					JnS			Divide
                    Load 		DivMod
                    JnS			wynik_push
                    Load 		DivWynik
                    Store 		number
					Jump 		while_tohex


// Funkcje zwiazane z tablica przechowujaca wynik,
// tablica ta dziala troche jak stos,

// Funkcja ktora dodaje nowa wartosc do tablicy
// na adres wynik_iter, a nastepnie inkrementuje iterator
wynik_push,			HEX			0
                    StoreI  	wynik_iter

                    Load 		wynik_iter
                    Add 		ONE
                    Store 		wynik_iter

                    JumpI		wynik_push

// Funkcja ktora wypisuje wrzucone wartosci od konca
wynik_print,		HEX			0
while_print,		Load 		wynik_iter
                    Subt 		wynik
                    Skipcond 	400
                    Jump 		do_print
                    JumpI 		wynik_print
                
do_print,			Load 		wynik_iter
                    Subt 		ONE
                    Store 		wynik_iter
                    LoadI 		wynik_iter
                    JnS 		if_print_letter
                    Jump 		while_print

// Jesli nasza cyfra jest z zakresu [0,9]
// musimy dodac do niej 55 zeby zgadzala sie
// ze znakiem w UNICODE
if_print_letter,	DEC			0
                    Subt 		NINE
                    Skipcond 	800
                    jump 		else_print_number
                    Add 		NINE
                    Add 		FIFTYFIVE
                    Output
                    JumpI 		if_print_letter

// Jesli nasza cyfra jest z zakresu [A,F]
// musimy dodac do niej 48 zeby zgadzala sie
// ze znakiem w UNICODE
else_print_number,	Add 		FORTYEIGHT
					Add 		NINE
					Output
                	JumpI 		if_print_letter
                    
// Zeruje wszystkie wartosci w tablicy
clear_iter,			HEX			0
wynik_clear,		HEX			0
					Load 		wynik
                    Add 		FOUR
                    Store 		clear_iter
while_clear,		Load 		clear_iter
                    Subt 		wynik
                    
                    Skipcond 	400
                    Jump 		do_clear
                    
                    JumpI 		wynik_clear
                
do_clear,			Load 		clear_iter // i--;
                    Subt 		ONE
                    Store 		clear_iter
                    
                    LoadI 		clear_iter
                    
                    // wynik[i] = 0;
                    Clear
                    StoreI		clear_iter
                    
                    Jump 		while_clear

                    
// Oblicza modul z liczby
Abs_temp,			HEX		0
Abs,				HEX 	0
					Skipcond 000
                    JumpI Abs
                    Store Abs_temp
                    Subt Abs_temp
                    Subt Abs_temp
                    JumpI Abs

// Funkcja ktora przechodzi przez wszystkie cyfry naszego
// wyniku a nastepnie je przeksztalca jak: x = 15 - x
// Na samym poczatku programu dodalismy 1 do naszej liczby
// ujemnej. W U2 przy zamianie na liczbe przeciwna, nie ma
// znaczenia czy najpierw odwrocimy bity czy dodamy 1
makeneg_temp,		HEX		0
makeneg_iter,		HEX		0
makeneg,			HEX		0
					// Musimy zmienic iterator tak aby szedl on
                    // przez cala tablice
                    // Gdy liczba jest dodatnia nie robimy tego
                    // poniewaz chcemy pominac prefiks zer
					Load 	wynik
                    Add 	FOUR
                    Store 	makeneg_iter
                    Store 	wynik_iter
while_makeneg,		Load 		makeneg_iter
                    Subt 		wynik
                    
                    Skipcond 	400
                    Jump 		do_makeneg
                    
                    JumpI 		makeneg
                
do_makeneg,			Load 		makeneg_iter // i--;
                    Subt 		ONE
                    Store 		makeneg_iter
                    
                    LoadI 		makeneg_iter
                    
                    // wynik[i] = -wynik[i] + 15;
                    Store		makeneg_temp
                    Subt		makeneg_temp
                    Subt		makeneg_temp
                    Add 		FIFTEEN
                    StoreI		makeneg_iter
                    
                    Jump 		while_makeneg

# Jawność i odpowiedzialność

Praca dyplomowa jest z ustawy **samodzielnym opracowaniem** zagadnienia, prezentującym wiedzę i umiejętności studenta oraz umiejętność samodzielnego analizowania i wnioskowania (Prawo o szkolnictwie wyższym). Ten wymóg nie zmienia się od tego, że część kodu powstała z pomocą agenta. Zmienia się natomiast to, co musisz o tej pomocy powiedzieć.

W rozdziale opisane są granice dozwolonego użycia, sposób jego dokumentowania i konsekwencje przekroczenia granic. Metoda pracy jest w rozdziale [Praca z agentem programistycznym](07-agent-cli.md#praca-z-agentem-programistycznym).

## Dwa różne obszary

Zasady dla kodu i dla tekstu są **różne** i mylenie ich jest najczęstszym źródłem kłopotów.

### Kod aplikacji

Użycie agenta przy budowie pakietu jest **dozwolone** i stanowi element metodyki, którą praca opisuje. Warunki są trzy.

Jawność: każde polecenie dotyczące budowy aplikacji trafia do rejestru, a rejestr do aneksu pracy. Odpowiedzialność: za poprawność kodu odpowiadasz Ty, niezależnie od tego, kto napisał którą linię. Zrozumienie: musisz umieć objaśnić każdą linię, którą oddajesz, i obronić przyjęte rozwiązania.

Sposób, w jaki agent pomógł i w jakich miejscach się pomylił, jest **materiałem do pracy**, a nie wstydliwym szczegółem. Rozdział drugi zawiera krótką analizę: gdzie specyfikacja wychwyciła rozejście się implementacji z metodą i jak to wykryłeś. Dla recenzenta jest to mocniejszy dowód zrozumienia niż bezbłędny kod.

### Tekst pracy

Tu zakres jest znacznie węższy. Dozwolone jest **poprawianie tekstu, który sam napisałeś**: korekta językowa, uporządkowanie składni zdania, sprawdzenie interpunkcji, pomoc przy składzie wzorów.

Niedozwolone jest **generowanie tekstu**. Żaden akapit pracy nie może powstać przez wygenerowanie i przyjęcie. Powód nie jest formalny, lecz merytoryczny: praca ma być zapisem Twojego rozumowania, a rozumowanie, którego nie przeprowadziłeś, nie jest Twoje.

### Bezwzględny zakaz

Jest jedna kategoria, w której użycie agenta jest wykluczone bez wyjątków: **cytowania, opisy bibliograficzne i treść przypisów**.

Powód jest praktyczny. Agenci wytwarzają opisy bibliograficzne wyglądające poprawnie, ale odsyłające do publikacji, które nie istnieją albo mają inne dane. Nazwiska, tytuły, roczniki i numery stron układają się w wiarygodną całość, której nie da się zweryfikować, bo nie ma czego weryfikować.

Konsekwencje takiego wpisu w pracy dyplomowej są poważne. Brak odpowiednio opisanych źródeł może być powodem dyskwalifikacji pracy (Standardy EPI), a cytowanie nieistniejącej publikacji jest czymś więcej niż brakiem opisu.

Każdą pozycję bibliografii masz w ręku: przeczytaną, z ustalonym identyfikatorem cyfrowym, wpisaną do menedżera bibliografii. Sposób prowadzenia jest w rozdziale [Bibliografia: plik BibTeX i Zotero](02-bibliografia.md#bibliografia-plik-bibtex-i-zotero).

**Tabela 28. Zakres dozwolonego użycia**

| Czynność | Ocena |
|---|---|
| Implementacja funkcji na podstawie specyfikacji | dozwolone, wymaga wpisu w rejestrze |
| Generowanie danych złośliwych do testów odporności | dozwolone, wymaga wpisu w rejestrze |
| Diagnostyka błędu obliczeniowego | dozwolone, wymaga wpisu w rejestrze |
| Bloki dokumentacyjne funkcji | dozwolone, wymaga wpisu w rejestrze |
| Korekta językowa własnego akapitu | dozwolone, wpisz do oświadczenia |
| Pomoc przy składzie wzoru | dozwolone, wpisz do oświadczenia |
| Napisanie akapitu pracy | **niedozwolone** |
| Streszczenie artykułu, którego nie przeczytałeś | **niedozwolone** |
| Sformułowanie wniosków z wyników | **niedozwolone** |
| Wytworzenie cytowania albo opisu bibliograficznego | **wykluczone bez wyjątków** |

## Oświadczenie

Oświadczenie umieszcza się w aneksie pracy. Nie jest wymagane przy drobnych pracach redakcyjnych, ale takie kwestie jak edytowanie równań, poprawa stylistyczna tekstu czy korekty błędów w kodzie warto w nim wpisać.

> Podczas przygotowywania niniejszej pracy korzystałem/am z narzędzia […] w celu […]. Po użyciu tego narzędzia dokonałem/am krytycznego przeglądu i edycji treści. Oświadczam, że wygenerowane fragmenty zostały odpowiednio oznaczone, a SI służyła mi wyłącznie jako asystent, nie zaś jako źródło wiedzy. Ponoszę pełną odpowiedzialność za finalny kształt i poprawność przedłożonych analiz.

Pole „w celu” wypełnia się konkretnie. Zapis „do pomocy przy pracy” nic nie znaczy. Zapis „do implementacji funkcji obliczeniowych na podstawie specyfikacji oraz do korekty językowej tekstu własnego” mówi dokładnie, co się działo.

Gotowy do wypełnienia aneks znajduje się we wzorze pracy.

## Aneks z wykazem poleceń

W oświadczeniu podajesz, **że** korzystałeś. W aneksie – **jak**. Dotyczy wyłącznie budowy aplikacji; poleceń dotyczących korekty językowej się nie wykazuje.

Wykaz powstaje z rejestru prowadzonego w repozytorium pakietu, opisanego w podrozdziale [Rejestr poleceń](07-agent-cli.md#rejestr-poleceń). Do aneksu przenosisz polecenia istotne, a nie wszystkie: te, które doprowadziły do powstania funkcji publicznych, oraz te, przy których musiałeś poprawić otrzymany wynik.

Kolumna „zmiany własne” jest w tym aneksie najważniejsza. Widać w niej, gdzie kończy się agent, a zaczynasz Ty. Aneks, w którym ta kolumna jest wszędzie pusta, świadczy przeciwko pracy.

## Przygotowanie do obrony

Komisja może zapytać o dowolny fragment kodu. Przygotowanie polega na przejściu pakietu funkcja po funkcji i odpowiedzeniu sobie na trzy pytania.

Co ta funkcja liczy i który krok algorytmu ze specyfikacji realizuje? Dlaczego liczy to akurat w ten sposób, skoro dałoby się inaczej? Co się stanie, gdy podać jej dane, których się nie spodziewa?

Jeżeli na którekolwiek pytanie nie umiesz odpowiedzieć, masz w pakiecie kod, którego nie rozumiesz. Zostało jeszcze dość czasu, żeby to naprawić: przeczytać ponownie odpowiedni fragment artykułu, uprościć funkcję albo napisać ją od nowa.

## Granica, której nie przekraczamy

Na koniec zdanie, które warto sobie powtórzyć przed każdym poleceniem wydanym agentowi.

Agent może napisać kod, który przechodzi Twoje testy. Nie przeczyta za Ciebie artykułu, nie rozstrzygnie niedopowiedzenia metody, nie zdecyduje, co zrobić z brakami danych, ani nie wyciągnie wniosku z wyników. **Te rzeczy są pracą dyplomową.** Reszta jest jej zapisem.

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).

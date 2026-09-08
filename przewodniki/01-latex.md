# LaTeX od podstaw

W rozdziale poznajesz LaTeX-a na wzorze, którym piszesz pracę, a nie w oderwaniu od niego. Wszystkie przykłady działają bez dodatkowej konfiguracji, bo ustawienia składu są w *klasie dokumentu*, czyli w pliku, w którym zapisany jest cały wygląd pracy. Twoja klasa to `epi-praca.cls` i nie musisz do niej zaglądać.

Podziel naukę na trzy wieczory. Po pierwszym umiesz złożyć tekst z rozdziałami i cytowaniami. Po drugim – tabele, rysunki i wzory. Trzeci przyda się dopiero przy redakcji.

## Jak myśleć o LaTeX-u

W edytorze tekstu zaznaczasz fragment i nadajesz mu wygląd. W LaTeX-u **opisujesz, czym fragment jest**, a wygląd wynika z tego automatycznie. Piszesz „to jest tytuł rozdziału”, a nie „to ma być osiemnaście punktów, wytłuszczone, wyśrodkowane”.

Ma to trzy konsekwencje, które w pracy licencjackiej są warte więcej niż koszt nauki. Skład jest zgodny z wymogami Instytutu z definicji, a nie dlatego, że pamiętałeś o ustawieniu interlinii w każdym akapicie. Spis treści, spis ilustracji, bibliografia i indeks nazwisk powstają same z tego, co napisałeś w tekście – nie da się mieć w spisie treści rozdziału, którego nie ma. Wzory matematyczne są zapisem, a nie obrazkiem, co przy pracy pełnej wzorów z artykułu metodycznego przestaje być wygodą, a staje się warunkiem wykonalności.

Kosztem jest to, że pliku źródłowego się nie ogląda – trzeba go najpierw *skompilować*, czyli przetworzyć w gotowy dokument PDF. Do tego przyzwyczaisz się w pierwszy dzień.

## Poziom pierwszy: tekst i struktura

### Anatomia dokumentu

Praca składa się z pliku głównego i plików rozdziałów.

```latex
\documentclass{epi-praca}        % klasa: caly sklad

\addbibresource{bibliografia/literatura.bib}
\autor{Jan Kowalski}             % metadane
\tytul{Tytul pracy}

\begin{document}                 % poczatek tresci
\stronatytulowa
\tableofcontents
\input{rozdzialy/00-wprowadzenie}
\end{document}                   % koniec tresci
```

Wszystko przed `\begin{document}` to *preambuła*, czyli ustawienia. Wszystko między `\begin{document}` a `\end{document}` to treść. W Twojej pracy preambuła jest już gotowa; uzupełniasz w niej wyłącznie metadane.

**Polecenie** zaczyna się od ukośnika wstecznego i mówi, co ma zostać zrobione. To, na czym polecenie działa, nazywa się *argumentem*. Argumenty obowiązkowe są w nawiasach klamrowych, opcjonalne w kwadratowych: w zapisie `\includegraphics[width=5cm]{wykres.png}` nazwa pliku jest argumentem obowiązkowym, a szerokość opcjonalnym.

**Środowisko** obejmuje cały fragment tekstu i ma jawny początek oraz koniec. Otwiera je `\begin` z nazwą, zamyka `\end` z tą samą nazwą, a wszystko pomiędzy składa się według reguł tego środowiska – jak `quote` dla cytatu blokowego albo `tabular` dla tabeli. Środowiskiem jest też sam dokument, o czym mówi para poleceń z przykładu wyżej.

### Akapity i spacje

Nowy akapit zaczyna się po **pustej linii**. Pojedyncze złamanie wiersza w pliku źródłowym nie znaczy nic – LaTeX i tak złoży tekst od nowa. Wielokrotne spacje redukują się do jednej. Nie wymuszaj odstępów spacjami ani pustymi liniami; od tego są polecenia, a w Twojej pracy odstępy ustawia klasa.

W seminarium obowiązuje jedna zasada zapisu źródła: **jeden akapit w jednym wierszu**. Akapitu nie łamiemy w pliku, bez względu na jego długość; wiersze rozdziela wyłącznie pusta linia. Powód jest praktyczny – porównanie wersji pokazuje wtedy, który akapit się zmienił, zamiast lawiny przesuniętych wierszy po dopisaniu jednego słowa. Ma to znaczenie przy pracy z promotorem i w historii repozytorium, a edytory i tak zawijają długie wiersze na ekranie. Zasada nie dotyczy wnętrza listingów, tabel i wzorów ani pozycji list wypunktowanych.

**Twarda spacja** zapisywana tyldą nie pozwala złamać wiersza w danym miejscu. Używaj jej tam, gdzie przeniesienie wygląda źle:

```latex
rysunek~\ref{rys:mapa}    s.~15-21    prof.~Kowalski    nr~3
```

### Polskie znaki i typografia

Piszesz normalnie: zażółć gęślą jaźń. Plik musi być zapisany w UTF-8; Overleaf i Positron robią to domyślnie.

**Tabela 2. Zapis typograficzny**

| Chcesz | Piszesz | Efekt |
|---|---|---|
| cudzysłów polski | `\enquote{cytat}` | „cytat” |
| cytat w cytacie | `\enquote{a \enquote{b} c}` | „a «b» c” |
| półpauza | `--` | – |
| łącznik | `-` | - |

Cudzysłowów nie wpisuj ręcznie. Polecenie `\enquote` dobiera je do języka i poprawnie zagnieżdża, dokładnie tak, jak przewiduje Instrukcja (Instrukcja ISI).

W seminarium obowiązuje jedna zasada typograficzna wykraczająca poza wymogi Instytutu: **nie stosujemy pauzy**, czyli trzech łączników. Zdanie wtrącone wydzielamy półpauzą z odstępem po obu stronach – tak jak w tym zdaniu. Łącznik pozostaje łącznikiem w wyrazach złożonych i w zakresach stron.

Kilka znaków ma w LaTeX-u znaczenie specjalne i żeby pojawiły się w tekście, trzeba je poprzedzić ukośnikiem: procent, dolar, ampersand, podkreślenie, kratka i nawiasy klamrowe. Najczęściej potykasz się o podkreślenie w nazwach funkcji – dlatego do nazw służą polecenia opisane w podrozdziale [Polecenia własne wzoru](#polecenia-własne-wzoru), które robią to za Ciebie.

### Rozdziały i podrozdziały

```latex
\chapter{Podstawy metodyczne}          % 1
\section{Aparat formalny}              % 1.1
\subsection{Normalizacja}              % 1.1.1
```

Numeracja jest automatyczna. Nie wpisuj numerów ręcznie – po wstawieniu rozdziału w środku przenumerowanie zajmie sekundę, a nie godzinę. Elementy nienumerowane, obecne mimo to w spisie treści, mają własne polecenia: `\wprowadzenie`, `\podsumowanie`, `\wykazzrodel`, `\aneksy`.

### Etykiety i odsyłacze

To jest funkcja, dla której warto uczyć się LaTeX-a. Nadajesz obiektowi etykietę i odwołujesz się do niej po nazwie; numer wstawia się sam i zawsze jest poprawny.

```latex
\section{Aparat formalny}\label{sec:aparat}

Metode omowiono w podrozdziale~\ref{sec:aparat} na stronie~\pageref{sec:aparat}.
```

**Tabela 3. Konwencja przedrostków w etykietach**

| Przedrostek | Obiekt |
|---|---|
| `sec:` | rozdział, podrozdział |
| `tab:` | tabela |
| `rys:` | rysunek |
| `wyk:` | wykres |
| `lst:` | listing |
| `eq:` | wzór |

Odsyłacz do nieistniejącej etykiety daje w gotowym pliku dwa znaki zapytania i ostrzeżenie `Reference ... undefined`. Zawsze sprawdzaj je przed oddaniem.

### Cytowania

```latex
\parencite{cisek2002filozoficzne}                  % (Cisek 2002)
\parencite[s.~15-21]{kowalski2010a}                % (Kowalski 2010a, s. 15-21)
\parencite{klucz1,klucz2}                          % (A 2019; B 2020)
\textcite{wozniak1997kognitywizm} pokazuje, ze...  % Wozniak (1997) pokazuje, ze...
```

Postać cytowania – inicjał przy zbieżnych nazwiskach, skrót „i in.” przy więcej niż trzech autorach, sufiksy rocznika przy tym samym roku – dobiera styl automatycznie. Twoim zadaniem jest poprawny wpis w pliku bibliograficznym, opisany w rozdziale [Bibliografia: plik BibTeX i Zotero](02-bibliografia.md#bibliografia-plik-bibtex-i-zotero).

### Polecenia własne wzoru

Nie sięgaj po polecenia formatujące bezpośrednio. Wzór ma polecenia, które mówią, **czym** coś jest, i dobierają wygląd zgodnie z wymogami Instytutu.

**Tabela 4. Polecenia semantyczne wzoru**

| Polecenie | Zastosowanie | Wygląd |
|---|---|---|
| `\fun{przygotuj_dane}` | nazwa funkcji | `przygotuj_dane()` |
| `\argument{skala}` | nazwa argumentu | `skala` |
| `\pkg{ggplot2}` | nazwa pakietu | `ggplot2` |
| `\plik{R/algorytm.R}` | plik lub katalog | `R/algorytm.R` |
| `\kod{x <- 1}` | krótki kod w zdaniu | `x <- 1` |
| `\termin{fuzzyfikacja}` | termin, wyraz obcy, tytuł | *fuzzyfikacja* |
| `\wyroznienie{ważne}` | wyróżnienie treściowe | **ważne** |
| `\osoba{Nowak}{Jan}` | osoba | Jan Nowak plus wpis do indeksu |

Rozróżnienie kursywy i wytłuszczenia nie jest kwestią gustu: Instrukcja przewiduje kursywę dla wyrazów obcych i tytułów, a wytłuszczenie dla wyróżnień w tekście (Instrukcja ISI).

Polecenie `\osoba` stosuj **od pierwszego dnia**. Indeks nazwisk powstaje z tych poleceń, a uzupełnianie go na końcu to kilka godzin pracy.

## Poziom drugi: tabele, rysunki, wzory

### Listy i cytaty

Listy stosuj tam, gdzie kolejność albo równorzędność elementów jest istotna. Nie zastępuj nimi wywodu – praca złożona z wypunktowań czyta się jak prezentacja i tak jest oceniana.

Fragment dłuższy niż dwa lub trzy zdania wyodrębniasz graficznie, czego wymaga Instrukcja:

```latex
\begin{quote}
Kryterium, w ktorym oceny wariantow sa do siebie zblizone, niesie malo
informacji rozniczujacej i powinno otrzymac wage nizsza.
\end{quote}
```

### Tabele

Tabela w pracy ma tytuł nad sobą i źródło pod sobą. Składa ją środowisko `tabelaepi`, które przyjmuje tytuł i etykietę, a opcjonalnie także położenie.

```latex
\begin{tabelaepi}{Moduly pakietu}{tab:moduly}
\begin{tabular}{@{}lll@{}}
\toprule
Plik & Odpowiedzialnosc & Funkcje eksportowane \\
\midrule
\plik{algorytm.R} & obliczenia & \fun{oblicz_ranking} \\
\bottomrule
\end{tabular}
\zrodlo{oprac. wlasne}
\end{tabelaepi}
```

Wnętrze `tabular` czyta się tak. Deklaracja kolumn podaje ich wyrównanie: `l` do lewej, `r` do prawej, `c` do środka, `p{3cm}` kolumna o stałej szerokości z łamaniem wiersza. Zapis `@{}` na brzegach usuwa wcięcie. Komórki rozdziela ampersand, a wiersz kończą dwa ukośniki. Linie poziome dają `\toprule`, `\midrule` i `\bottomrule` – i tylko one. Tabela naukowa nie ma linii pionowych ani kratownicy.

Tabela szersza niż strona: użyj `tabularx` z kolumną `X`, która sama dobierze szerokość. Tabela dłuższa niż strona przenosi się do aneksu, tak stanowi Instrukcja.

### Rysunki

```latex
\begin{rysunekepi}{Mapa decyzyjna wariantow}{rys:mapa}
\includegraphics[width=0.78\textwidth]{przyklad-wykres.png}
\zrodlo{oprac. wlasne}
\end{rysunekepi}
```

Pliki graficzne trzymaj w katalogu `rysunki/` – klasa szuka ich tam automatycznie, więc podajesz samą nazwę pliku. Szerokość podawaj względem szerokości tekstu, nie w centymetrach. Wykresy z R zapisuj w wysokiej rozdzielczości:

```r
png("rysunki/wykres.png", width = 1600, height = 1000, res = 220)
plot(x, y)
dev.off()
```

Wykres liczbowy wstawiaj przez środowisko `wykresepi`; ma osobną numerację, tak jak wymaga Instrukcja.

Tabele, rysunki i wykresy są *pływakami*: LaTeX umieszcza je tam, gdzie wychodzi najlepiej, niekoniecznie w miejscu wpisania. To nie jest usterka, tylko sposób, w jaki unika się dziur na stronach. Nie walcz z tym w trakcie pisania – zajmij się tym przy redakcji, a w tekście zawsze odsyłaj przez etykietę, nigdy przez zwrot „poniższa tabela”, bo pływak może wylądować stronę dalej.

### Położenie pływaka

Miejsce, w którym pływak wolno postawić, ustala się literami podanymi w nawiasie kwadratowym, przed tytułem:

```latex
\begin{tabelaepi}[H]{Moduly pakietu}{tab:moduly}
```

**Tabela 5. Litery położenia pływaka**

| Litera | Znaczenie |
|---|---|
| `h` | tutaj, jeżeli w tym miejscu zostało dość miejsca |
| `t` | u góry strony |
| `b` | u dołu strony |
| `p` | na osobnej stronie złożonej z samych pływaków |
| `!` | bez oglądania się na ograniczenia wypełnienia strony |
| `H` | dokładnie tutaj, bez pływania |

Litery poza `H` łączy się i podaje w kolejności, w jakiej LaTeX ma próbować. Domyślnie wzór stosuje `htbp`, czyli najpierw tutaj, potem góra, dół i osobna strona; przy zwykłej tabeli nie musisz podawać niczego.

`H` działa inaczej niż pozostałe: nie jest propozycją, tylko poleceniem. Obiekt zostaje dokładnie tam, gdzie go wpisałeś, a jeżeli nie mieści się na stronie, zostaje przeniesiony w całości na następną, zostawiając pustkę. Stąd zasada praktyczna: **sięgaj po `H` tylko wtedy, gdy obiekt trzeba czytać razem ze zdaniem obok** – mała tabela z dwiema liczbami, rysunek, do którego odnosi się kolejne zdanie. Przy większych obiektach efektem jest strona w połowie pusta.

Gdy pływaki zbiorą się i wyjdą poza rozdział, w którym są omawiane, wstaw `\clearpage` przed końcem rozdziału. Domknie to stronę i wypchnie wszystkie zaległe obiekty przed dalszą treść.

### Wzory

Wzory składa się w *trybie matematycznym*, w którym symbole ustawiane są inaczej niż zwykły tekst: kursywą i z własnymi odstępami. Wzór w linii otacza się znakami dolara, które ten tryb włączają i wyłączają. Wzór wyróżniony i numerowany zapisuje się tak:

```latex
\begin{equation}\label{eq:cc}
  CC_i = \frac{d_i^{-}}{d_i^{+} + d_i^{-}}.
\end{equation}

We wzorze \eqref{eq:cc} symbol $d_i^{+}$ oznacza...
```

Daje to wynik:

$$
CC_i = \frac{d_i^{-}}{d_i^{+} + d_i^{-}} \qquad (1)
$$

Wzór bez numeru zapisuje się w nawiasach kwadratowych poprzedzonych ukośnikiem. Kilka wzorów wyrównanych do znaku równości składa środowisko `align`.

**Tabela 6. Zapis matematyczny**

| Chcesz | Piszesz |
|---|---|
| ułamek | `\frac{a}{b}` |
| indeks dolny i górny | `x_i`, `x^2`, `x_{ij}^{+}` |
| suma, iloczyn | `\sum_{i=1}^{n}`, `\prod_{j=1}^{m}` |
| pierwiastek | `\sqrt{x}` |
| nawiasy skalujące się | `\left( ... \right)` |
| litery greckie | `\alpha`, `\lambda`, `\Phi` |
| wartość bezwzględna | `\lvert x \rvert` |
| tekst wewnątrz wzoru | `\text{dla } x > 0` |
| macierz | `\begin{pmatrix} a & b \\ c & d \end{pmatrix}` |

Symbole zostawiaj takie jak w artykule źródłowym – czytelnik ma móc porównać. I pamiętaj o zasadzie z podrozdziału [Rozdział pierwszy: podstawy metodyczne](04-jak-pisac.md#rozdział-pierwszy-podstawy-metodyczne): po każdym wzorze następuje akapit objaśniający, co ten wzór wyraża i po co jest w pracy.

### Listingi kodu

*Listing* to fragment kodu wydzielony z tekstu i złożony pismem maszynowym, z własnym numerem i podpisem, tak samo jak tabela czy rysunek. Standardy mówią o *fragmentach kodu* (Standardy EPI); nazwa „listing” jest utrwaloną nazwą tego elementu w pracach informatycznych i tak też podpisuje go wzór, numerując listingi ciągle przez całą pracę.

```latex
\begin{lstlisting}[caption={Wyznaczanie wag},label={lst:wagi}]
oblicz_wagi <- function(macierz) {
  stopifnot(is.matrix(macierz))
  colSums(macierz) / sum(macierz)
}
\end{lstlisting}
```

Kolorowanie składni, numerację wierszy i ramkę ustawia klasa. Kod z pliku wstawisz poleceniem `\listingR`, które przyjmuje podpis, etykietę i ścieżkę – wtedy listing zawsze odpowiada aktualnej wersji kodu.

**Wnętrze listingu musi być zapisane wyłącznie znakami ASCII.** Komentarze w kodzie pisz bez polskich znaków diakrytycznych. Powód jest podwójny. Tablica znaków pakietu składającego listingi obejmuje tylko ASCII, więc polskie litery nie tyle znikają, co **wędrują na początek wyrazu**: zapisane w kodzie słowo `ścieżka` złoży się jako `śżcieka`. Usterka jest cicha, bo kompilacja kończy się bez błędu. Sprawdzanie pakietu R zgłasza z kolei znaki spoza ASCII w kodzie źródłowym jako problem przenośności, więc to samo ograniczenie obowiązuje w repozytorium. Podpis listingu jest zwykłym tekstem pracy i polskich znaków używać może; ograniczenie dotyczy wyłącznie wnętrza. Kontroli służy skrypt `tools/sprawdz-listingi.R`, ale wymaga on R, więc działa tylko **lokalnie**. **Na Overleaf** objaw widać wprost w złożonym dokumencie: litery w listingu są poprzestawiane.

Zostaje pytanie, co zrobić, gdy trzeba pokazać tekst polski złożony pismem maszynowym: komunikat błędu, wynik działania programu, fragment danych. Do tego służy osobne środowisko `wydruk`, które **polskie znaki składa poprawnie**, bo korzysta z innego pakietu:

```latex
\begin{wydruk}
Blad: kolumna "ocena jakosci" zawiera wartosci spoza zakresu.
\end{wydruk}
```

Cena jest taka, że nie ma tam kolorowania składni ani numeracji wierszy. Podział jest więc prosty: **kod idzie do listingu, wyjście programu do wydruku**. Kodowi ograniczenie i tak nie przeszkadza, bo sprawdzanie pakietu R wymaga ASCII niezależnie od składu.

## Poziom trzeci: przy redakcji

### Praca w wielu plikach

Rozdziały są osobnymi plikami włączanymi poleceniem `\input`, podawanym bez rozszerzenia. Dzięki temu nie przewijasz tysiąca wierszy i łatwiej znaleźć miejsce błędu. Żeby przy pisaniu jednego rozdziału kompilować tylko jego, zakomentuj pozostałe polecenia włączenia w pliku głównym. Przed oddaniem odkomentuj wszystkie – inaczej numeracja, spis treści i bibliografia będą niepełne.

Znak procentu wyłącza resztę wiersza. Komentarze służą do notatek dla siebie i znikają z gotowego pliku. Przed oddaniem przejrzyj je i usuń te, które są notatkami roboczymi.

### Kontrola typografii

Klasa blokuje *wdowy i sieroty*, czyli pojedyncze wiersze akapitu odcięte na końcu albo na początku strony, ale zdarza się, że LaTeX nie umie złamać zbyt długiego słowa i wypuszcza je poza margines. W dzienniku kompilacji zobaczysz wtedy komunikat `Overfull \hbox`. Naprawiaj w tej kolejności: przeformułuj zdanie, co najczęściej jest najlepszym rozwiązaniem; podpowiedz miejsce podziału zapisem `wielo\-kryterialny`; przy długim adresie sieciowym użyj polecenia `\url`, które pozwala łamać w sensownych miejscach. Liczba nadmiarowych pudełek w gotowej pracy powinna być zerowa albo bliska zeru.

### Sekwencja kompilacji

Pełne złożenie pracy wymaga kilku przebiegów, bo spis treści, odsyłacze, bibliografia i indeks potrzebują danych z przebiegu poprzedniego. Kolejność to LuaLaTeX, potem `biber`, który składa bibliografię z pliku źródeł, potem `makeindex`, który porządkuje indeks nazwisk, a na koniec dwa razy LuaLaTeX.

**Na Overleaf.** Sekwencja uruchamia się sama po naciśnięciu przycisku kompilacji i nie musisz o niej pamiętać.

**Lokalnie.** Całą sekwencję uruchamia za Ciebie `latexmk`, wywoływany z katalogu pracy:

```bash
latexmk -lualatex main.tex
```

Skutek praktyczny jest w obu ścieżkach ten sam: **po dodaniu nowego cytowania albo etykiety pierwsza kompilacja może pokazać znaki zapytania** – po drugiej znikną.

Przy okazji powstaje kilkanaście *plików pomocniczych*, o rozszerzeniach `.aux`, `.toc` czy `.bbl`. To w nich LaTeX przechowuje między przebiegami numery rozdziałów, strony odsyłaczy i złożoną bibliografię. Przydaje się to do momentu, w którym kompilacja zaczyna zachowywać się dziwnie, bo uszkodzony plik pomocniczy potrafi utrzymywać błąd, którego w źródle już nie ma. Czyszczenie wygląda wtedy różnie w obu ścieżkach: **lokalnie** usuwa je polecenie `latexmk -c`, **na Overleaf** służy do tego *Recompile from scratch* z rozwijanego menu obok przycisku kompilacji.

## Diagnostyka

### Jak czytać błąd

Komunikat zaczyna się od wykrzyknika, a numer wiersza stoi w linii rozpoczynającej się od litery `l` z kropką. Trzy rzeczy warto wiedzieć. Wiersz wskazany w błędzie bywa o jeden dalej niż przyczyna, bo brakujący nawias zamykający zgłasza się dopiero tam, gdzie coś przestało się zgadzać. Pierwszy błąd jest ważny, a reszta zwykle z niego wynika, więc napraw pierwszy i skompiluj ponownie, zamiast czytać wszystkie. Na Overleaf przełącz widok na pełny dziennik, gdy podsumowanie nie wystarcza.

### Katalog błędów

**Tabela 7. Najczęstsze błędy kompilacji**

| Komunikat albo objaw | Przyczyna | Naprawa |
|---|---|---|
| `Undefined control sequence` | literówka w poleceniu | sprawdź pisownię w tabeli **Polecenia semantyczne wzoru** |
| `Missing $ inserted` | znak matematyczny poza trybem matematycznym | otocz znakami dolara albo poprzedź ukośnikiem |
| `Missing \begin{document}` | tekst wpisany w preambule | przenieś treść za początek dokumentu |
| `File ... not found` | zła nazwa albo ścieżka grafiki | grafiki trzymaj w `rysunki/` |
| `Environment ... undefined` | literówka w nazwie środowiska | porównaj początek i koniec |
| `\begin ended by \end` | niedomknięte środowiska | sprawdź parowanie |
| `Extra alignment tab` | za dużo ampersandów w wierszu | policz kolumny w deklaracji |
| `Misplaced alignment tab` | ampersand poza tabelą | poprzedź go ukośnikiem |
| `Citation ... undefined` | klucz nieobecny w pliku bibliograficznym | sprawdź klucz, skompiluj dwa razy |
| `Reference ... undefined` | odsyłacz do nieistniejącej etykiety | sprawdź etykietę, skompiluj dwa razy |
| `Empty bibliography` | brak cytowań w tekście | dodaj cytowanie |
| `Overfull \hbox` | tekst wychodzi poza margines | przeformułuj zdanie |
| `Underfull \hbox` | zbyt rozstrzelony wiersz | zwykle można zignorować |
| `There's no line here to end` | podwójny ukośnik bez wiersza | usuń go, do akapitu wystarczy pusta linia |
| `Paragraph ended before ...` | brakujący nawias klamrowy | sprawdź parowanie |
| `Package inputenc Error` | plik w innym kodowaniu niż UTF-8 | zapisz ponownie w UTF-8 |
| przestawione polskie litery w listingu | znaki spoza ASCII w kodzie | usuń diakrytykę |
| kod bez właściwego kroju pisma | dokument złożony pdfLaTeX-em | ustaw kompilator na LuaLaTeX |
| brak indeksu nazwisk | brak polecenia `\osoba` | dodaj polecenia i skompiluj |
| dokument nie odświeża się mimo zmian | uszkodzone pliki pomocnicze | pełne złożenie od zera; lokalnie `latexmk -c` |

### Gdy nic nie pomaga

Wykonaj pełną kompilację od zera po usunięciu plików pomocniczych. Następnie zakomentuj połowę treści i skompiluj, żeby zawęzić, w której połowie jest problem; powtórz kilka razy, aż zostanie kilka wierszy. Na koniec sprawdź, czy problem występuje też w dokumencie pokazowym dołączonym do wzoru – jeżeli tak, przyczyna leży w środowisku, a nie w Twoim tekście.

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).

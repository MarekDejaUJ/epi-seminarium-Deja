# LaTeX od podstaw

Przewodnik uczy LaTeX-a na wzorze z katalogu [`wzor-pracy/`](../wzor-pracy/), a nie
w oderwaniu od niego. Wszystkie przykłady działają w Twojej pracy bez dodatkowej
konfiguracji, bo skład ustawia klasa `epi-praca.cls`.

Podziel naukę na trzy wieczory. Po pierwszym umiesz złożyć tekst z rozdziałami
i powołaniami. Po drugim — tabele, rysunki i wzory. Trzeci przyda się dopiero
przy redakcji.

---

## Zanim zaczniesz: jak myśleć o LaTeX-u

W edytorze tekstu zaznaczasz fragment i nadajesz mu wygląd. W LaTeX-u **opisujesz, czym
fragment jest**, a wygląd wynika z tego automatycznie. Piszesz „to jest tytuł rozdziału",
a nie „to ma być 18 punktów, wytłuszczone, wyśrodkowane".

Ma to trzy konsekwencje, które w pracy licencjackiej są warte więcej niż koszt nauki:

- **Skład jest zgodny z wymogami Instytutu z definicji**, a nie dlatego, że pamiętałeś
  o ustawieniu interlinii w każdym akapicie.
- **Bibliografia, spis treści, spis ilustracji i indeks nazwisk powstają same** z tego,
  co napisałeś w tekście. Nie da się mieć w spisie treści rozdziału, którego nie ma.
- **Wzory matematyczne są zapisem, nie obrazkiem.** Przy pracy pełnej wzorów z artykułu
  metodycznego to przestaje być wygodą, a staje się warunkiem wykonalności.

Kosztem jest to, że pliku źródłowego się nie ogląda — trzeba go skompilować. Do tego
się przyzwyczaisz w pierwszy wieczór.

---

## Poziom pierwszy: tekst i struktura

### Pierwsza kompilacja

Otwórz projekt na Overleaf albo lokalnie, ustaw kompilator na **LuaLaTeX**
(szczegóły w [przewodniku o Overleaf](03-overleaf-i-wspolpraca.md)) i naciśnij
*Recompile*. Powinieneś zobaczyć stronę tytułową z wypełnionymi metadanymi.

### Anatomia dokumentu

Twoja praca składa się z pliku głównego i plików rozdziałów.

```latex
\documentclass{epi-praca}        % klasa: cały skład

\addbibresource{bibliografia/literatura.bib}
\autor{Jan Kowalski}             % metadane
\tytul{...}

\begin{document}                 % początek treści
\stronatytulowa
\tableofcontents
\input{rozdzialy/00-wprowadzenie}
\end{document}                   % koniec treści
```

Wszystko przed `\begin{document}` to **preambuła** — ustawienia. Wszystko między
`\begin{document}` a `\end{document}` to treść. W Twojej pracy preambuła jest już
gotowa; uzupełniasz w niej wyłącznie metadane.

**Polecenie** zaczyna się od ukośnika wstecznego: `\tableofcontents`. Argumenty
obowiązkowe idą w nawiasach klamrowych, opcjonalne w kwadratowych:

```latex
\includegraphics[width=0.8\textwidth]{wykres.png}
```

**Środowisko** ma początek i koniec:

```latex
\begin{quote}
Treść cytatu blokowego.
\end{quote}
```

### Akapity i spacje

Nowy akapit robi **pusta linia**. Pojedyncze złamanie wiersza w pliku źródłowym nie
znaczy nic — LaTeX i tak złoży tekst od nowa.

```latex
To jest pierwszy akapit. Ten tekst
i tak trafi do jednego akapitu,
mimo złamanych wierszy.

To jest drugi akapit.
```

Wielokrotne spacje są redukowane do jednej. Nie wymuszaj odstępów spacjami ani pustymi
liniami — od tego są polecenia, a w Twojej pracy odstępy ustawia klasa.

**Twarda spacja** `~` nie pozwala złamać wiersza w tym miejscu. Używaj jej tam, gdzie
przeniesienie wygląda źle:

```latex
rysunek~\ref{rys:mapa}      % nie "rysunek" na końcu wiersza i "1" na początku następnego
s.~15-21
prof.~Kowalski
```

### Polskie znaki i typografia

Piszesz normalnie: `zażółć gęślą jaźń`. Plik musi być zapisany w UTF-8 — Overleaf
i Positron robią to domyślnie.

| Chcesz | Piszesz | Efekt |
|---|---|---|
| cudzysłów polski | `\enquote{cytat}` | „cytat" |
| cytat w cytacie | `\enquote{a \enquote{b} c}` | „a «b» c" |
| półpauza (myślnik) | `--` | – |
| pauza | `---` | — |
| dywiz (łącznik) | `-` | - |

Cudzysłowów nie wpisuj ręcznie. `\enquote{}` dobiera je do języka i poprawnie zagnieżdża.

Znaki zastrzeżone wymagają ucieczki: `\% \$ \& \_ \# \{ \}`. Najczęściej potykasz się
o podkreślenie w nazwach funkcji — dlatego do nazw służą polecenia `\fun{}` i `\plik{}`,
które robią to za Ciebie.

### Rozdziały i podrozdziały

```latex
\chapter{Podstawy metodyczne}          % 1
\section{Aparat formalny}              % 1.1
\subsection{Normalizacja}              % 1.1.1
```

Numeracja jest automatyczna. Nie wpisuj numerów ręcznie — po wstawieniu rozdziału
w środku przenumerowanie zajmie sekundę, a nie godzinę.

Elementy nienumerowane, obecne mimo to w spisie treści, mają własne polecenia:
`\wprowadzenie`, `\podsumowanie`, `\wykazzrodel`, `\aneksy`.

### Etykiety i odsyłacze

To jest funkcja, dla której warto uczyć się LaTeX-a. Nadajesz obiektowi etykietę
i odwołujesz się do niej po nazwie; numer wstawia się sam i zawsze jest poprawny.

```latex
\section{Aparat formalny}\label{sec:aparat}
...
Metodę omówiono w podrozdziale~\ref{sec:aparat} na stronie~\pageref{sec:aparat}.
```

Konwencja przedrostków, warta trzymania od początku:

| Przedrostek | Obiekt |
|---|---|
| `sec:` | rozdział, podrozdział |
| `tab:` | tabela |
| `rys:` | rysunek |
| `wyk:` | wykres |
| `lst:` | listing |
| `eq:` | wzór |

Odsyłacz do nieistniejącej etykiety daje w PDF-ie dwa znaki zapytania i ostrzeżenie
`Reference ... undefined`. Zawsze sprawdzaj je przed oddaniem.

### Powołania

```latex
\parencite{cisek2002filozoficzne}                  % (Cisek 2002)
\parencite[s.~15-21]{kowalski2010a}                % (Kowalski 2010a, s. 15-21)
\parencite{klucz1,klucz2}                          % (A 2019; B 2020)
\textcite{wozniak1997kognitywizm} pokazuje, że...  % Woźniak (1997) pokazuje, że...
```

Postać powołania — inicjał przy zbieżnych nazwiskach, „i in." przy więcej niż trzech
autorach, sufiksy `a`/`b` przy tym samym roku — dobiera styl automatycznie. Twoim
zadaniem jest poprawny wpis w pliku `.bib`; opisuje go
[przewodnik o bibliografii](02-bibliografia-bib-zotero.md).

### Polecenia własne wzoru

Nie sięgaj po `\textit` ani `\textbf` bezpośrednio. Wzór ma polecenia, które mówią,
**czym** coś jest, i dobierają wygląd zgodnie z wymogami Instytutu:

| Polecenie | Zastosowanie | Wygląd |
|---|---|---|
| `\fun{przygotuj_dane}` | nazwa funkcji | `przygotuj_dane()` |
| `\argument{skala}` | nazwa argumentu | pismo maszynowe |
| `\pkg{ggplot2}` | nazwa pakietu | pismo maszynowe |
| `\plik{R/algorytm.R}` | plik lub katalog | pismo maszynowe |
| `\kod{x <- 1}` | krótki kod w zdaniu | pismo maszynowe |
| `\termin{fuzzyfikacja}` | termin wprowadzany, wyraz obcy, tytuł dzieła | *kursywa* |
| `\wyroznienie{ważne}` | wyróżnienie treściowe | **wytłuszczenie** |
| `\osoba{Hjørland}{Birger}` | osoba | „Birger Hjørland" plus wpis do indeksu |

Rozróżnienie kursywy i wytłuszczenia nie jest kwestią gustu: Instrukcja ISI przewiduje
kursywę dla wyrazów obcych i tytułów, a wytłuszczenie dla wyróżnień w tekście.

**`\osoba{}{}` stosuj od pierwszego dnia.** Indeks nazwisk powstaje z tych poleceń;
uzupełnianie go na końcu to kilka godzin pracy.

---

## Poziom drugi: tabele, rysunki, wzory

### Listy

```latex
\begin{itemize}
  \item element bez numeru
  \item drugi element
\end{itemize}

\begin{enumerate}
  \item element numerowany
  \item drugi
\end{enumerate}

\begin{description}
  \item[Termin] objaśnienie terminu
\end{description}
```

Listy stosuj tam, gdzie kolejność albo równorzędność elementów jest istotna. Nie zastępuj
nimi wywodu — praca złożona z wypunktowań czyta się jak prezentacja i tak jest oceniana.

### Cytat blokowy

Fragment dłuższy niż dwa–trzy zdania wyodrębniasz graficznie — tego wymaga Instrukcja:

```latex
\begin{quote}
Kryterium, w którym oceny wariantów są do siebie zbliżone, niesie mało informacji
różnicującej i powinno otrzymać wagę niższą.
\end{quote}
```

### Tabele

Tabela w pracy ma tytuł nad sobą i źródło pod sobą. Robi to środowisko `tabelaepi`,
które przyjmuje tytuł i etykietę:

```latex
\begin{tabelaepi}{Moduły pakietu i ich odpowiedzialność}{tab:moduly}
\begin{tabular}{@{}lll@{}}
\toprule
Plik & Odpowiedzialność & Funkcje eksportowane \\
\midrule
\plik{przygotowanie\_danych.R} & walidacja & \fun{przygotuj\_dane} \\
\plik{algorytm.R}              & obliczenia & \fun{oblicz\_ranking} \\
\bottomrule
\end{tabular}
\zrodlo{oprac. własne}
\end{tabelaepi}
```

Wnętrze `tabular` czyta się tak:

- `{@{}lll@{}}` — trzy kolumny wyrównane do lewej; `@{}` usuwa wcięcie na brzegach;
- `l` lewa, `r` prawa, `c` środek, `p{3cm}` kolumna o stałej szerokości z łamaniem wiersza;
- `&` rozdziela komórki, `\\` kończy wiersz;
- `\toprule`, `\midrule`, `\bottomrule` to trzy linie poziome — **i tylko one**.
  Tabela naukowa nie ma linii pionowych ani kratownicy.

Tabela szersza niż strona: użyj `tabularx` z kolumną `X`, która sama dobierze szerokość:

```latex
\begin{tabularx}{\textwidth}{@{}lX@{}}
\toprule
Argument & Opis \\
\midrule
\argument{skala} & Zakres normalizacji podany jako wektor dwuelementowy \\
\bottomrule
\end{tabularx}
```

Tabela dłuższa niż strona przenosi się do aneksu — tak stanowi Instrukcja.

### Rysunki

```latex
\begin{rysunekepi}{Mapa decyzyjna wariantów}{rys:mapa}
\includegraphics[width=0.78\textwidth]{przyklad-wykres.png}
\zrodlo{oprac. własne}
\end{rysunekepi}
```

Pliki graficzne trzymaj w katalogu `rysunki/` — klasa szuka ich tam automatycznie,
więc podajesz samą nazwę pliku.

Szerokość podawaj **względem szerokości tekstu** (`0.78\textwidth`), nie w centymetrach.
Wykresy z R zapisuj w wysokiej rozdzielczości:

```r
png("rysunki/wykres.png", width = 1600, height = 1000, res = 220)
plot(...)
dev.off()
```

Wykres liczbowy wstawiaj przez `wykresepi` — ma osobną numerację, tak jak wymaga
Instrukcja.

### Pływaki

Tabele i rysunki są **pływakami**: LaTeX umieszcza je tam, gdzie wychodzi najlepiej,
niekoniecznie w miejscu wpisania. To nie jest usterka. Nie walcz z tym w trakcie pisania —
zajmij się tym przy redakcji, a w tekście zawsze odsyłaj przez `\ref`, nigdy przez
„poniższa tabela".

### Wzory

Wzór w linii otacza się znakami dolara: `wartość $CC_i$ przyjmuje`.

Wzór wyróżniony i numerowany:

```latex
\begin{equation}\label{eq:cc}
  CC_i = \frac{d_i^{-}}{d_i^{+} + d_i^{-}}.
\end{equation}

We wzorze \eqref{eq:cc} symbol $d_i^{+}$ oznacza...
```

Wzór bez numeru: `\[ ... \]`. Kilka wzorów wyrównanych do znaku równości:

```latex
\begin{align}
  S_i &= \sum_{j=1}^{n} w_j \, r_{ij}, \\
  R_i &= \max_j \left( w_j \, r_{ij} \right).
\end{align}
```

Zapis podstawowy:

| Chcesz | Piszesz |
|---|---|
| ułamek | `\frac{a}{b}` |
| indeks dolny, górny | `x_i`, `x^2`, `x_{ij}^{+}` |
| suma, iloczyn | `\sum_{i=1}^{n}`, `\prod_{j=1}^{m}` |
| pierwiastek | `\sqrt{x}`, `\sqrt[3]{x}` |
| nawiasy skalujące się | `\left( ... \right)`, `\left[ ... \right]` |
| litery greckie | `\alpha`, `\beta`, `\lambda`, `\Phi` |
| wartość bezwzględna | `\lvert x \rvert` |
| należy do, dla każdego | `\in`, `\forall` |
| tekst wewnątrz wzoru | `\text{dla } x > 0` |
| macierz | `\begin{pmatrix} a & b \\ c & d \end{pmatrix}` |

Symbole zostawiaj takie jak w artykule źródłowym — czytelnik ma móc porównać. I pamiętaj
o zasadzie z [przewodnika o pisaniu](04-jak-pisac-prace.md#rozdział-1-podstawy-metodyczne):
**po każdym wzorze akapit objaśniający, co ten wzór robi**.

### Listingi kodu

```latex
\begin{lstlisting}[caption={Wyznaczanie wag metoda entropii},label={lst:wagi}]
oblicz_wagi_entropia <- function(macierz) {
  stopifnot(is.matrix(macierz), all(macierz >= 0))
  p <- sweep(macierz, 2, colSums(macierz), "/")
  d / sum(d)
}
\end{lstlisting}
```

Kolorowanie składni, numerację wierszy i ramkę ustawia klasa.

**Wnętrze listingu musi być zapisane wyłącznie znakami ASCII.** Komentarze w kodzie
pisz bez polskich znaków diakrytycznych. Powód jest podwójny: tablica znaków pakietu
składającego listingi obejmuje tylko ASCII, więc polskie litery wychodzą przestawione,
a sprawdzanie pakietu R zgłasza znaki spoza ASCII w kodzie źródłowym jako problem
przenośności. Podpis listingu jest zwykłym tekstem pracy i polskich znaków używać może.

Kontrola:

```
Rscript tools/sprawdz-listingi.R
```

Kod z pliku wstawisz przez `\listingR{Podpis}{lst:etykieta}{sciezka/plik.R}` — wtedy
listing zawsze odpowiada aktualnej wersji kodu.

---

## Poziom trzeci: przy redakcji

### Praca w wielu plikach

Rozdziały są osobnymi plikami włączanymi przez `\input{rozdzialy/01-podstawy}`
(bez rozszerzenia `.tex`). Dzięki temu nie przewijasz tysiąca wierszy i łatwiej
znaleźć miejsce błędu.

Żeby przy pisaniu jednego rozdziału kompilować tylko jego, zakomentuj pozostałe
polecenia `\input` w `main.tex`. Przed oddaniem odkomentuj wszystkie — inaczej
numeracja, spis treści i bibliografia będą niepełne.

### Komentarze robocze

Znak `%` wyłącza resztę wiersza. Komentarze służą do notatek dla siebie i **znikają
z gotowego PDF-u**:

```latex
% Sprawdzić, czy Nowak podaje ten wzór w tej samej postaci.
```

Przed oddaniem przejrzyj komentarze i usuń te, które są notatkami roboczymi.

### Kontrola typografii

Klasa blokuje wdowy i sieroty, ale zdarza się, że LaTeX nie umie złamać zbyt długiego
słowa i wypuszcza je poza margines. W logu zobaczysz wtedy `Overfull \hbox`.

Naprawa, w tej kolejności:

1. przeformułuj zdanie — najczęściej najlepsze rozwiązanie;
2. podpowiedz miejsce podziału: `wielo\-kryterialny`;
3. przy długim adresie WWW użyj `\url{}` — pozwala łamać w sensownych miejscach.

Liczba nadmiarowych pudełek w gotowej pracy powinna być zerowa albo bliska zeru.

### Sekwencja kompilacji

Pełne złożenie pracy wymaga kilku przebiegów, bo spis treści, odsyłacze, bibliografia
i indeks wymagają danych z poprzedniego przebiegu:

```
LuaLaTeX → biber → makeindex → LuaLaTeX → LuaLaTeX
```

Robi to za Ciebie `latexmk`, sterowany plikiem `latexmkrc`:

```
latexmk -lualatex main.tex
```

Na Overleaf ta sekwencja uruchamia się automatycznie. Skutek praktyczny: **po dodaniu
nowego powołania albo etykiety pierwsza kompilacja może pokazać znaki zapytania** —
to normalne, po drugiej znikną.

### Sprzątanie

```
latexmk -c
```

Usuwa pliki pomocnicze, zostawia PDF. Przydaje się, gdy kompilacja zaczyna zachowywać
się dziwnie — uszkodzony plik pomocniczy potrafi utrzymywać błąd, którego w źródle
już nie ma. Na Overleaf odpowiednikiem jest *Recompile from scratch* z rozwijanego
menu obok przycisku kompilacji.

---

## Diagnostyka

### Jak czytać błąd

Komunikat zaczyna się od wykrzyknika, a numer wiersza jest w linii zaczynającej się
od `l.`:

```
! Undefined control sequence.
l.133 Argument \arg
                   {skala} określa
```

Trzy rzeczy, które trzeba wiedzieć:

- **wiersz wskazany w błędzie bywa o jeden dalej niż przyczyna** — brakujący nawias
  zamykający zgłasza się dopiero tam, gdzie coś przestało się zgadzać;
- **pierwszy błąd jest ważny, reszta zwykle z niego wynika** — napraw pierwszy i skompiluj
  ponownie, zamiast czytać wszystkie;
- **na Overleaf przełącz widok na pełny log** (*Raw logs*), gdy podsumowanie nie wystarcza.

### Najczęstsze błędy

| Komunikat albo objaw | Przyczyna | Naprawa |
|---|---|---|
| `Undefined control sequence` | literówka w poleceniu | sprawdź pisownię polecenia w tabeli powyżej |
| `Missing $ inserted` | znak matematyczny poza trybem matematycznym, np. `_` albo `^` w tekście | otocz `$...$` albo użyj `\_` |
| `Missing \begin{document}` | tekst wpisany w preambule | przenieś treść za `\begin{document}` |
| `File ... not found` | zła nazwa albo ścieżka pliku graficznego | sprawdź nazwę; grafiki idą do `rysunki/` |
| `Environment ... undefined` | literówka w nazwie środowiska | porównaj `\begin` i `\end` |
| `\begin{...} ended by \end{...}` | niedomknięte albo pomieszane środowiska | sprawdź parowanie |
| `Extra alignment tab` | za dużo `&` w wierszu tabeli | policz kolumny w deklaracji `tabular` |
| `Misplaced alignment tab` | `&` poza tabelą, często w zwykłym tekście | wstaw `\&` |
| `Citation ... undefined` | klucz nieobecny w `.bib` albo literówka | sprawdź klucz; skompiluj dwa razy |
| `Reference ... undefined` | odsyłacz do nieistniejącej etykiety | sprawdź `\label`; skompiluj dwa razy |
| `Empty bibliography` | brak powołań w tekście | dodaj `\parencite{}` |
| `Overfull \hbox` | tekst wychodzi poza margines | przeformułuj zdanie albo `\url{}` |
| `Underfull \hbox` | zbyt rozstrzelony wiersz | zwykle można zignorować |
| `There's no line here to end` | `\\` w miejscu, gdzie nie ma wiersza | usuń `\\`; akapit robi pusta linia |
| `Paragraph ended before ... was complete` | brakujący nawias klamrowy | sprawdź parowanie `{` i `}` |
| `Too deeply nested` | zbyt głęboko zagnieżdżone listy | spłaszcz strukturę |
| `Package inputenc Error` | plik zapisany w innym kodowaniu niż UTF-8 | zapisz ponownie w UTF-8 |
| polskie znaki przestawione w listingu | znaki spoza ASCII w kodzie | usuń diakrytykę; `Rscript tools/sprawdz-listingi.R` |
| kod bez kroju JetBrains Mono | dokument skompilowany pdfLaTeX-em | ustaw kompilator na LuaLaTeX |
| brak indeksu nazwisk | żadnego `\osoba{}{}` w tekście | dodaj polecenia; skompiluj ponownie |
| PDF nie odświeża się mimo zmian | uszkodzone pliki pomocnicze | `latexmk -c` albo *Recompile from scratch* |

### Gdy nic nie pomaga

1. `latexmk -c` i pełna kompilacja od zera.
2. Zakomentuj połowę treści i skompiluj — zawęź, w której połowie jest problem.
   Powtórz kilka razy, aż zostanie kilka wierszy.
3. Sprawdź, czy problem występuje też w dokumencie pokazowym `przyklad.tex`. Jeżeli tak,
   przyczyna jest w środowisku, a nie w Twoim tekście.

---

## Co dalej

- [Bibliografia w `.bib` i Zotero](02-bibliografia-bib-zotero.md) — zapis źródeł
- [Overleaf i współpraca](03-overleaf-i-wspolpraca.md) — środowisko pracy
- [`wzor-pracy/README.md`](../wzor-pracy/README.md) — opis wzoru i opcji klasy
- `wzor-pracy/przyklad.tex` — działający przykład każdego elementu opisanego wyżej

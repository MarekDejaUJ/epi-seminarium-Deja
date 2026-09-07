# Temat 13. Odporny wybór przy ograniczonej uwadze

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Hansen, Lars Peter; Miao, Jianjun; Xing, Hao (2025). *Robust inattentive discrete choice*. Proceedings of the National Academy of Sciences |
| Identyfikator | [10.1073/pnas.2416643122](https://doi.org/10.1073/pnas.2416643122) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | poznanie, wyszukiwanie informacji, podejmowanie decyzji |
| Proponowany tytuł pracy | Pakiet R do modelowania wyboru przy ograniczonej uwadze jako przykład zastosowania miar teorioinformacyjnych w badaniach nad zachowaniami informacyjnymi |
| Proponowana nazwa pakietu | `NieuwagaR` |
| Trudność | ●●●● |

## Po co to badaczowi

Człowiek stojący przed wyborem nie analizuje wszystkich dostępnych informacji.
Nie dlatego, że jest nieracjonalny, tylko dlatego, że **uwaga kosztuje**. Czytelnik
przeglądający wyniki wyszukiwania nie otwiera wszystkich linków. Wyborca nie czyta
programów wszystkich komitetów. Konsument nie porównuje wszystkich ofert. Każdy
przeznacza na to tyle uwagi, ile mu się opłaca – i wybiera na podstawie tego, co
zdążył zauważyć.

Teoria racjonalnej nieuwagi opisuje to formalnie: decydent wybiera, ile informacji
pozyskać, ważąc korzyść z lepszej decyzji przeciw kosztowi uwagi mierzonemu
teorioinformacyjnie. Model ten tłumaczy zachowania, które klasyczna teoria wyboru
uznaje za błędy, i jest dla badacza zachowań informacyjnych narzędziem naturalnym.

Ma jednak założenie, które w zastosowaniach społecznych jest kłopotliwe: decydent
**zna rozkład** tego, o czym nie wie. Zna prawdopodobieństwa stanów świata, o których
dopiero zbiera informacje. W realnych sytuacjach – nowa technologia, nieznana
choroba, nieznany kandydat – ludzie tego rozkładu nie znają i sami o tym wiedzą.

Artykuł to założenie osłabia. Dopuszcza decydenta, który **nie ufa własnym
przekonaniom wstępnym** i zabezpiecza się przed tym, że są błędne. Podaje warunki
konieczne i dostateczne rozwiązania odpornego oraz metody numeryczne jego wyznaczania.

Dla badacza zachowań informacyjnych jest to model bliższy temu, co obserwuje:
ludzie zachowują się ostrożniej niż przewiduje model zakładający pewność co do
rozkładu.

## Algorytm

**Wejście.** Skończony zbiór działań; skończony zbiór stanów świata; macierz
wypłat dla par działanie–stan; rozkład wstępny na stanach; parametr kosztu uwagi;
parametr określający dopuszczalną rozbieżność od rozkładu wstępnego.

**Wyjście.** Rozkład wyborów warunkowy względem stanu; rozkład brzegowy wyborów;
najgorszy rozkład wstępny w dopuszczalnym zbiorze; wartość funkcji celu; miary
pozyskanej informacji.

**Kroki.**

1. Sprawdzenie wejścia: rozkład wstępny sumujący się do jedności, zgodność wymiarów
   macierzy wypłat, dodatnie parametry.
2. Inicjalizacja rozkładu brzegowego wyborów.
3. Naprzemienne uaktualnianie: przy ustalonym rozkładzie brzegowym wyznacz rozkłady
   warunkowe, przy ustalonych warunkowych uaktualnij brzegowy.
4. Uwzględnienie odporności: wyznaczenie najgorszego rozkładu wstępnego w zbiorze
   ograniczonym rozbieżnością od rozkładu wyjściowego.
5. Powtarzanie do zbieżności punktu stałego.
6. Wyznaczenie miar pozyskanej informacji i sprawdzenie warunków optymalności.

**Co wynotować z artykułu.** Z sekcji metodycznej: postać zadania decydenta wraz
z obydwoma składnikami kosztu; **warunki konieczne i dostateczne rozwiązania
odpornego**; postać uaktualnień w metodzie numerycznej; sposób wyznaczania
najgorszego rozkładu wstępnego; warunek zbieżności; zachowanie graniczne przy
parametrze odporności dążącym do zera, czyli powrót do modelu klasycznego.

## Kontrakt

**Warunki wstępne.** Rozkład wstępny nieujemny i sumujący się do jedności; macierz
wypłat o wymiarach działania na stany bez braków; parametr kosztu uwagi dodatni;
parametr odporności nieujemny; co najmniej dwa działania i dwa stany.

**Niezmienniki.** Rozkłady warunkowe sumują się do jedności dla każdego stanu.
Rozkład brzegowy sumuje się do jedności. Funkcja celu nie maleje między iteracjami.
Przy parametrze odporności równym zeru wynik pokrywa się z modelem klasycznym.
Przy koszcie uwagi dążącym do zera wybór staje się deterministyczny.

**Wyjście.** Klasa `nieuwaga_odporna` ze składnikami: rozkłady warunkowe i brzegowy,
najgorszy rozkład wstępny, wartość celu, miary informacji, liczba iteracji.

**Błędy zatrzymujące wykonanie.** Rozkład niesumujący się do jedności; niezgodność
wymiarów; niedodatni koszt uwagi; ujemny parametr odporności; brak zbieżności
w zadanej liczbie iteracji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rozkładu i macierzy wypłat |
| `R/punkt_staly.R` | naprzemienne uaktualnienia, warunek zbieżności |
| `R/odpornosc.R` | najgorszy rozkład wstępny w zbiorze dopuszczalnym |
| `R/miary.R` | miary pozyskanej informacji, sprawdzenie optymalności |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | rozkłady wyborów, wrażliwość na parametry |

Zależności: `stats` i `ggplot2`. Metoda punktu stałego nie wymaga solvera; jeżeli
sięgasz po optymalizator do kroku odpornościowego, uzasadnij to.

## Dane

**Procedura generowania.** Ustalasz zadanie decyzyjne o **znanym rozwiązaniu
analitycznym** – dwa działania, dwa stany, symetryczne wypłaty – i sprawdzasz, czy
metoda je odtwarza dla siatki parametrów. Następnie generujesz obserwowane wybory
z rozwiązania modelu i sprawdzasz, czy z tych wyborów da się odzyskać parametr
kosztu uwagi. To drugie jest odpowiedzią na pytanie, czy model jest identyfikowalny
z danych, i wprost zasila rozdział trzeci.

Parametry: liczba działań, stanów, rozpiętość wypłat, koszt uwagi, parametr
odporności, liczba symulowanych decydentów, ziarno.

**Przypadki o znanym wyniku.** Wypłaty niezależne od stanu: decydent nie pozyskuje
informacji, rozkłady warunkowe równe brzegowemu. Koszt uwagi bliski zeru: wybór
deterministyczny, zgodny z maksymalizacją wypłaty. Parametr odporności zero:
zgodność z modelem klasycznym.

**Przypadki patologiczne.** Rozkład wstępny skupiony w jednym stanie; wypłaty
identyczne dla wszystkich działań; jedno działanie.

**Zbiór empiryczny.** Otwarte dane z eksperymentów wyboru albo z badań zachowań
wyszukiwawczych, w których zarejestrowano zarówno wybory, jak i przybliżoną miarę
wysiłku informacyjnego. Sprawdź licencję i warunki wtórnego wykorzystania.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, problem nieznanego rozkładu | Wprowadzenie: tło i luka |
| Algorytm, warunki optymalności | Rozdział 1: aparat formalny |
| Kontrakt, zachowanie graniczne | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, identyfikowalność | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Czy z obserwowanych wyborów da się rozróżnić decydenta
o wysokim koszcie uwagi od decydenta nieufnego wobec własnych przekonań wstępnych,
i przy jakiej liczbie obserwacji staje się to możliwe?

## Polecenia startowe

1. Naprzemienne uaktualnienia rozkładów, zgodnie z Twoimi notatkami, na macierzach.
2. Warunek zbieżności i pętla główna z jawnym zatrzymaniem.
3. Krok odpornościowy: najgorszy rozkład wstępny w zbiorze dopuszczalnym.
4. Zadanie o znanym rozwiązaniu analitycznym jako test poprawności.
5. Procedura generowania obserwowanych wyborów z rozwiązania modelu.
6. Badanie identyfikowalności: odzyskiwanie parametrów z symulowanych wyborów.

## Pułapki

**Model klasyczny zamiast odpornego.** Metoda naprzemienna dla wariantu klasycznego
jest znana i narzędzie ją poda. Krok odpornościowy jest tym, co odróżnia ten artykuł,
i najłatwiej go pominąć bez zauważenia – bo bez niego wszystko się liczy i zbiega.
Test przy parametrze odporności równym zeru musi dawać wynik klasyczny, a przy
dodatnim wynik **inny**.

**Zbieżność do minimum lokalnego.** Metody punktu stałego bywają wrażliwe na
inicjalizację. Sprawdź stabilność przy różnych punktach startowych i opisz to.

**Logarytm zera.** Rozkład skupiony w jednym punkcie psuje obliczenia
teorioinformacyjne. Obsłuż to jawnie, a nie przez dodanie małej stałej bez opisu.

**Interpretacja parametrów.** Koszt uwagi i odporność wyjaśniają podobne wzorce
zachowań. Twierdzenie, że obserwowana ostrożność wynika z jednego z nich, wymaga
pokazania, że drugiego dałoby się to samo wyjaśnienie. Właśnie temu służy badanie
identyfikowalności.

**Na obronie** musisz umieć wyjaśnić, dlaczego uwaga jest tu mierzona miarą
teorioinformacyjną, i co konkretnie oznacza, że decydent nie ufa własnym przekonaniom.

## Literatura

Artykuł źródłowy: `hansen2025robust`.

Wprowadzenie: klasyczne opracowanie o racjonalnej nieuwadze; podręcznikowe omówienie
miar teorioinformacyjnych. Dwie do czterech pozycji dobierasz sam. Temat pokrewny
z tematem 10 w części dotyczącej modelowania decyzji.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.

# Jak dobrano tematy

Nota opisuje, przez co przeszedł każdy temat, zanim trafił na listę. Warto ją
przeczytać nie dlatego, że to formalność, tylko dlatego, że **ta sama procedura
obowiązuje Ciebie** przy każdej pozycji, którą wprowadzisz do swojej bibliografii.

## Kryteria

Temat trafiał na listę, jeżeli spełniał cztery warunki naraz.

**Artykuł opisuje algorytm, nie tylko wynik.** Praca ma polegać na implementacji,
więc metoda musi być podana na tyle dokładnie, żeby dało się ją zapisać w kodzie.
Artykuł, który stosuje cudzą metodę do nowych danych, na temat się nie nadaje.

**Metoda przydaje się w naukach społecznych.** Nie chodzi o to, żeby algorytm
pochodził z nauk społecznych, tylko żeby badacz z tego obszaru miał po co po niego
sięgnąć. Ten warunek decyduje o tym, czy da się napisać sensowny wstęp pracy.

**Algorytm jest wykonalny w skali pracy licencjackiej.** Rdzeń obliczeniowy musi dać
się zaimplementować i sprawdzić w jednym semestrze, przy zachowaniu wymogów jakości.

**Da się skonstruować przypadki o znanym wyniku.** Bez tego nie ma jak sprawdzić
poprawności implementacji, a praca sprowadza się do stwierdzenia, że kod się
uruchamia.

## Weryfikacja

Każda pozycja przeszła trzy sprawdzenia.

**Istnienie i metadane.** Dane bibliograficzne pochodzą z rejestru wydawcy, z bazy
Crossref albo z repozytorium preprintów, a nie z zestawień wtórnych. Sprawdzano
nazwiska wszystkich autorów, rok, czasopismo, identyfikator cyfrowy i status
dostępu. Kilka pozycji trafiło na listę z metadanymi poprawionymi względem wersji
roboczej: różnice dotyczyły inicjałów, roku wydania i brzmienia tytułu.

To sprawdzenie nie jest nadmiarowe. Opis bibliograficzny przepisany z drugiej ręki
potrafi zawierać nazwiska istniejących badaczy przy tytule, którego nikt nie napisał.
Powołanie na taką pozycję w pracy dyplomowej jest błędem, którego nie da się obronić.

**Erraty i wersje.** Sprawdzano, czy do artykułu nie ukazało się sprostowanie. Jedna
pozycja na liście ma opublikowaną erratę i brief odsyła do obu tekstów. Pracujesz
zawsze na wersji poprawionej.

**Istniejące implementacje.** Sprawdzano, czy metoda nie ma już gotowego pakietu,
w szczególności wydanego przez autorów artykułu. Jest to dziś częste: zespoły
publikują artykuł i pakiet równolegle. Temat, którego metoda miała gotową, dojrzałą
implementację, został z listy zdjęty.

Ten warunek nie znika po wyborze tematu. **Sprawdź go ponownie na początku pracy**,
bo między ułożeniem listy a Twoim wstępem mija kilka miesięcy. Wykaz przejrzanych
rozwiązań jest wymaganą częścią wstępu, a zdanie o nieistnieniu implementacji podane
bez takiego wykazu jest zarzutem pod Twoim adresem, a nie argumentem.

## Wzory

Briefy podają wejście, wyjście i kolejne kroki algorytmu, ale **wzory przepisujesz
z artykułu źródłowego**. Nie z briefu, nie z opracowania przeglądowego, nie z hasła
encyklopedycznego.

Powód jest ten sam co wyżej: zapis skrócony gubi warunki, przy których wzór
obowiązuje, a czasem gubi też człon. Brief mówi, której sekcji artykułu szukać i co
z niej wynotować. Resztę robisz sam, bo to jest ta część pracy, w której uczysz się
metody.

## Co robisz na starcie

1. Pobierz artykuł. Jeżeli nie jest w dostępie otwartym, skorzystaj z dostępu przez
   bibliotekę Uniwersytetu.
2. Sprawdź, czy ukazała się errata albo nowsza wersja.
3. Przeszukaj repozytoria pakietów pod kątem istniejących implementacji i zapisz,
   co znalazłeś. To pierwszy wpis do wstępu pracy.
4. Przeczytaj sekcję definicyjną i algorytmiczną, wynotowując to, co wymienia brief.
5. Napisz `SPEC.md`.

Dopiero potem piszesz pierwszą linię kodu.

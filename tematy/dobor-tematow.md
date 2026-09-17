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
Cytowanie takiej pozycji w pracy dyplomowej jest błędem, którego nie da się obronić.

**Erraty i wersje.** Na początku pracy należy sprawdzić stronę wydawcy i historię
wersji preprintu. W specyfikacji zapisz używaną wersję oraz wskazane twierdzenia
lub równania. W temacie 06 podstawą jest wersja v2. Opublikowane sprostowanie
ma pierwszeństwo przed pierwotnym zapisem; dostępność nowszej wersji trzeba
sprawdzić ponownie, ponieważ może się zmienić po wyborze tematu.

**Istniejące implementacje.** Dostępny kod i pakiety służą do ustalenia zakresu
wkładu oraz niezależnego porównania wyników. W temacie 08 istnieją pełne funkcje
autorów w R i Pythonie, a w temacie 14 kod autorów obejmuje składowe i trzy bazy.
W tych projektach wkład obejmuje własny pakiet R, walidację wejścia, strukturę
wyniku, dokumentację i ocenę wrażliwości. Samo przepisanie lub opakowanie
istniejącej funkcji bez tych elementów nie realizuje zakresu briefu.

Stan dostępnych rozwiązań może się zmienić. **Sprawdź go ponownie na początku pracy**,
bo między ułożeniem listy a Twoim wstępem mija kilka miesięcy. Wykaz przejrzanych
rozwiązań jest wymaganą częścią wstępu, a zdanie o nieistnieniu implementacji podane
bez takiego wykazu jest zarzutem pod Twoim adresem, a nie argumentem.

## Wzory

W briefach są definicje, wzory, zakres obowiązkowy i liczbowe przykłady kontrolne.
**Przed implementacją porównaj wzory z artykułem źródłowym**, wraz z oznaczeniami,
warunkami i wskazaną wersją. W pracy cytuj artykuł, a własne decyzje dotyczące
interfejsu, danych i przypadków brzegowych opisz osobno.

Zapis skrócony może gubić warunki lub składnik wzoru. Weryfikacja obejmuje również
znaczenie wyniku: granice możliwych wartości, przedział ufności, przedział
wiarygodności i punkt ekstrapolowany mają różne interpretacje. W przykładach
liczbowych odtwórz rachunek niezależnie od implementowanej funkcji. Zakresu
obowiązkowego nie rozszerzaj przez samo przyjęcie wszystkich obietnic z artykułu.

## Co robisz na starcie

1. Pobierz artykuł. Jeżeli nie jest w dostępie otwartym, skorzystaj z dostępu przez
   bibliotekę Uniwersytetu.
2. Sprawdź, czy ukazała się errata albo nowsza wersja.
3. Przeszukaj repozytoria pakietów pod kątem istniejących implementacji i zapisz,
   co znalazłeś. To pierwszy wpis do wstępu pracy.
4. Przeczytaj sekcję definicyjną i algorytmiczną, wynotowując to, co wymienia brief.
5. Napisz `SPEC.md`.

Dopiero potem piszesz pierwszą linię kodu.

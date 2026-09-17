# Pytania na obronę

Dziesięć zagadnień do przygotowania wypowiedzi o własnej pracy i projekcie.
Każde pytanie obejmuje temat, który można rozwinąć przez około 10 minut,
odwołując się do własnych decyzji, danych, obliczeń i wyników. To materiał
do ćwiczenia odpowiedzi, a nie zapowiedź pytań komisji ani zakresu egzaminu.

Przygotowując odpowiedź, warto połączyć wyjaśnienie problemu, omówienie
rozwiązania, konkretny przykład i ocenę ograniczeń. Zakres pod każdym pytaniem
wskazuje możliwe kierunki wypowiedzi; nie trzeba omawiać wszystkich punktów
z równym naciskiem. Szczegóły metody należy dobrać do własnego briefu.

1. **Jaką rolę pełni opracowane narzędzie w rozwiązywaniu problemu badawczego,
   któremu poświęcona jest praca?**

   Omów problem w jego dziedzinie, potrzebę użytkownika i pytanie analityczne
   własnej pracy. Wyjaśnij przejście od ogólnego zagadnienia do wielkości,
   którą oblicza pakiet. Na przykładzie pokaż, jak wynik może wesprzeć analizę
   lub decyzję i jakie części problemu pozostają poza zakresem projektu.

2. **Jak działa zaimplementowana metoda i od jakich założeń zależy sens jej
   wyniku?**

   Przedstaw wejście, najważniejsze kroki i wyjście algorytmu. Objaśnij główny
   wzór na małym przykładzie, łącząc symbole z danymi i interpretacją.
   Rozróżnij warunki sprawdzalne przez program od założeń dotyczących zjawiska
   lub procesu zbierania danych. Omów skutek naruszenia wybranego założenia.

3. **Jak przygotowanie i jakość danych wpływają na to, co można ustalić
   za pomocą opracowanego pakietu?**

   Omów jednostkę analizy, reprezentację danych i ich przekształcenia
   w projekcie. Wyjaśnij zasady dopasowania identyfikatorów, traktowania braków,
   remisów, niekompletnych relacji lub różnych skal, stosownie do metody.
   Pokaż przykład decyzji o danych, która zmienia wynik, oraz sposób
   sprawdzenia, czy przekształcenie zachowuje znaczenie informacji.

4. **Jak decyzje dotyczące architektury i interfejsu pakietu ułatwiają jego
   poprawne używanie oraz rozwijanie?**

   Przejdź przez typowy przebieg analizy: przygotowanie wejścia, walidację,
   obliczenie i odczyt wyniku. Powiąż podział modułów, argumenty funkcji
   i strukturę obiektu wyniku z potrzebą badacza. Omów wybrany kompromis
   projektowy, obsługę błędów i zmianę, którą można wprowadzić bez naruszania
   dotychczasowego sposobu korzystania z pakietu.

5. **Na jakiej podstawie można uznać, że implementacja oblicza właściwy wynik?**

   Przedstaw dowody z własnego projektu: rachunek ręczny, testy własności,
   przypadki brzegowe i porównanie z niezależnym obliczeniem. Rozwiń jeden
   przykład od danych do oczekiwanej wartości. Wyjaśnij, jakie błędy wykrywają
   poszczególne sprawdzenia, jak dobierano tolerancję numeryczną i czego nawet
   komplet przechodzących testów nie potwierdza.

6. **Jak zaprojektowano eksperymenty sprawdzające zachowanie metody w różnych
   warunkach?**

   Omów cel eksperymentu, generator lub sposób modyfikowania danych,
   znaną wartość odniesienia oraz parametry zmieniane w doświadczeniu.
   Wyjaśnij dobór miar oceny, powtórzeń i ziaren losowości. Pokaż, jak
   oddzielono wpływ badanego czynnika od pozostałych różnic i jak oceniono
   zmienność wyniku między powtórzeniami. Odnieś projekt doświadczenia
   do pytania analitycznego pracy.

7. **Jak należy oceniać niepewność i ograniczenia wyników otrzymanych
   w projekcie?**

   Omów źródła niewiedzy właściwe dla własnej metody, np. losową próbę,
   niepełne oceny, nieznany koniec rankingu, nieobserwowane zmienne,
   przybliżenie obliczeniowe lub założenia modelu. Wyjaśnij znaczenie
   zwracanych granic, przedziałów albo diagnostyki i warunki ich interpretacji.
   Na przykładzie analizy wrażliwości pokaż, które wnioski są stabilne,
   a które zależą od konkretnego wyboru parametru lub scenariusza.

8. **Co wynika ze studium przypadku i w jakim zakresie jego wnioski można
   przenieść na inne dane lub zastosowania?**

   Przedstaw cel analizy empirycznej, dobór zbioru i najważniejszy wynik.
   Powiąż go z odpowiedzią na pytanie pracy oraz porównaniem z przyjętym
   punktem odniesienia. Omów możliwe wyjaśnienia różnic, wpływ selekcji danych
   i ograniczenia uogólniania. Wskaż przykład wniosku uzasadnionego wynikiem
   oraz interpretacji, do której przedstawione dowody nie wystarczają.

9. **Od czego zależy wydajność rozwiązania i jak można dostosować je do
   większej skali danych?**

   Omów koszt czasowy i pamięciowy najważniejszych kroków algorytmu,
   odnosząc je do rozmiaru danych. Przedstaw własny pomiar wydajności
   i uzasadnij wybraną reprezentację lub optymalizację. Wyjaśnij, co ograniczy
   działanie przy większej skali, jak sprawdzono zgodność szybszej wersji
   z wynikiem odniesienia i jaki kompromis wiąże się z dalszym przyspieszaniem.

10. **Jak przygotowano projekt do samodzielnego użycia przez badacza
    i odtworzenia przedstawionej analizy?**

    Omów instalację, przykład użycia, dokumentację, stronę i aplikację
    w odniesieniu do potrzeb odbiorcy. Przedstaw drogę od zapisanych danych
    i konfiguracji do tabeli lub wykresu w pracy, wraz z wymaganiami środowiska
    i wersjami zależności. Wyjaśnij sposób sprawdzenia odtwarzalności oraz
    uzasadnij kierunek dalszego rozwoju wynikający z ograniczeń własnego projektu.

Odpowiedź warto przećwiczyć na głos z zegarkiem. Do każdego zagadnienia
należy przygotować jeden konkretny przykład z projektu i umieć objaśnić
go bez czytania tekstu pracy. Gdy część zagadnienia nie była badana,
należy wskazać granicę własnych ustaleń i sposób jej sprawdzenia.

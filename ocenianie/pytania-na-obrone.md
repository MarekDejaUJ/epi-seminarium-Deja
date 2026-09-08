# Pytania na obronę

Zestaw pytań weryfikujących zrozumienie własnej pracy. Nie jest to lista pytań, które
padną – komisja zadaje własne, a część dotyczy programu studiów, nie pracy. Jest to
lista, na której sprawdzisz, czy rozumiesz to, co oddajesz.

Sposób użycia: odpowiadaj na głos, bez zaglądania do pracy, w trzy do czterech zdań.
Pytanie, na które odpowiadasz dłużej niż minutę, jest pytaniem, na które nie umiesz
odpowiedzieć.

Twój brief tematyczny kończy się akapitem zaczynającym się od słów „na obronie".
Wskazuje on jedno lub dwa pytania właściwe dla Twojej metody. Zacznij od nich.

## O metodzie

1. Jaki problem badawczy rozwiązuje metoda, którą zaimplementowałeś?
2. Co badacz potrafił zrobić przed jej powstaniem, a czego nie potrafił?
3. Jakie są założenia metody? Które z nich są sprawdzalne na danych, a które nie?
4. Co się dzieje z wynikiem, kiedy założenie jest naruszone? Zauważysz to?
5. Wyjaśnij główny wzór metody komuś, kto zna statystykę na poziomie podstawowym.
6. Dlaczego autorzy wybrali właśnie takie podejście? Jaka była alternatywa?
7. Gdzie leżą granice stosowalności metody?
8. Co metoda mierzy, a co ludzie zwykle myślą, że mierzy?
9. Czy istnieją metody konkurencyjne? Czym się różnią?
10. Który krok algorytmu jest najkosztowniejszy obliczeniowo i dlaczego?

## O implementacji

11. Pokaż strukturę pakietu i powiedz, za co odpowiada każdy plik.
12. Wskaż funkcję, w której zrobiłeś najwięcej decyzji projektowych. Wymień je.
13. Ta funkcja ma tu warunek. Co się stanie, jeżeli go usuniesz?
14. Dlaczego wynik jest obiektem klasy S3, a nie zwykłą listą?
15. Jak zaimplementowałeś krok, którego artykuł nie opisuje w szczegółach?
16. Który fragment przepisałeś z postaci z pętlami na postać wektorową? O ile przyspieszył?
17. Co zrobisz, kiedy użytkownik poda dane z brakami?
18. Które zależności zewnętrzne dołączyłeś i dlaczego akurat te?
19. Gdyby trzeba było przenieść pakiet na dziesięciokrotnie większe dane, co pęknie pierwsze?
20. Który fragment kodu napisałbyś dziś inaczej?

Pytanie 13 jest tym, którego nie da się przygotować z pamięci. Komisja wskazuje
dowolne miejsce w kodzie i pyta, po co ono tam jest. Przygotowanie polega na tym, żeby
przed obroną przeczytać własny kod w całości, linia po linii, i przy każdym warunku
umieć powiedzieć, jaki przypadek on obsługuje.

## O testach i danych

21. Skąd wiadomo, że Twój program liczy poprawnie?
22. Podaj przypadek, którego wynik policzyłeś ręcznie. Pokaż rachunek.
23. Jak generujesz dane, na których sprawdzasz metodę? Co w nich znasz?
24. Czym różni się test własności od testu przypadku analitycznego?
25. Które testy napisałeś przed kodem, a które po? Dlaczego akurat w tej kolejności?
26. Podaj dane, na których Twój pakiet celowo odmawia działania. Dlaczego odmawia?
27. Czy testy wykryły kiedyś błąd, którego nie spodziewałeś się w tym miejscu?
28. Jak sprawdziłeś, że wynik nie zależy od kolejności danych wejściowych?
29. Dlaczego ziarno losowości jest ustalone? Co by było bez tego?
30. Czy pokrycie testami mówi coś o poprawności? Co konkretnie mówi, a czego nie?

## O studium przypadku

31. Dlaczego wybrałeś ten zbiór danych?
32. Czy dane spełniają założenia metody? Sprawdziłeś to czy założyłeś?
33. Co pokazuje wynik Twojej analizy? Powiedz to jednym zdaniem.
34. Czego ten wynik nie pokazuje, choć ktoś mógłby tak przeczytać?
35. Porównałeś wynik z metodą odniesienia. Skąd różnica?
36. Gdybyś dostał inny zbiór z tej samej dziedziny, spodziewasz się podobnego wyniku?
37. Który element wyniku jest artefaktem doboru danych, a nie własnością zjawiska?
38. Jakie decyzje przy przygotowaniu danych mogły wpłynąć na wynik?
39. Co trzeba by zrobić, żeby wynik uznać za rozstrzygający?
40. Czy ktoś mógłby użyć Twojego narzędzia do wyciągnięcia wniosku, który jest fałszywy?

## O pracy i literaturze

41. Jaka jest teza Twojej pracy?
42. Na jakie pytanie odpowiada praca i gdzie znajduje się odpowiedź?
43. Która pozycja z bibliografii była dla Ciebie najważniejsza i dlaczego?
44. Które ustalenia w rozdziale pierwszym są cudze, a które Twoje?
45. Co w Twojej pracy jest elementem własnym, a nie wykonaniem cudzego pomysłu?
46. Czy ktoś już zaimplementował tę metodę? Czym różni się Twoja implementacja?
47. Jak Twoja praca ma się do zagadnienia ogólniejszego z tytułu?
48. Co byś zbadał, gdybyś miał jeszcze rok?

## O pracy z agentem

49. W czym agent programistyczny Ci pomógł, a w czym przeszkodził?
50. Podaj przypadek, w którym agent zaproponował rozwiązanie błędne. Jak to wykryłeś?
51. Skąd wiesz, że kod, który oddajesz, robi to, co opisujesz w pracy?
52. Które decyzje w projekcie podjąłeś sam, a nie mogłeś ich delegować?
53. Co byś zrobił, gdyby agent był niedostępny przez cały semestr?

Pytanie 50 jest łatwe, jeżeli prowadziłeś rejestr poleceń, i niemożliwe, jeżeli nie
prowadziłeś. Wpis opisujący pomyłkę agenta i sposób jej wykrycia jest najlepszym
dowodem, że rozumiesz własny projekt.

## Kiedy nie znasz odpowiedzi

Powiedz, że nie wiesz, i powiedz, jak byś się dowiedział. Jest to odpowiedź lepsza od
każdej próby ominięcia pytania i komisja odróżnia jedno od drugiego bez trudu.

Czego nie robić: nie zgaduj wzoru, nie przypisuj sobie własności metody, których nie
sprawdziłeś, i nie mów „tak działa ta metoda", jeżeli nie umiesz powiedzieć dlaczego.

## Przygotowanie

Na tydzień przed obroną:

- [ ] Przeczytaj własny kod w całości, linia po linii
- [ ] Przejdź pytania z tej listy na głos, z zegarkiem
- [ ] Uruchom aplikację i przejdź przez nią jak ktoś, kto widzi ją pierwszy raz
- [ ] Przygotuj pokaz na żywo: pięć minut od wczytania danych do wyniku
- [ ] Sprawdź, że pokaz działa bez internetu, na wypadek gdyby go zabrakło
- [ ] Przypomnij sobie trzy pozycje z bibliografii na tyle, żeby o nich rozmawiać

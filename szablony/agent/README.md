# Praca z agentem programistycznym

Pliki do skopiowania do repozytorium własnego pakietu. Metoda, w której mają
sens, jest opisana w rozdziałach siódmym i ósmym
[przewodnika](../../przewodniki/07-agent-cli.md).

| Plik | Gdzie trafia | Do czego |
|---|---|---|
| [`instrukcje-repozytorium.md`](instrukcje-repozytorium.md) | miejsce, w którym Twój agent szuka instrukcji projektowych | konwencje, zakazy i wymagania czytane przy każdym uruchomieniu |
| [`polecenia.md`](polecenia.md) | katalog roboczy, do kopiowania | cztery schematy poleceń pokrywające większość pracy |
| [`rejestr-polecen.md`](rejestr-polecen.md) | katalog główny pakietu | rejestr prowadzony od pierwszego dnia, źródło aneksu pracy |

## Kolejność

1. Skopiuj instrukcje repozytorium i uzupełnij dane swojego artykułu.
2. Załóż rejestr poleceń, zanim wydasz pierwsze polecenie.
3. Napisz `SPEC.md`, potem testy, dopiero potem uruchamiaj agenta.

## Rozgraniczenie, o którym warto pamiętać

W **repozytorium Twojego pakietu** jawność użycia agenta jest wymagana:
instrukcje, rejestr poleceń i wykaz w aneksie pracy są częścią oceny. Nie
ukrywasz niczego, bo nie ma czego ukrywać – praca z agentem jest elementem
metodyki, którą praca opisuje.

Zakres dozwolonego użycia i konsekwencje jego przekroczenia są w
[rozdziale ósmym przewodnika](../../przewodniki/08-etyka-si.md). Zasada, którą
warto zapamiętać w jednym zdaniu: agent może napisać kod przechodzący Twoje
testy, ale nie przeczyta za Ciebie artykułu ani nie wyciągnie wniosku z wyników.

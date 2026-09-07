# Praca z narzędziem programistycznym

Pliki do skopiowania do repozytorium własnego pakietu. Metodę, w której mają
sens, opisują rozdziały siódmy i ósmy
[przewodnika](../../przewodniki/07-agent-cli.md).

| Plik | Gdzie trafia | Do czego |
|---|---|---|
| [`instrukcje-repozytorium.md`](instrukcje-repozytorium.md) | miejsce, w którym Twoje narzędzie szuka instrukcji projektowych | konwencje, zakazy i wymagania czytane przy każdym uruchomieniu |
| [`polecenia.md`](polecenia.md) | katalog roboczy, do kopiowania | cztery schematy poleceń pokrywające większość pracy |
| [`rejestr-polecen.md`](rejestr-polecen.md) | katalog główny pakietu | rejestr prowadzony od pierwszego dnia, źródło aneksu pracy |

## Kolejność

1. Skopiuj instrukcje repozytorium i uzupełnij dane swojego artykułu.
2. Załóż rejestr poleceń, zanim wydasz pierwsze polecenie.
3. Napisz `SPEC.md`, potem testy, dopiero potem uruchamiaj narzędzie.

## Rozgraniczenie, o którym warto pamiętać

W **repozytorium Twojego pakietu** jawność użycia narzędzia jest wymagana:
instrukcje, rejestr poleceń i wykaz w aneksie pracy są częścią oceny. Nie
ukrywasz niczego, bo nie ma czego ukrywać – praca z narzędziem jest elementem
metodyki, którą praca opisuje.

Zakres dozwolonego użycia i konsekwencje jego przekroczenia opisuje
[rozdział ósmy przewodnika](../../przewodniki/08-etyka-si.md). Zasada, którą
warto zapamiętać w jednym zdaniu: narzędzie może napisać kod przechodzący Twoje
testy, ale nie może przeczytać za Ciebie artykułu ani wyciągnąć wniosku z wyników.

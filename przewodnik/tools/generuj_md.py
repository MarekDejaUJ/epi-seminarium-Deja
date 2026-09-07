"""Generowanie wersji przewodnika w Markdown na podstawie plikow zrodlowych LaTeX.

Zrodlem tresci sa pliki w przewodnik/rozdzialy/. Wersja w Markdown powstaje z nich
automatycznie i sluzy wylacznie do czytania na stronie repozytorium; nie edytuje sie
jej recznie, bo kolejne uruchomienie skryptu nadpisze zmiany.

Uruchomienie z katalogu glownego repozytorium:
    python przewodnik/tools/generuj_md.py
"""

import io
import os
import re
import sys
import unicodedata

KATALOG = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KORZEN = os.path.dirname(KATALOG)
ZRODLA = os.path.join(KATALOG, 'rozdzialy')
BIB = os.path.join(KATALOG, 'bibliografia', 'zrodla.bib')
CEL = os.path.join(KORZEN, 'przewodniki')

ROZDZIALY = [
    ('00-wprowadzenie.tex', '00-wprowadzenie.md'),
    ('01-latex.tex', '01-latex.md'),
    ('02-bibliografia.tex', '02-bibliografia.md'),
    ('03-overleaf.tex', '03-overleaf.md'),
    ('04-jak-pisac.tex', '04-jak-pisac.md'),
    ('05-warsztat.tex', '05-warsztat.md'),
    ('06-wymogi.tex', '06-wymogi.md'),
]

# ---------------------------------------------------------------------------
# Pomocnicze
# ---------------------------------------------------------------------------


def slug(tekst):
    """Odpowiednik kotwicy naglowka nadawanej przez serwis repozytorium."""
    t = tekst.lower()
    t = re.sub(r'`', '', t)
    t = re.sub(r'\*', '', t)
    t = re.sub(r'[^\w\s-]', '', t, flags=re.UNICODE)
    t = re.sub(r'\s+', '-', t.strip())
    return t


def argument(tekst, i):
    """Zwraca zawartosc nawiasu klamrowego zaczynajacego sie na pozycji i."""
    assert tekst[i] == '{'
    glebokosc, j = 0, i
    while j < len(tekst):
        if tekst[j] == '\\':
            j += 2
            continue
        if tekst[j] == '{':
            glebokosc += 1
        elif tekst[j] == '}':
            glebokosc -= 1
            if glebokosc == 0:
                return tekst[i + 1:j], j + 1
        j += 1
    raise ValueError('niedomkniety nawias klamrowy')


# Kolejnosc ma znaczenie. Postac ze spacja usuwa odstep oddzielajacy nazwe
# polecenia od dalszego tekstu, a pusta para nawiasow pelni w zapisie te sama
# role i znika dopiero po zamianie polecen, zeby nie zjadac prawdziwych spacji.
ZNAKI_DOSLOWNE = [
    ('\\textbackslash ', '\\'), ('\\textbackslash', '\\'),
    ('\\textasciitilde ', '~'), ('\\textasciitilde', '~'),
    ('\\textasciicircum ', '^'), ('\\textasciicircum', '^'),
    ('{}', ''),
    ('\\_', '_'), ('\\{', '{'), ('\\}', '}'), ('\\&', '&'),
    ('\\%', '%'), ('\\#', '#'), ('\\$', '$'), ('\\ldots', '...'),
]


def doslownie(tekst):
    """Zawartosc polecen skladanych pismem maszynowym."""
    for a, b in ZNAKI_DOSLOWNE:
        tekst = tekst.replace(a, b)
    return tekst.strip()


def kod(tekst):
    tresc = doslownie(tekst)
    ogranicznik = '``' if '`' in tresc else '`'
    wypelnienie = ' ' if tresc.startswith('`') or tresc.endswith('`') else ''
    return f'{ogranicznik}{wypelnienie}{tresc}{wypelnienie}{ogranicznik}'


# ---------------------------------------------------------------------------
# Bibliografia
# ---------------------------------------------------------------------------


def wczytaj_bib():
    if not os.path.exists(BIB):
        return {}
    tresc = io.open(BIB, encoding='utf-8').read()
    opisy = {}
    for wpis in re.finditer(r'@\w+\{([^,]+),(.*?)\n\}', tresc, re.S):
        klucz, ciało = wpis.group(1).strip(), wpis.group(2)
        skrot = re.search(r'shorthand\s*=\s*\{(.+?)\}', ciało, re.S)
        if skrot:
            opisy[klucz] = ' '.join(skrot.group(1).split())
            continue
        autor = re.search(r'author\s*=\s*\{\{?(.+?)\}?\}\s*,', ciało, re.S)
        rok = re.search(r'year\s*=\s*\{(\d{4})\}', ciało)
        if autor:
            nazwa = ' '.join(autor.group(1).split()).rstrip('}')
            nazwa = nazwa.split(' and ')[0].split(',')[0]
            opisy[klucz] = f'{nazwa} {rok.group(1)}' if rok else nazwa
        else:
            opisy[klucz] = klucz
    return opisy


# ---------------------------------------------------------------------------
# Etykiety
# ---------------------------------------------------------------------------


def zbierz_etykiety():
    """Mapa etykieta -> (plik wynikowy, tekst naglowka, czy naglowek)."""
    mapa = {}
    for zrodlo, wynik in ROZDZIALY:
        sciezka = os.path.join(ZRODLA, zrodlo)
        if not os.path.exists(sciezka):
            continue
        for linia in io.open(sciezka, encoding='utf-8').read().split('\n'):
            m = re.match(r'\s*\\(chapter|section|subsection)\{', linia)
            if m:
                tytul, koniec = argument(linia, linia.index('{'))
                etykieta = re.search(r'\\label\{([^}]+)\}', linia[koniec:])
                if etykieta:
                    mapa[etykieta.group(1)] = (wynik, inline(tytul), True)
                continue
            m = re.match(r'\s*\\begin\{tabelaepi\}\{', linia)
            if m:
                tytul, koniec = argument(linia, linia.index('{', linia.index('tabelaepi') + 9))
                etykieta, _ = argument(linia, linia.index('{', koniec))
                mapa[etykieta] = (wynik, inline(tytul), False)
    return mapa


ETYKIETY = {}
OPISY = {}
LICZNIK = {'tabela': 0, 'listing': 0, 'wzor': 0}
BIEZACY = {'plik': ''}


# ---------------------------------------------------------------------------
# Konwersja tekstu w linii
# ---------------------------------------------------------------------------

PROSTE = {
    'termin': lambda a: f'*{inline(a)}*',
    'wyroznienie': lambda a: f'**{inline(a)}**',
    'enquote': lambda a: cytat(a),
    'emph': lambda a: f'*{inline(a)}*',
    'textbf': lambda a: f'**{inline(a)}**',
    'textit': lambda a: f'*{inline(a)}*',
    'url': lambda a: f'<{doslownie(a)}>',
    'kod': lambda a: kod(a),
    'argument': lambda a: kod(a),
    'pkg': lambda a: kod(a),
    'plik': lambda a: kod(a),
    'fun': lambda a: kod(a + '()'),
}


GLEBOKOSC = {'cytat': 0}


def cytat(tresc):
    """Cudzyslow polski, z cudzyslowem wewnetrznym na drugim poziomie."""
    GLEBOKOSC['cytat'] += 1
    poziom = GLEBOKOSC['cytat']
    wynik = inline(tresc)
    GLEBOKOSC['cytat'] -= 1
    return f'„{wynik}”' if poziom == 1 else f'«{wynik}»'


def odsylacz(etykieta):
    if etykieta not in ETYKIETY:
        return f'**{etykieta}**'
    plik, tytul, naglowek = ETYKIETY[etykieta]
    if not naglowek:
        return f'**{tytul}**'
    cel = f'#{slug(tytul)}' if plik == BIEZACY['plik'] else f'{plik}#{slug(tytul)}'
    return f'[{tytul}]({cel})'


def powolanie(klucze, przedrostek='', lokalizacja=''):
    opis = '; '.join(OPISY.get(k.strip(), k.strip()) for k in klucze.split(','))
    czesci = [c for c in (przedrostek, opis) if c]
    tekst = ' '.join(czesci)
    if lokalizacja:
        tekst += ', ' + lokalizacja
    return f'({tekst})'


def inline(tekst):
    """Zamiana polecen wystepujacych wewnatrz akapitu."""
    wynik, i = [], 0
    while i < len(tekst):
        z = tekst[i]
        if z != '\\':
            wynik.append(z)
            i += 1
            continue

        m = re.match(r'\\([a-zA-Z]+)', tekst[i:])
        if not m:
            wynik.append(tekst[i:i + 2])
            i += 2
            continue
        nazwa = m.group(1)
        j = i + m.end()

        if nazwa in PROSTE and j < len(tekst) and tekst[j] == '{':
            arg, j = argument(tekst, j)
            wynik.append(PROSTE[nazwa](arg))
            i = j
            continue

        if nazwa == 'osoba' and tekst[j] == '{':
            nazwisko, j = argument(tekst, j)
            imie, j = argument(tekst, j)
            wynik.append(f'{inline(imie)} {inline(nazwisko)}')
            i = j
            continue

        if nazwa in ('parencite', 'textcite'):
            przedrostek = lokalizacja = ''
            while j < len(tekst) and tekst[j] == '[':
                k = tekst.index(']', j)
                opcja = tekst[j + 1:k]
                if lokalizacja:
                    przedrostek, lokalizacja = lokalizacja, opcja
                else:
                    lokalizacja = opcja
                j = k + 1
            klucze, j = argument(tekst, j)
            tresc = powolanie(klucze, inline(przedrostek), inline(lokalizacja))
            if nazwa == 'textcite':
                tresc = tresc.strip('()')
            wynik.append(tresc)
            i = j
            continue

        if nazwa in ('ref', 'eqref', 'pageref'):
            etykieta, j = argument(tekst, j)
            wynik.append(odsylacz(etykieta))
            i = j
            continue

        if nazwa == 'label':
            _, j = argument(tekst, j)
            i = j
            continue

        if nazwa == 'ldots':
            wynik.append('…')
            i = j
            continue

        wynik.append('\\' + nazwa)
        i = j

    return zamien_poza_kodem(''.join(wynik))


def zamien_poza_kodem(tekst):
    """Zamiany typograficzne pomijajace fragmenty skladane pismem maszynowym.

    Wewnatrz odstepow kodu zapis musi zostac doslowny: zamiana dwoch lacznikow
    na poltapauze albo tyldy na spacje zmienialaby tresc, ktora czytelnik ma
    przepisac do swojego pliku.
    """
    czesci = re.split(r'(`+[^`]*`+)', tekst)
    for k, czesc in enumerate(czesci):
        if czesc.startswith('`'):
            continue
        czesc = czesc.replace('---', '—').replace('--', '–')
        czesc = czesc.replace('~', ' ')
        for a, b in (('\\%', '%'), ('\\&', '&'), ('\\_', '_'),
                     ('\\{', '{'), ('\\}', '}'), ('\\#', '#')):
            czesc = czesc.replace(a, b)
        czesci[k] = re.sub(r'[ \t]+', ' ', czesc)
    return ''.join(czesci).strip()


# ---------------------------------------------------------------------------
# Konwersja bloków
# ---------------------------------------------------------------------------


def komorka(tekst):
    return inline(tekst).replace('|', r'\|')


def podziel_komorki(wiersz):
    """Podzial wiersza tabeli po znakach rozdzielajacych kolumny.

    Znaki poprzedzone ukosnikiem oraz znajdujace sie wewnatrz nawiasow klamrowych
    naleza do tresci komorki, a nie rozdzielaja kolumn.
    """
    komorki, biezaca, glebokosc, i = [], [], 0, 0
    while i < len(wiersz):
        z = wiersz[i]
        if z == '\\' and i + 1 < len(wiersz):
            biezaca.append(wiersz[i:i + 2])
            i += 2
            continue
        if z == '{':
            glebokosc += 1
        elif z == '}':
            glebokosc -= 1
        elif z == '&' and glebokosc == 0:
            komorki.append(''.join(biezaca))
            biezaca = []
            i += 1
            continue
        biezaca.append(z)
        i += 1
    komorki.append(''.join(biezaca))
    return komorki


def tabela(linie, tytul):
    LICZNIK['tabela'] += 1
    wiersze = []
    for l in linie:
        s = l.strip()
        if not s or s.startswith('\\begin{tabular') or s.startswith('\\end{tabular'):
            continue
        if s in ('\\toprule', '\\midrule', '\\bottomrule'):
            continue
        if s.startswith('\\zrodlo'):
            continue
        s = re.sub(r'\\\\\s*$', '', s)
        wiersze.append([komorka(c) for c in podziel_komorki(s)])
    if not wiersze:
        return []
    szerokosc = max(len(w) for w in wiersze)
    wiersze = [w + [''] * (szerokosc - len(w)) for w in wiersze]
    out = [f'**Tabela {LICZNIK["tabela"]}. {inline(tytul)}**', '']
    out.append('| ' + ' | '.join(wiersze[0]) + ' |')
    out.append('|' + '---|' * szerokosc)
    for w in wiersze[1:]:
        out.append('| ' + ' | '.join(w) + ' |')
    out.append('')
    return out


def konwertuj(tresc):
    linie = tresc.split('\n')
    out, i = [], 0
    while i < len(linie):
        l = linie[i]
        s = l.strip()

        if s.startswith('%'):
            i += 1
            continue

        m = re.match(r'\\(chapter|section|subsection)\*?\{', s)
        if m:
            tytul, _ = argument(s, s.index('{'))
            poziom = {'chapter': '#', 'section': '##', 'subsection': '###'}[m.group(1)]
            out += ['', f'{poziom} {inline(tytul)}', '']
            i += 1
            continue

        if s == '\\wprowadzenie':
            out += ['', '# Wprowadzenie', '']
            i += 1
            continue

        if s.startswith('\\begin{tabelaepi}'):
            tytul, koniec = argument(s, s.index('{', s.index('tabelaepi') + 9))
            blok = []
            i += 1
            while not linie[i].strip().startswith('\\end{tabelaepi}'):
                blok.append(linie[i])
                i += 1
            i += 1
            out += tabela(blok, tytul)
            continue

        if s.startswith('\\begin{zapis}'):
            blok = []
            i += 1
            while not linie[i].strip().startswith('\\end{zapis}'):
                blok.append(linie[i])
                i += 1
            i += 1
            out += ['```latex'] + blok + ['```', '']
            continue

        if s.startswith('\\begin{lstlisting}'):
            jezyk = 'bash' if 'language=bash' in s else 'r'
            podpis = re.search(r'caption=\{(.+?)\}', s)
            blok = []
            i += 1
            while not linie[i].strip().startswith('\\end{lstlisting}'):
                blok.append(linie[i])
                i += 1
            i += 1
            if podpis:
                LICZNIK['listing'] += 1
                out += [f'**Listing {LICZNIK["listing"]}. {inline(podpis.group(1))}**', '']
            out += ['```' + jezyk] + blok + ['```', '']
            continue

        if s.startswith('\\begin{equation}'):
            LICZNIK['wzor'] += 1
            blok = []
            i += 1
            while not linie[i].strip().startswith('\\end{equation}'):
                blok.append(re.sub(r'\\label\{[^}]*\}', '', linie[i]).rstrip())
                i += 1
            i += 1
            tresc_wzoru = ' '.join(x.strip() for x in blok if x.strip()).rstrip('.')
            out += ['$$', f'{tresc_wzoru} \\qquad ({LICZNIK["wzor"]})', '$$', '']
            continue

        if s.startswith('\\begin{quote}'):
            blok = []
            i += 1
            while not linie[i].strip().startswith('\\end{quote}'):
                blok.append(linie[i].strip())
                i += 1
            i += 1
            out += ['> ' + inline(' '.join(blok)), '']
            continue

        m = re.match(r'\\begin\{(itemize|enumerate|kontrolna)\}', s)
        if m:
            rodzaj = m.group(1)
            blok, glebokosc = [], 1
            i += 1
            while True:
                t = linie[i].strip()
                if re.match(r'\\begin\{(itemize|enumerate|kontrolna)\}', t):
                    glebokosc += 1
                if t.startswith(f'\\end{{{rodzaj}}}') and glebokosc == 1:
                    break
                if t.startswith('\\end{'):
                    glebokosc -= 1
                blok.append(t)
                i += 1
            i += 1
            numer = 1
            for t in blok:
                if not t.startswith('\\item'):
                    if out and out[-1].startswith(('- ', '1', '2', '3', '4', '5', '6', '7', '8', '9')):
                        out[-1] += ' ' + inline(t)
                    continue
                tresc_pozycji = inline(t[len('\\item'):].strip())
                if rodzaj == 'kontrolna':
                    out.append(f'- [ ] {tresc_pozycji}')
                elif rodzaj == 'enumerate':
                    out.append(f'{numer}. {tresc_pozycji}')
                    numer += 1
                else:
                    out.append(f'- {tresc_pozycji}')
            out.append('')
            continue

        if not s:
            out.append('')
            i += 1
            continue

        out.append(inline(s))
        i += 1

    tekst = '\n'.join(out)
    tekst = re.sub(r'\n{3,}', '\n\n', tekst)
    return tekst.strip() + '\n'


# ---------------------------------------------------------------------------
# Wykonanie
# ---------------------------------------------------------------------------

NAGLOWEK = (
    '<!-- Plik powstaje automatycznie z przewodnik/rozdzialy/{zrodlo}.\n'
    '     Zmiany nanos w pliku zrodlowym, nie tutaj. -->\n\n'
)

STOPKA = (
    '\n---\n\n'
    'Wersja do druku obejmująca wszystkie rozdziały: '
    '[przewodnik.pdf](../przewodnik/przewodnik.pdf).\n'
)


KIEDY = {
    '01-latex.md': 'na początku, pierwsze dwa poziomy',
    '02-bibliografia.md': 'przed pierwszą lekturą',
    '03-overleaf.md': 'przy zakładaniu projektu',
    '04-jak-pisac.md': 'przy pisaniu każdej części',
    '05-warsztat.md': 'raz, na samym początku',
    '06-wymogi.md': 'przed oddaniem',
}


def tytul_rozdzialu(sciezka):
    for linia in io.open(sciezka, encoding='utf-8').read().split('\n'):
        if linia.strip().startswith('\\chapter{'):
            return inline(argument(linia, linia.index('{'))[0])
        if linia.strip() == '\\wprowadzenie':
            return 'Wprowadzenie'
    return ''


def zapisz_indeks(tytuly):
    wiersze = [
        '<!-- Pliki w tym katalogu powstaja automatycznie z przewodnik/rozdzialy/.',
        '     Zmiany nanos w plikach zrodlowych, nie tutaj. -->',
        '',
        '# Przewodnik seminaryjny',
        '',
        'Przewodnik prowadzi przez cały cykl seminarium — od pierwszego uruchomienia',
        'wzoru, przez budowę pakietu i pisanie kolejnych rozdziałów, po kontrolę formalną',
        'przed oddaniem pracy.',
        '',
        'Całość w jednym pliku, do druku: '
        '**[przewodnik.pdf](../przewodnik/przewodnik.pdf)**.',
        '',
        '| Rozdział | Temat | Kiedy czytać |',
        '|---|---|---|',
    ]
    numer = 0
    for plik, tytul in tytuly:
        if plik not in KIEDY:
            continue
        numer += 1
        wiersze.append(f'| {numer} | [{tytul}]({plik}) | {KIEDY[plik]} |')
    wiersze += [
        '',
        '## Skąd się biorą te pliki',
        '',
        'Źródłem treści są pliki LaTeX w katalogu [`przewodnik/`](../przewodnik/),',
        'składane tą samą klasą, z której korzystają prace studentów. Wersja w Markdown',
        'powstaje z nich automatycznie:',
        '',
        '```bash',
        'python przewodnik/tools/generuj_md.py',
        '```',
        '',
        'Dzięki temu obie wersje mówią to samo. Poprawki nanoś w plikach `.tex`.',
        '',
    ]
    io.open(os.path.join(CEL, 'README.md'), 'w', encoding='utf-8',
            newline='\n').write('\n'.join(wiersze))
    print('zapisano:', os.path.relpath(os.path.join(CEL, 'README.md'), KORZEN))


def main():
    global ETYKIETY, OPISY
    OPISY = wczytaj_bib()
    ETYKIETY = zbierz_etykiety()
    os.makedirs(CEL, exist_ok=True)

    tytuly = []
    for zrodlo, wynik in ROZDZIALY:
        sciezka = os.path.join(ZRODLA, zrodlo)
        if not os.path.exists(sciezka):
            continue
        BIEZACY['plik'] = wynik
        tresc = io.open(sciezka, encoding='utf-8').read()
        md = NAGLOWEK.format(zrodlo=zrodlo) + konwertuj(tresc) + STOPKA
        io.open(os.path.join(CEL, wynik), 'w', encoding='utf-8',
                newline='\n').write(md)
        tytuly.append((wynik, tytul_rozdzialu(sciezka)))
        print('zapisano:', os.path.relpath(os.path.join(CEL, wynik), KORZEN))

    zapisz_indeks(tytuly)


if __name__ == '__main__':
    main()

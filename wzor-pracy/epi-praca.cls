%% epi-praca.cls
%% Klasa pracy licencjackiej na kierunku elektroniczne przetwarzanie informacji.
%% Instytut Studiow Informacyjnych, Wydzial Zarzadzania i Komunikacji Spolecznej UJ.
%%
%% Sklad zgodny ze Standardami prac dyplomowych EPI oraz Instrukcja ISI.
%% Uklad rozdzialow zgodny ze wzorem seminaryjnym.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epi-praca}[2026/09/07 v1.0 Praca licencjacka EPI ISI UJ]

% --------------------------------------------------------------------------
% Opcje klasy
% --------------------------------------------------------------------------
% apa          - bibliografia w stylu APA 7 zamiast stylu instytutowego
% oprawa       - szerszy margines wewnetrzny kosztem zewnetrznego
% dwustronnie  - druk dwustronny, numer strony w rogu zewnetrznym
% stronyinfo   - strony informacyjne z abstraktem i slowami kluczowymi

\newif\ifepi@apa        \epi@apafalse
\newif\ifepi@oprawa     \epi@oprawafalse
\newif\ifepi@dwustronnie\epi@dwustronniefalse
\newif\ifepi@stronyinfo \epi@stronyinfofalse

\DeclareOption{apa}{\epi@apatrue}
\DeclareOption{oprawa}{\epi@oprawatrue}
\DeclareOption{dwustronnie}{\epi@dwustronnietrue}
\DeclareOption{stronyinfo}{\epi@stronyinfotrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\ifepi@dwustronnie
  \LoadClass[12pt,a4paper,twoside]{report}
\else
  \LoadClass[12pt,a4paper,oneside]{report}
\fi

% --------------------------------------------------------------------------
% Kroje pisma
% --------------------------------------------------------------------------
% Tekst glowny: Latin Modern w obu silnikach.
% Kod, nazwy funkcji, argumentow i pakietow: JetBrains Mono pod LuaLaTeX i XeLaTeX,
% Inconsolata pod pdfLaTeX. Wybor odbywa sie automatycznie.

\RequirePackage{iftex}

\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{lmodern}
  \RequirePackage[varqu,varl,scaled=0.95]{inconsolata}
\else
  \RequirePackage{fontspec}
  \setmainfont{Latin Modern Roman}[SmallCapsFont={Latin Modern Roman Caps}]
  \setsansfont{Latin Modern Sans}
  \setmonofont{JetBrainsMono}[Scale=MatchLowercase]
\fi

\RequirePackage{microtype}

% --------------------------------------------------------------------------
% Jezyk
% --------------------------------------------------------------------------

% Angielski wczytany jako jezyk poboczny, zeby opisy pozycji obcojezycznych
% mogly zachowac oryginalne skroty numeru tomu i stron.
\RequirePackage[english,main=polish]{babel}
\RequirePackage[autostyle=true]{csquotes}

% --------------------------------------------------------------------------
% Uklad strony
% --------------------------------------------------------------------------
% Marginesy 2,5 cm z kazdej strony. Opcja oprawa poszerza margines wewnetrzny
% kosztem zewnetrznego, ktory nie schodzi ponizej 1,5 cm.

\ifepi@oprawa
  \RequirePackage[a4paper,inner=3.5cm,outer=1.5cm,top=2.5cm,bottom=2.5cm]{geometry}
\else
  \RequirePackage[a4paper,margin=2.5cm]{geometry}
\fi

\RequirePackage{setspace}
\onehalfspacing

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

% Numeracja stron w prawym dolnym rogu. Przy druku dwustronnym w rogu zewnetrznym.
% Strona tytulowa jest liczona, ale numeru nie otrzymuje.

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\ifepi@dwustronnie
  \fancyfoot[LE,RO]{\thepage}
\else
  \fancyfoot[R]{\thepage}
\fi
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \ifepi@dwustronnie
    \fancyfoot[LE,RO]{\thepage}%
  \else
    \fancyfoot[R]{\thepage}%
  \fi}

% --------------------------------------------------------------------------
% Naglowki
% --------------------------------------------------------------------------
% Rozdzial: 18 pkt, wytluszczony, wysrodkowany, bez slowa "Rozdzial".
% Podrozdzial: 14 pkt, wytluszczony, do lewej, z jedna linia odstepu przed i po.

\RequirePackage{titlesec}

\titleformat{\chapter}[hang]
  {\normalfont\fontsize{18}{22}\bfseries\centering}
  {\thechapter}{0.6em}{}
\titlespacing*{\chapter}{0pt}{0pt}{1.5\baselineskip}

\titleformat{name=\chapter,numberless}[hang]
  {\normalfont\fontsize{18}{22}\bfseries\centering}
  {}{0pt}{}
\titlespacing*{name=\chapter,numberless}{0pt}{0pt}{1.5\baselineskip}

\titleformat{\section}[hang]
  {\normalfont\fontsize{14}{17}\bfseries\raggedright}
  {\thesection}{0.6em}{}
\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}

\titleformat{\subsection}[hang]
  {\normalfont\fontsize{12}{14}\bfseries\raggedright}
  {\thesubsection}{0.6em}{}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0.5\baselineskip}

\setcounter{secnumdepth}{3}

% --------------------------------------------------------------------------
% Spis tresci
% --------------------------------------------------------------------------

\RequirePackage{tocloft}
\setcounter{tocdepth}{2}
\renewcommand{\cftchapfont}{\normalfont\bfseries}
\renewcommand{\cftchappagefont}{\normalfont\bfseries}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{0.4\baselineskip}

% --------------------------------------------------------------------------
% Material ilustracyjny
% --------------------------------------------------------------------------
% Numeracja ciagla przez cala prace, osobna dla tabel, rysunkow i wykresow.
% Tytul nad obiektem, zrodlo pod obiektem.

\RequirePackage{graphicx}
\graphicspath{{rysunki/}}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{float}
\RequirePackage{newfloat}
\RequirePackage[labelsep=period,font={small},justification=raggedright,
                singlelinecheck=false]{caption}

\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}

\DeclareFloatingEnvironment[fileext=lop,listname={Spis wykres\'ow},
  name=Wykres,placement=htbp,within=none]{wykres}

\captionsetup{font={small,stretch=1}}

\newcommand{\zrodlo}[1]{%
  \par\vspace{0.35\baselineskip}%
  \begingroup\setstretch{1}\footnotesize\raggedright
  \'Zr\'od\l o: #1.\par\endgroup}

\NewDocumentEnvironment{tabelaepi}{m m}
  {\begin{table}[htbp]\setstretch{1}\caption{#1}\label{#2}\centering}
  {\end{table}}

\NewDocumentEnvironment{rysunekepi}{m m}
  {\begin{figure}[htbp]\setstretch{1}\caption{#1}\label{#2}\centering}
  {\end{figure}}

\NewDocumentEnvironment{wykresepi}{m m}
  {\begin{wykres}[htbp]\setstretch{1}\caption{#1}\label{#2}\centering}
  {\end{wykres}}

% --------------------------------------------------------------------------
% Matematyka
% --------------------------------------------------------------------------

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}

% --------------------------------------------------------------------------
% Listingi kodu
% --------------------------------------------------------------------------

\RequirePackage{xcolor}
\RequirePackage{listings}

\definecolor{epi@tlo}{gray}{0.97}
\definecolor{epi@komentarz}{RGB}{100,110,120}
\definecolor{epi@slowo}{RGB}{20,90,160}
\definecolor{epi@lancuch}{RGB}{140,70,20}
\definecolor{epi@ramka}{gray}{0.75}

\lstdefinestyle{epiR}{%
  language=R,
  basicstyle=\ttfamily\small\setstretch{1},
  keywordstyle=\color{epi@slowo},
  commentstyle=\color{epi@komentarz}\itshape,
  stringstyle=\color{epi@lancuch},
  numbers=left,
  numberstyle=\ttfamily\footnotesize\color{epi@komentarz},
  numbersep=10pt,
  backgroundcolor=\color{epi@tlo},
  frame=single,
  rulecolor=\color{epi@ramka},
  framesep=6pt,
  breaklines=true,
  breakatwhitespace=true,
  showstringspaces=false,
  columns=fullflexible,
  keepspaces=true,
  upquote=true,
  extendedchars=true,
  aboveskip=1.2\baselineskip,
  belowskip=0.8\baselineskip}

\lstset{style=epiR}

% Numeracja listingow ciagla przez cala prace, jak pozostalych obiektow.
% Licznik powstaje dopiero na poczatku dokumentu, stad odroczenie.
\AtBeginDocument{%
  \counterwithout{lstlisting}{chapter}%
  \renewcommand{\thelstlisting}{\arabic{lstlisting}}}

% Tablica znakow pakietu listings obejmuje wylacznie ASCII. Pod pdfLaTeX-em znaki
% polskie da sie odwzorowac na polecenia akcentow; pod LuaLaTeX-em i XeLaTeX-em
% znaki o kodzie powyzej 255 omijaja bufor wyrazu i wychodza przestawione.
% Dlatego wnetrze listingu sklada sie wylacznie ze znakow ASCII - to samo
% ograniczenie naklada sprawdzanie pakietu R, ktore zglasza znaki spoza ASCII
% w kodzie zrodlowym jako problem przenosnosci. Podpisy listingow, jako zwykly
% tekst pracy, moga zawierac polskie znaki bez ograniczen.
% Skrypt tools/sprawdz-listingi.R wskazuje miejsca naruszajace te zasade.
\ifPDFTeX
  \lstset{inputencoding=utf8,
    literate=%
      {ą}{{\k a}}1 {ć}{{\'c}}1 {ę}{{\k e}}1 {ł}{{\l}}1 {ń}{{\'n}}1
      {ó}{{\'o}}1 {ś}{{\'s}}1 {ź}{{\'z}}1 {ż}{{\.z}}1
      {Ą}{{\k A}}1 {Ć}{{\'C}}1 {Ę}{{\k E}}1 {Ł}{{\L}}1 {Ń}{{\'N}}1
      {Ó}{{\'O}}1 {Ś}{{\'S}}1 {Ź}{{\'Z}}1 {Ż}{{\.Z}}1}
\fi

\newcommand{\listingR}[3]{%
  \lstinputlisting[caption={#1},label={#2}]{#3}}

% --------------------------------------------------------------------------
% Makra semantyczne
% --------------------------------------------------------------------------
% Nazwy funkcji, argumentow, pakietow i plikow skladane pismem maszynowym.
% Terminy wprowadzane, wyrazy obce i tytuly dziel - kursywa.
% Wyroznienia tresciowe - wytluszczenie.

% Nazwa \arg jest zajeta przez operator matematyczny z amsmath.
\newcommand{\fun}[1]{\texttt{#1()}}
\newcommand{\argument}[1]{\texttt{#1}}
\newcommand{\pkg}[1]{\texttt{#1}}
\newcommand{\plik}[1]{\texttt{#1}}
\newcommand{\kod}[1]{\texttt{#1}}
\newcommand{\termin}[1]{\textit{#1}}
\newcommand{\wyroznienie}[1]{\textbf{#1}}

% --------------------------------------------------------------------------
% Indeks nazwisk
% --------------------------------------------------------------------------
% \osoba{Nazwisko}{Imie} sklada "Imie Nazwisko" i dopisuje pozycje do indeksu.

\RequirePackage{imakeidx}
\makeindex[title={Indeks nazwisk},columns=2,intoc=true]

\newcommand{\osoba}[2]{#2~#1\index[nazwiska]{#1, #2}}
\newcommand{\nazwisko}[2]{#1\index[nazwiska]{#1, #2}}

% --------------------------------------------------------------------------
% Bibliografia
% --------------------------------------------------------------------------

\ifepi@apa
  \RequirePackage[backend=biber,style=apa,language=polish,
                  sortcites=true,uniquename=init]{biblatex}
  \DeclareLanguageMapping{polish}{polish-apa}
\else
  % Opcji autolang nie wlaczamy: przejmuje ona pole langid i czyni je
  % nieczytelnym dla stylu, ktory rozstrzyga na jego podstawie o polskiej
  % albo oryginalnej postaci skrotow numeru, tomu, stron i daty odczytu.
  \RequirePackage[backend=biber,style=isi-uj,language=polish,
                  maxcitenames=3,mincitenames=1,maxbibnames=99,
                  sorting=nyt,sortcites=true,uniquename=init,uniquelist=false,
                  giveninits=false,dashed=false]{biblatex}
\fi

% --------------------------------------------------------------------------
% Metadane pracy
% --------------------------------------------------------------------------

\newcommand{\epi@autor}{}
\newcommand{\epi@nralbumu}{}
\newcommand{\epi@tytul}{}
\newcommand{\epi@tytulen}{}
\newcommand{\epi@promotor}{}
\newcommand{\epi@rok}{\the\year}
\newcommand{\epi@adresstrony}{}
\newcommand{\epi@adresrepozytorium}{}
\newcommand{\epi@abstraktpl}{}
\newcommand{\epi@abstrakten}{}
\newcommand{\epi@slowaklucze}{}
\newcommand{\epi@keywords}{}
\newcommand{\epi@liczbastron}{}

\newcommand{\autor}[1]{\renewcommand{\epi@autor}{#1}}
\newcommand{\nralbumu}[1]{\renewcommand{\epi@nralbumu}{#1}}
\newcommand{\tytul}[1]{\renewcommand{\epi@tytul}{#1}}
\newcommand{\tytulen}[1]{\renewcommand{\epi@tytulen}{#1}}
\newcommand{\promotor}[1]{\renewcommand{\epi@promotor}{#1}}
\newcommand{\rok}[1]{\renewcommand{\epi@rok}{#1}}
\newcommand{\adresstrony}[1]{\renewcommand{\epi@adresstrony}{#1}}
\newcommand{\adresrepozytorium}[1]{\renewcommand{\epi@adresrepozytorium}{#1}}
\newcommand{\abstraktpl}[1]{\renewcommand{\epi@abstraktpl}{#1}}
\newcommand{\abstrakten}[1]{\renewcommand{\epi@abstrakten}{#1}}
\newcommand{\slowaklucze}[1]{\renewcommand{\epi@slowaklucze}{#1}}
\newcommand{\keywords}[1]{\renewcommand{\epi@keywords}{#1}}
\newcommand{\liczbastron}[1]{\renewcommand{\epi@liczbastron}{#1}}

% --------------------------------------------------------------------------
% Strona tytulowa
% --------------------------------------------------------------------------

\newcommand{\stronatytulowa}{%
  \begin{titlepage}
  \thispagestyle{empty}
  \setstretch{1}
  \noindent Nr albumu: \epi@nralbumu
  \begin{center}
    \vspace*{0.3cm}
    {\large Uniwersytet Jagiello\'nski\par}
    \vspace{0.2cm}
    {\large Wydzia\l{} Zarz\k adzania i Komunikacji Spo\l ecznej\par}
    \vspace{0.5cm}
    {\large\MakeUppercase{Instytut Studi\'ow Informacyjnych}\par}
    \vspace{1.1cm}
    {Studia stacjonarne\par}
    \vspace{0.2cm}
    {Kierunek: elektroniczne przetwarzanie informacji\par}
    \vspace{1.2cm}
    {\Large Praca licencjacka\par}
    \vspace{1.3cm}
    {\large\epi@autor\par}
    \vspace{1.3cm}
    {\LARGE\bfseries\MakeUppercase{\epi@tytul}\par}
    \vspace{1.1cm}
    {\small\texttt{\epi@adresstrony}\par}
    \vspace{0.1cm}
    {\small\texttt{\epi@adresrepozytorium}\par}
  \end{center}
  \vfill
  \noindent\hfill\begin{minipage}{0.52\textwidth}
    \raggedright
    Promotor pracy licencjackiej\par
    \epi@promotor
  \end{minipage}
  \vspace{1.2cm}
  \begin{center}
    {\footnotesize Opracowano zgodnie z obowi\k azuj\k acymi przepisami
     o prawie autorskim i prawach pokrewnych\par}
    \vspace{0.8cm}
    {Krak\'ow \epi@rok\par}
  \end{center}
  \end{titlepage}
  \setcounter{page}{2}}

% --------------------------------------------------------------------------
% Strony informacyjne
% --------------------------------------------------------------------------
% Opis bibliograficzny pracy, abstrakt i slowa kluczowe wedlug Instrukcji ISI.
% Strona angielska sklada sie tylko wtedy, gdy podano angielskie metadane.

\newcommand{\epi@stronainfo}[6]{%
  \clearpage
  \thispagestyle{fancy}
  \begin{center}{\large\bfseries #1\par}\end{center}
  \vspace{0.8\baselineskip}
  \noindent #2\par
  \vspace{1.2\baselineskip}
  \noindent\textbf{#3}\par
  \vspace{0.4\baselineskip}
  \noindent #4\par
  \vspace{1.2\baselineskip}
  \noindent\textbf{#5} #6\par}

\newcommand{\stronyinformacyjne}{%
  \ifepi@stronyinfo
    \epi@stronainfo
      {Strona informacyjna}
      {\epi@autor\ (\epi@rok). \epi@tytul. Praca licencjacka.
       Promotor: \epi@promotor. Krak\'ow: Instytut Studi\'ow Informacyjnych UJ,
       \epi@liczbastron\ s.}
      {Abstrakt}{\epi@abstraktpl}
      {S\l owa kluczowe:}{\epi@slowaklucze}
    \ifx\epi@abstrakten\empty\else
      \epi@stronainfo
        {Information page}
        {\epi@autor\ (\epi@rok). \epi@tytulen. Bachelor's thesis.
         Supervisor: \epi@promotor. Krak\'ow: Institute of Information Studies,
         Jagiellonian University, \epi@liczbastron\ pp.}
        {Abstract}{\epi@abstrakten}
        {Keywords:}{\epi@keywords}
    \fi
  \fi}

% --------------------------------------------------------------------------
% Elementy nienumerowane obecne w spisie tresci
% --------------------------------------------------------------------------

\newcommand{\rozdzialbezn}[1]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}}

\newcommand{\wprowadzenie}{\rozdzialbezn{Wprowadzenie}}
\newcommand{\podsumowanie}{\rozdzialbezn{Podsumowanie}}
\newcommand{\wykazzrodel}{\rozdzialbezn{Wykaz \'zr\'ode\l}}
\newcommand{\spisilustracji}{%
  \rozdzialbezn{Spis ilustracji}%
  \begingroup\setstretch{1}%
  \renewcommand{\listtablename}{Tabele}%
  \renewcommand{\listfigurename}{Rysunki}%
  \listoftables\vspace{\baselineskip}%
  \listoffigures\vspace{\baselineskip}%
  \listofwykres%
  \endgroup}

\newcommand{\indeksnazwisk}{\printindex}

\newcommand{\bibliografia}{%
  \begingroup\setstretch{1}%
  \printbibliography[title={Bibliografia},heading=bibintoc]%
  \endgroup}

% Aneksy z wlasna numeracja i odrebnymi pozycjami w spisie tresci.
\newcounter{aneks}
\newcommand{\aneksy}{\rozdzialbezn{Aneksy}}
\newcommand{\aneks}[1]{%
  \refstepcounter{aneks}%
  \section*{Aneks \arabic{aneks}. #1}%
  \addcontentsline{toc}{section}{Aneks \arabic{aneks}. #1}}

% --------------------------------------------------------------------------
% Odsylacze
% --------------------------------------------------------------------------

\RequirePackage[hidelinks]{hyperref}
\RequirePackage{bookmark}
\RequirePackage{url}

\endinput

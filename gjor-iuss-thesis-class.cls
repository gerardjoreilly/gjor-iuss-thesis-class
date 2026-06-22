\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gjor-iuss-thesis-class}[IUSS Pavia PhD Thesis Class]
% Author: Gerard J. O'Reilly – https://gerardjoreilly.github.io/


% ============================================================
%  BASE CLASS
% ============================================================
\LoadClass[11pt,a4paper,twoside,openright]{report}


% ============================================================
%  METADATA  –– set via \thesissetup{key=value, ...}
% ============================================================
\RequirePackage{keyval}

% Defaults
\newcommand{\ThesisTitle}{Thesis Title}
\newcommand{\ThesisAuthor}{Author Name}
\newcommand{\ThesisYear}{2025}
\newcommand{\ThesisSubmissionMonth}{Month Year}
\newcommand{\DegreeTitle}{earthquake engineering and engineering seismology}
\newcommand{\ThesisInstitution}{Scuola Universitaria Superiore IUSS Pavia}
\newcommand{\ThesisPDFKeywords}{PhD Thesis}

\define@key{thesis}{title}          {\renewcommand{\ThesisTitle}{#1}}
\define@key{thesis}{author}         {\renewcommand{\ThesisAuthor}{#1}}
\define@key{thesis}{year}           {\renewcommand{\ThesisYear}{#1}}
\define@key{thesis}{submissionmonth}{\renewcommand{\ThesisSubmissionMonth}{#1}}
\define@key{thesis}{degree}         {\renewcommand{\DegreeTitle}{#1}}
\define@key{thesis}{institution}    {\renewcommand{\ThesisInstitution}{#1}}
\define@key{thesis}{pdfkeywords}    {\renewcommand{\ThesisPDFKeywords}{#1}}
\define@key{thesis}{linenos}        {\csname @thesislinenos#1\endcsname}
\define@key{thesis}{outputname}     {\renewcommand{\ThesisOutputName}{#1}}

\newcommand{\thesissetup}[1]{\setkeys{thesis}{#1}}

\newcommand{\ThesisOutputName}{}
% Write the desired PDF name to <jobname>.outputname so latexmkrc can copy it
\AtBeginDocument{%
  \ifx\ThesisOutputName\empty\else
    \newwrite\@thesis@outfile
    \immediate\openout\@thesis@outfile=\jobname.outputname
    \immediate\write\@thesis@outfile{\ThesisOutputName}%
    \immediate\closeout\@thesis@outfile
  \fi
}


% ============================================================
%  SUPERVISORS  –– \AddAdvisor{Name}{Affiliation}
% ============================================================
\RequirePackage{etoolbox}

\newcounter{advisorcount}
\newcommand{\advisorlist}{}

\newcommand{\AddAdvisor}[2]{%
  \stepcounter{advisorcount}%
  \ifnum\value{advisorcount}=1
    \appto\advisorlist{#1 -- #2}%
  \else
    \appto\advisorlist{\\#1 -- #2}%
  \fi
}

\newcommand{\PrintAdvisors}{%
  \ifnum\value{advisorcount}>1 Supervisors:\else Supervisor:\fi
  \\[0.3cm]
  \onehalfspacing
  \advisorlist
}


% ============================================================
%  ENCODING, FONTS & MATHS
% ============================================================
\RequirePackage[utf8]{inputenc}
\RequirePackage{amsmath,amssymb,bm}
\RequirePackage{upgreek}
\RequirePackage{gensymb}
\RequirePackage{lipsum}     % For inserting dummy text


% ============================================================
%  PAGE GEOMETRY
% ============================================================
\RequirePackage{geometry}
\geometry{
  top           = 6cm,
  bottom        = 4.7cm,
  inner         = 4cm,
  outer         = 3.5cm,
  bindingoffset = 0cm,
  headsep       = 1.2cm,
  footskip      = 3.2cm,
}


% ============================================================
%  GRAPHICS & FLOATS
% ============================================================
\RequirePackage{graphicx}
\RequirePackage{svg}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{lscape}
\RequirePackage{placeins}

\captionsetup{font=small, labelfont=bf, labelsep=period, format=hang}
\setlength{\abovecaptionskip}{5pt}
\setlength{\belowcaptionskip}{0pt}

\renewcommand{\floatpagefraction}{0.8}
\renewcommand{\textfraction}{0.1}


% ============================================================
%  TABLES
% ============================================================
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{diagbox}
\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage{threeparttable}

\definecolor{lightgray}{gray}{0.9}


% ============================================================
%  HEADERS, FOOTERS & SECTIONING
% ============================================================
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{setspace}

\setlength{\headheight}{14.5pt}

% Plain style – page numbers only (chapter opening pages)
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyhead[RO]{\small\thepage}
  \fancyhead[LE]{\small\thepage}
}

% Main body style
\fancypagestyle{mainmatter}{%
  \fancyhf{}
  \fancyhead[RO]{\small\thepage}
  \fancyhead[LE]{\small\thepage}
  % \fancyhead[CE]{\small\ThesisTitle} % Comented out because if the title is too long, it breaks and looks bad
  \fancyhead[CO]{\small\ThesisAuthor}
}

% Heading formats – matched to gjor-article-class-review
\titleformat{\chapter}[display]
  {\normalfont\LARGE\bfseries}{\chaptertitlename\ \thechapter}{20pt}{\LARGE}

\titleformat{\section}
  {\normalfont\Large\bfseries}{\thesection}{1em}{}

\titleformat{\subsection}
  {\normalfont\large\bfseries}{\thesubsection}{1em}{}

\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries}{\thesubsubsection}{1em}{}


% ============================================================
%  UNNUMBERED CHAPTER HELPER
% ============================================================
\let\@oldchapter\chapter

% Suppress page-number style on numbered chapter opening pages
\renewcommand{\chapter}[1]{%
  \@oldchapter{#1}%
  \thispagestyle{plain}%
}

% \unnumberedchapter{Title} – starred chapter with TOC + header
\newcommand{\unnumberedchapter}[1]{%
  \@oldchapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{}%
  \thispagestyle{plain}%
}


% ============================================================
%  BLANK-PAGE SUPPRESSION
% ============================================================
\renewcommand{\cleardoublepage}{%
  \clearpage
  \ifodd\c@page\else
    \thispagestyle{empty}%
    \hbox{}%
    \newpage
  \fi
}

% ============================================================
%  TABLE OF CONTENTS
% ============================================================
\RequirePackage{tocloft}
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3}
\renewcommand{\cftdotsep}{1.5}


% ============================================================
%  TYPOGRAPHY
% ============================================================
\tolerance=500
\emergencystretch=3em
\hyphenpenalty=5000
\hbadness=5000
\raggedbottom
\setlength{\parindent}{20pt}


% ============================================================
%  COLOURS & HIGHLIGHTING
% ============================================================
\RequirePackage{color,soul}


% ============================================================
%  HYPERLINKS & PDF METADATA
%  (loaded late so it patches everything correctly)
% ============================================================
\RequirePackage[
  colorlinks = true,
  linkcolor  = blue,
  citecolor  = blue,
  urlcolor   = blue,
  pdfborder  = {0 0 0},
]{hyperref}
\RequirePackage{bookmark}

\AtBeginDocument{%
  \hypersetup{
    pdftitle    = {\ThesisTitle},
    pdfauthor   = {\ThesisAuthor},
    pdfkeywords = {\ThesisPDFKeywords},
    bookmarksdepth = 3,
  }%
}


% ============================================================
%  BIBLIOGRAPHY
% ============================================================
\RequirePackage[numbers]{natbib}
\renewcommand{\bibsep}{0pt}
\RequirePackage{bibentry}
\nobibliography*
% natbib's \bibsection calls \chapter* which the class's \chapter redefinition
% breaks (it expects one mandatory arg, eating the *). Override to use
% \unnumberedchapter which correctly calls \@oldchapter*.
\AtBeginDocument{%
  \renewcommand{\bibsection}{%
    \unnumberedchapter{\bibname}%
  }%
}

% ============================================================
%  LISTS
% ============================================================
\RequirePackage{enumitem}

% ============================================================
%  ABBREVIATIONS & ACRONYMS
% ============================================================
\RequirePackage{acro}
\acsetup{
  list / display  = all ,
  list / template = longtable ,
}
\acsetup{templates/colspec = {l@{\hspace{1.5em}}p{.8\linewidth}}}

% ============================================================
%  ARRAY STRETCH
% ============================================================
\renewcommand{\arraystretch}{1.2}


% ============================================================
%  LINE NUMBERS  –– enable with  linenos = true  in \thesissetup
% ============================================================
\RequirePackage{lineno}
\newif\if@thesislinenos
\@thesislinenosfalse
\AtBeginDocument{\if@thesislinenos\linenumbers\fi}


% ============================================================
%  APPENDIX  –– \addappendix{Title}{file}
%
%  On the first call: triggers \appendix (switches chapter counter
%  to letters and \chaptertitlename to "Appendix"), then ties the
%  figure/table/equation counters to the chapter so they read
%  A.1, A.2, etc.  Subsequent calls just open the next appendix.
%  Files are read from appendices/<file>.tex.
% ============================================================
\newif\if@appendixstarted
\@appendixstartedfalse

\newcommand{\addappendix}[2]{%
  \if@appendixstarted\else
    \appendix
    \counterwithin{figure}{chapter}%
    \counterwithin{table}{chapter}%
    \counterwithin{equation}{chapter}%
    \@appendixstartedtrue
  \fi
  \@oldchapter{#1}%
  \thispagestyle{plain}%
  \input{appendices/#2}%
}


% ============================================================
%  FRONT MATTER MACRO  –– \makefrontmatter
% ============================================================
\newcommand{\makefrontmatter}{%
  %--- Title page -------------------------------------------
  \begin{titlepage}
    \centering
    \includegraphics[width=0.6\textwidth]{figs/logo-iuss.pdf}\par
    \vspace{0cm}
    {\textbf{\ThesisInstitution}\par}
    \vspace{1cm}
    {\setstretch{1.3}\LARGE\bfseries \ThesisTitle \par}
    \vspace{1cm}
    {\setstretch{1.2}\large
      A Thesis Submitted in Partial Fulfilment of the Requirements\\
      for the Degree of Doctor of Philosophy in\par}
    \vspace{0.7cm}
    {\setstretch{1.3}\large\bfseries \MakeUppercase{\DegreeTitle}\par}
    \vspace{0.7cm}
    {by\par}
    \vspace{0.5cm}
    {\large\textbf{\ThesisAuthor}\par}
    \vspace{1cm}
    {\large\PrintAdvisors\par}
    \vfill
    {\large\ThesisSubmissionMonth\par}
  \end{titlepage}
  \cleardoublepage
  %--- Roman numerals ---------------------------------------
  \pagenumbering{roman}
  \pagestyle{plain}
  %--- Abstract ---------------------------------------------
  \unnumberedchapter{Abstract}
  \input{docs/abstract}
  %--- Italian abstract -------------------------------------
  \unnumberedchapter{Sommario}
  \input{docs/sommario}
  %--- Acknowledgements (optional) --------------------------
  \IfFileExists{docs/acknowledgements.tex}{%
    \unnumberedchapter{Acknowledgements}%
    \input{docs/acknowledgements}%
    \cleardoublepage
  }{}
  %--- ToC / LoF / LoT --------------------------------------
  \phantomsection
  \addcontentsline{toc}{chapter}{Contents}
  \tableofcontents
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Figures}
  \listoffigures
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Tables}
  \listoftables
  \cleardoublepage
  %--- Nomenclature -----------------------------------------
  \unnumberedchapter{Nomenclature}
  \printacronyms[heading=none]
  \cleardoublepage
  \acresetall
  %--- Switch to main matter --------------------------------
  \pagenumbering{arabic}
  \pagestyle{mainmatter}
}
global !p

##  block
block = {
    "tm" : ["Thm"        ,"brown"  ,"▶",0],
    "tt" : ["Thm"        ,"brown"  ,"▶",1],
    "ex" : ["Ex"         ,"teal"   ,"▶",0],
    "pf" : ["Pf"         ,"green"  ,"▶",0],
    "pb" : ["Problem"    ,"teal"   ,"▶",0],
    "sn" : ["Sol"        ,"green"  ,"▶",0],
    "df" : ["Def"        ,"purple" ,"▶",0],
    "dd" : ["Def"        ,"purple" ,"▶",1],
    "st" : ["Step"       ,"orange" ,"▶",0],
    "md" : ["Method"     ,"brown"  ,"■",0],
    "cc" : ["Case"       ,"brown"  ,"●",0],
    "ds" : ["Discussion" ,"brown"  ,"■",0],
}

arrow = {
    'r' : 'right',
    'R' : 'Right',
    'l' : 'left',
    'L' : 'Left',
    'lr':'leftright',
    'Lr':'Leftright',
    'u' : 'up',
    'U' : 'Up',
    'd' : 'down',
    'D': 'Down',
    'ud':'updown',
    'Ud':'Updown',
    'rr': 'longright',
    'll': 'longleft',
    'RR': 'Longright',
    'LL': 'Longleft',
    'se': 'se',
    'sw': 'sw',
    'ne': 'ne',
    'nw': 'nw'
}

endglobal


# Basic Document template
snippet template "Basic template" b
\documentclass{article}
\usepackage[a4paper, total={7in, 9in}]{geometry}
\usepackage{amsthm}
\usepackage{amsmath, amssymb}
\usepackage{xcolor}
\usepackage{mathtools} 
\DeclarePairedDelimiter\norm\lVert\rVert
\DeclarePairedDelimiter\mod\lVert\rVert

\newcommand{\red}[1]{{\color{red} #1}}
\newcommand{\blue}[1]{{\color{blue} #1}}
\newcommand{\R}{\mathbb{R}}
\newtheorem{theorem}{Theorem}
\newtheorem{definition}{Definition}
\newtheorem{example}{Example}

% \pdfsuppresswarningpagegroup=1

\newcommand{\executeiffilenewer}[3]{%
 \ifnum\pdfstrcmp{\pdffilemoddate{#1}}%
 {\pdffilemoddate{#2}}>0%
 {\immediate\write18{#3}}\fi%
}
\newcommand{\includesvg}[1]{%
 \executeiffilenewer{#1.svg}{#1.pdf}%
 {inkscape -z -D --file=#1.svg %
 --export-pdf=#1.pdf --export-latex}%
 \input{#1.pdf_tex}%
}

\title{${2:title}}
\author{Anand Kumar}


\begin{document}
	$0
\end{document}
endsnippet

# External Computations
snippet sympy "sympyblock " w
sympy $1 sympy$0
endsnippet

priority 10000
snippet 'sympy(.*)sympy' "sympy" wr
`!p
from sympy import *
x, y, z, t = symbols('x y z t')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
init_printing()
snip.rv = eval('latex(' + match.group(1).replace('\\', '').replace('^', '**').replace('{', '(').replace('}', ')') + ')')
`
endsnippet

priority 1000
snippet math "mathematicablock" w
math $1 math$0
endsnippet

priority 10000
snippet 'math(.*)math' "math" wr
`!p
import subprocess
code = match.group(1)
code = 'ToString[' + code + ', TeXForm]'
snip.rv = subprocess.check_output(['wolframscript', '-code', code])
`
endsnippet

snippet cite; "cite" wA
\\cite{$1} $0
endsnippet

snippet eqref; "eqref" wA
\\eqref{eq:$1} $0 
endsnippet

snippet ref; "ref" wA
\\ref{$1} $0
endsnippet


snippet plot "Plot" w
\begin{figure}[$1]
	\centering
	\begin{tikzpicture}
		\begin{axis}[
			xmin= ${2:-10}, xmax= ${3:10},
			ymin= ${4:-10}, ymax = ${5:10},
			axis lines = middle,
		]
			\addplot[domain=$2:$3, samples=${6:100}]{$7};
		\end{axis}
	\end{tikzpicture}
	\caption{$8}
	\label{${9:$8}}
\end{figure}
endsnippet

snippet nn "Tikz node" w
\node[$5] (${1/[^0-9a-zA-Z]//g}${2}) ${3:at (${4:0,0}) }{$${1}$};
$0
endsnippet

snippet beg "begin{} / end{}" bA
\\begin{$1}
	$0
\\end{$1}
endsnippet

#Table, Figure, Enumerate, Itemize, Description, usepackage 
snippet table "Table environment" b
\begin{table}[${1:htpb}]
	\centering
	\caption{${2:caption}}
	\label{tab:${3:label}}
	\begin{tabular}{${5:c}}
	$0${5/((?<=.)c|l|r)|./(?1: & )/g}
	\end{tabular}
\end{table}
endsnippet

snippet ink "svg figure" w
\begin{figure}[h]
	\def\svgwidth{0.5\textwidth}
	\input{$1}
	\caption{$2}
	\label{fig:${3:label}
\end{figure}
endsnippet

snippet fig "Figure environment" b
\begin{figure}[${1:htpb}]
	\centering
	${2:\includegraphics[width=0.8\textwidth]{$3}}
	\caption{${4:$3}}
	\label{fig:${5:${3/\W+/-/g}}}
\end{figure}
endsnippet

snippet mpa "minipage" b
\begin{minipage}{${2:0.45}\textwidth}
	${1:${VISUAL}}
\end{minipage}$0
endsnippet

snippet enum "Enumerate" b
\begin{enumerate}
	\item $0
\end{enumerate}
endsnippet

snippet itemi "Itemize" b
\begin{itemize}
	\item $0
\end{itemize}
endsnippet

snippet desc "Description" b
\begin{description}
	\item[$1] $0
\end{description}
endsnippet

snippet pac "Package" b
\usepackage[${1:options}]{${2:package}}$0
endsnippet

snippet mk "Math" wA
$${1}$`!p
if t[2] and t[2][0] not in [',', '.', '?', '-', ' ']:
	snip.rv = ' '
else:
	snip.rv = ''
`$2
endsnippet

snippet dm "Math" wA
\[
${1:${VISUAL}}
\] $0
endsnippet

snippet spl "Split" bA 
\begin{split}
	${1:${VISUAL}}
\end{split}
endsnippet

snippet eq "Equation" bA 
\begin{equation}
	${1:${VISUAL}}
\end{equation}
endsnippet

snippet ali "Align" bA
\begin{align*}
	${1:${VISUAL}}
\end{align*}
endsnippet

snippet red "red" w
\red{$1}$0
endsnippet

snippet blue "blue" w 
\blue{$1}$0
endsnippet

snippet proof "proof block" w
\begin{proof}
$1
\end{proof}
$0	
endsnippet	

snippet eref "eqref" w
\\eqref{eq:$1} $0
endsnippet

# vim:ft=snippets

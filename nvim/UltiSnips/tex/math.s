global !p
def math():
	return vim.eval('vimtex#syntax#in_mathzone()') == '1'

def comment(): 
	return vim.eval('vimtex#syntax#in_comment()') == '1'

def env(name):
	[x,y] = vim.eval("vimtex#env#is_inside('" + name + "')") 
	return x != '0' and y != '0'

##  block - unused
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

# matrices and vectors
# snippet pmat "pmat" w
# \begin{pmatrix} $1 \end{pmatrix} $0
# endsnippet

# snippet bmat "bmat" w
# \begin{bmatrix} $1 \end{bmatrix} $0
# endsnippet

snippet cvec "column vector" A
\begin{pmatrix} ${1:x}_${2:1}\\\\ \vdots\\\\ $1_${2:n} \end{pmatrix}
endsnippet

snippet arr "arr" wA
\begin{array}{${1:cc}} $2 \end{array} $0
endsnippet

# various dots 
priority 100
context "math()"
snippet ldo "ldots" iA
\\ldots
endsnippet

context "math()"
snippet cdo "cdots" iA
\\cdots
endsnippet

context "math()"
snippet vdo "vdots" iA
\\vdots
endsnippet

context "math()"
snippet ddo "ddots" iA
\\ddots
endsnippet


# Mathematical Logic 
context "math()"
snippet impl "implies" iA
\implies
endsnippet

context "math()"
snippet iimp "implied by" iA
\impliedby
endsnippet

context "math()"
snippet iff "iff" iA
\iff
endsnippet

# Spaces in math mode 
context "math()"
snippet ,; "space" iA
\,
endsnippet

context "math()"
snippet ;; "bigspace" iA
\;
endsnippet

snippet qq "quad" iA
\quad
endsnippet

# Fractions
context "math()"
snippet // "Fraction" iA
\\frac{$1}{$2}$0
endsnippet

snippet / "Fraction" i
\\frac{${VISUAL}}{$1}$0
endsnippet

context "math()"
snippet '((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\d+\}|\d))*)/' "symbol frac" wrA
\\frac{`!p snip.rv = match.group(1)`}{$1}$0
endsnippet

priority 1000
context "math()"
snippet '^.*\)/' "() frac" wrA
`!p
stripped = match.string[:-1]
depth = 0
i = len(stripped) - 1
while True:
	if stripped[i] == ')': depth += 1
	if stripped[i] == '(': depth -= 1
	if depth == 0: break;
	i-=1
snip.rv = stripped[0:i] + "\\frac{" + stripped[i+1:-1] + "}"
`{$1}$0
endsnippet

# subscripts subscripts powers exponents
context "math()"
snippet '([A-Za-z])(\d)' "auto subscript" wrA
`!p snip.rv = match.group(1)`_`!p snip.rv = match.group(2)`
endsnippet

context "math()"
snippet '([A-Za-z])_(\d\d)' "auto subscript2" wrA
`!p snip.rv = match.group(1)`_{`!p snip.rv = match.group(2)`}
endsnippet

context "math()" 
snippet ij; "ij" iA
_{ij}
endsnippet

context "math()"
snippet conj "conjugate" iA
\overline{$1}$0
endsnippet

context "math()"
snippet sq "\sqrt{}" iA
\sqrt{${1:${VISUAL}}} $0
endsnippet

context "math()"
snippet sr "^2" iA
^2
endsnippet

context "math()"
snippet rd "to the ... power" iA
^{$1}$0
endsnippet

context "math()"
snippet -- "subscript" iA
_{$1}$0
endsnippet

snippet == "equals" iA
&= $1 \\\\ $0
endsnippet

context "math()"
snippet neq "equals" iA
\neq 
endsnippet

context "math()"
snippet ceil "ceil" iA
\left\lceil $1 \right\rceil $0
endsnippet

context "math()"
snippet floor "floor" iA
\left\lfloor $1 \right\rfloor$0
endsnippet

# Brackets / Enclosures - Visual 
context "math()"
snippet () "left( right)" iA
\left( ${1:${VISUAL}} \right) $0
endsnippet

snippet lr "left( right)" i
\left( ${1:${VISUAL}} \right) $0
endsnippet

snippet lr( "left( right)" i
\left( ${1:${VISUAL}} \right) $0
endsnippet

snippet lr| "left| right|" i
\left| ${1:${VISUAL}} \right| $0
endsnippet

snippet lr{ "left\{ right\}" i
\left\\{ ${1:${VISUAL}} \right\\} $0
endsnippet

snippet lrb "left\{ right\}" i
\left\\{ ${1:${VISUAL}} \right\\} $0
endsnippet

snippet lr[ "left[ right]" i
\left[ ${1:${VISUAL}} \right] $0
endsnippet

snippet lra "leftangle rightangle" iA
\left<${1:${VISUAL}} \right>$0
endsnippet

snippet obra "underbrace" iA
\overbrace{${2:${VISUAL}}}_{$1} $0
endsnippet

snippet ubra "underbrace" iA
\underbrace{${2:${VISUAL}}}_{$1} $0
endsnippet

# Limits, limsup(d), liminf(d), sum(d), series and sequences 
snippet prod "product" w
\prod_{${1:n=${2:1}}}^{${3:\infty}} ${4:${VISUAL}} $0
endsnippet

context "math()"
snippet `(?<!\\)(lim|sum|sup|inf)` "lim" riA
\\`!p snip.rv=match.group(1)`
endsnippet

# sup, inf are over set, to should be \in 
context "math()"
snippet `(lim|sup|inf)d` "lim and limsup" riA
`!p snip.rv=match.group(1)`_{$1 \\to $2}$0
endsnippet

context "math()"
snippet `(int|bigcap|bigcup|sum)d` "sum and int" riA
`!p snip.rv=match.group(1)`_{$1}^{$2}
endsnippet

context "math()"
snippet `(?<=\\lim)[ ]?(inf|sup)` "limsup&liminf" riA
`!p snip.rv=match.group(1)`
endsnippet

context "math()"
snippet `(int|\\lim|\\sum)([a-ce-zA-CE-Z])` "space after int" riA
`!p snip.rv=match.group(1)+" "+match.group(2)`
endsnippet

# infinity, positive, negative
snippet ooo "\infty" iA
\infty
endsnippet

context "math()"
snippet `\\inftyp` "+infty" riA
+\\infty
endsnippet

context "math()"
snippet `\\inftyn` "-infty" riA
-\\infty
endsnippet

snippet rij "mrij" i
(${1:x}_${2:n})_{${3:$2}\\in${4:\\N}}$0
endsnippet

context "math()"
snippet EE "exists" iA
\exists 
endsnippet

context "math()"
snippet AA "forall" iA
\forall 
endsnippet

snippet lll "l" iA
\ell
endsnippet

context "math()"
snippet norm "norm" iA
\|$1\|$0
endsnippet

priority 100
context "math()"
snippet '(?<!\\)(sin|cos|arccot|cot|csc|ln|log|exp|star|perp)' "ln" rwA
\\`!p snip.rv = match.group(1)`
endsnippet

priority 300
context "math()"
snippet dint "integral" wA
\int_{${1:-\infty}}^{${2:\infty}} ${3:${VISUAL}} $0
endsnippet

priority 200
context "math()"
snippet '(?<!\\)(arcsin|arccos|arctan|arccot|arccsc|arcsec|pi|zeta|int)' "ln" rwA
\\`!p snip.rv = match.group(1)`
endsnippet


priority 100
context "math()"
snippet too "to" iA
\to 
endsnippet

context "math()"
snippet mto "mapsto" iA
\mapsto 
endsnippet

context "math()"
snippet inv "inverse" iA
^{-1}
endsnippet

context "math()"
snippet compl "complement" iA
^{c}
endsnippet

context "math()"
snippet set "set" wA
\\{$1\\} $0
endsnippet


context "math()"
snippet ceq; "subset" A
\subseteq 
endsnippet

context "math()"
snippet cc; "subset" A
\subset 
endsnippet

snippet nin "not in " iA
\not\in 
endsnippet

context "math()"
snippet iin "in " iA
\in 
endsnippet

# mathbb symbols
snippet NN "n" iA
\N
endsnippet

snippet RR "real" iA
\R
endsnippet

snippet QQ "Q" iA
\Q
endsnippet

snippet ZZ "Z" iA
\Z
endsnippet

snippet HH "H" iA
\mathbb{H}
endsnippet

snippet DD "D" iA
\mathbb{D}
endsnippet

# Arrows 
priority 10
context "math()"
snippet `(r|R|l|L|lr|Lr|u|U|d|D|ud|Ud|rr|ll|RR|LL|se|sw|ne|nw)a;` "arrows" riA
`!p snip.rv="\\"+arrow[match.group(1)]+"arrow ";`
endsnippet

context "math()"
snippet `to` "to" riA
`!p snip.rv='\\to '`
endsnippet

snippet 00 "emptyset" wA
\O
endsnippet

context "math()"
snippet '(?<!i)sts' "text subscript" irA
_\text{$1} $0
endsnippet

context "math()"
snippet tt "text" iA
\text{$1}$0
endsnippet

context "math()"
snippet case "cases" wA
\begin{cases}
	$1
\end{cases}
endsnippet

snippet bigfun "Big function" iA
\begin{align*}
	$1: $2 &\longrightarrow $3 \\\\
	$4 &\longmapsto $1($4) = $0
.\end{align*}
endsnippet

# Optimization 
priority 1
context "math()"
snippet `((arg)?(max|min))` "max" riA
\\`!p snip.rv=match.group(1)`
endsnippet

priority 2
snippet `\\((arg)?(max|min))d` "maxd" riA
\\`!p snip.rv=match.group(1)`_{$1}$0
endsnippet


# iterates & functions
context "math()"
snippet `([x-zuvf-hF-H]{1})([i-k\d])`  "xk" riA
`!p snip.rv=match.group(1)+"_"+match.group(2)`
endsnippet

priority 1000
context "math()"
snippet `([x-zuvf-hF-H]{1})_([i-k])(\d)`  "xk" riA
`!p snip.rv=match.group(1)+"_{"+match.group(2)+"+"+match.group(3) +"}"`
endsnippet

context "math()"
snippet xo "(x)" iA
(${1:x})
endsnippet

context "math()"
snippet tr "transpose" iA
^T
endsnippet

context "math()"
snippet st "fstar" iA
^*
endsnippet

context "math()"
snippet defas "defined as" iA 
\\triangleq
endsnippet

# calligraphic 
context "math()"
snippet mcal "mathcal" iA
\mathcal{$1}$0
endsnippet


#### Binary Operation & Relation Symbols
#
# === ⇨ \equiv  ║     ≡
# sim ⇨ \sim    ║     ~
# cap ⇨ \cap    ║     ∩
# cup ⇨ \cup    ║     ∪
# in ⇨ \in      ║     ∈
# xx ⇨ \times   ║     ×
# opo ⇨ \oplus  ║     ⊕
# oxo ⇨ \otimes ║     ⊗
# omo ⇨ \ominus ║     ⊖
# oco ⇨ \propto ║     ∝

context "math()"
snippet eqv "xlongequal" iA
\\equiv
endsnippet

priority 1000
context "math()"
snippet `(?!\\)(sim|cap|cup|ni|perp|approx|leq|geq)` "exact ones" rwA
\\`!p snip.rv=match.group(1)`
endsnippet

context "math()"
snippet inn "in" iA
\\in
endsnippet

context "math()"
snippet xx "times" iA
\\times
endsnippet

context "math()"
snippet opo "oplus" iA
\\oplus
endsnippet

context "math()"
snippet omo "oplus" iA
\\ominus
endsnippet

context "math()"
snippet oxo "otimes" iA
\\otimes
endsnippet

context "math()"
snippet oco "oplus" iA
\\propto
endsnippet

context "math()"
snippet `lsm` "≲" riA
`!p snip.rv='\\lesssim '`
endsnippet

context "math()"
snippet `gsm` "≳" riA
`!p snip.rv='\\gtrsim '`
endsnippet

# derivatives 
context "math()"
snippet dev "derivative" iA
\\frac{\\mathrm{d}$1}{\\mathrm{d}$2}
endsnippet

context "math()"
snippet pde "partial derivative" iA
\\frac{\\partial $1}{\\partial $2}
endsnippet

priority 200
context "math()"
snippet `(\w)?drm` "dif" riA
`!p snip.rv=match.group(1)?(match.group(1)+" "):""`\\mathrm{\\,d}
endsnippet

context "math()"
snippet `part` "partial" riA
`!p snip.rv="\\partial "`
endsnippet

# snippet part "d/dx" w
# \frac{\partial ${1:V}}{\partial ${2:x}} $0
# endsnippet

snippet taylor "taylor" w
\sum_{${1:k}=${2:0}}^{${3:\infty}} ${4:c_$1} (x-a)^$1 $0
endsnippet

# Commonly used
context "math()"
snippet gra "nabla / gradient" iA
\\nabla
endsnippet

# vim:ft=snippets

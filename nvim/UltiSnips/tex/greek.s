global !p
def math():
	return vim.eval('vimtex#syntax#in_mathzone()') == '1'
greek  = {
     "a" : "\\alpha",
     "b" : "\\beta",
     "c" : "\\chi",
     "d" : "\\delta",
     "e" : "\\epsilon",
     "ve": "\\varepsilon",
     "f" : "\\phi",
     "vf": "\\varphi",
     "g" : "\\gamma",
     "h" : "\\eta",
     "i" : "\\iota",
     "j" : "\\varphi",
     "k" : "\\kappa",
     "vk": "\\varkappa",
     "l" : "\\lambda",
     "m" : "\\mu",
     "n" : "\\nu",
     "o" : "\\omega",
     "p" : "\\psi",
     "vp" : "\\varpi",
     "q" : "\\theta",
     "vq" : "\\vartheta",
     "r" : "\\rho",
     "s" : "\\sigma",
     "vs" : "\\varsigma",
     "t" : "\\tau",
     "u" : "\\upsilon",
     "v" : "\\varpi",
     "w" : "\\omicron",
     "x" : "\\xi",
     "z" : "\\zeta",
     "A" : "\\Alpha",
     "B" : "\\Beta",
     "C" : "\\Chi",
     "D" : "\\Delta",
     "E" : "\\Epsilon",
     "F" : "\\Phi",
     "G" : "\\Gamma",
     "H" : "\\Eta",
     "I" : "\\Iota",
     "K" : "\\Kappa",
     "L" : "\\Lambda",
     "M" : "\\Mu",
     "N" : "\\Nu",
     "O" : "\\Omega",
     "P" : "\\Psi",
     "Q" : "\\Theta",
     "R" : "\\Rho",
     "S" : "\\Sigma",
     "T" : "\\Tau",
     "U" : "\\Upsilon",
     "W" : "\\Omicron",
     "X" : "\\Xi",
     "Z" : "\\Zeta"
};

## prefix
prefix = {
    "bar" : ["\\overline{"             ,"}"   ],
    "fn"  : ["\\overset{\\frown}{"   ,"}"   ],
    "td"  : ["\\widetilde{"            ,"}"   ],
    "mrm" : ["\\mathrm{"               ,"}"   ],
    "hat" : ["\\hat{"                  ,"}"   ],
    "cr"  : ["\\mathscr{"              ,"}"   ],
    "bav" : ["\\hat{\\boldsymbol{"   ,"}}"  ],
    "vec" : ["\\vec{"                  ,"}"   ],
    "bm"  : ["\\boldsymbol{"           ,"}"   ],
    "bf"  : ["\\mathbf{"               ,"}"   ],
    "bb"  : ["\\mathbb{"               ,"}"   ],
    "cal" : ["\\mathcal{"              ,"}"   ],
    "dot"  : ["\\dot{"                  ,"}"   ],
    "vdot" : ["\\dot{\\boldsymbol{"   ,"}}"  ]
}
endglobal

# alpha|beta|chi|delta|epsilon|eta|gamma|iota|kappa|lambda|omega|omicron|phi|psi|rho|sigma|theta|tau|zeta
# (var|[abcdegikloprstz][a-z]+[ainou])
# mu|nu|pi|xi
# var(epsilon|phi|kappa|pi|theta|sigma)

context "math()"
snippet `(?<![a-zA-Z])([a-zA-IK-UW-Z]|v[efkpqs]);` "greek" riA
`!p snip.rv=greek[match.group(1)];`
endsnippet

# prefixes 
context "math()"
snippet `((?<![_\^])\d+|((?<![_\^])\d*)([A-Za-z]+|\\([A-Za-z]+)[ ]?))(?<!\\)(bar|fn|td|mrm|hat|cr|bav|vec|bm|bf|bb|cal|dot|vdt)` "prefix mode" riA
`!p
testPrefix = prefix[match.group(match.lastindex)];
snip.rv = testPrefix[0] + match.group(1) + testPrefix[1];
`
endsnippet


# priority 100
context "math()"
snippet `((?<![_\^])\d+|(?:(?<![_\^])\d*)(?:[A-Za-z]+|\\(?:[A-Za-z]+)[ ]?)[']*)(((\^|_)(\{\w+\}|\w))+)(?<!\\)(bar|fn|td|mrm|hat|cr|bav|vec|bm|bf|bb|cal|dot|vdt)` "prefix mode" riA
`!p
testPrefix = prefix[match.group(match.lastindex)];
snip.rv = testPrefix[0] + match.group(1) + testPrefix[1]+match.group(2);
`
endsnippet

# postfix ";"
# snippet ";dot" "Turn \dot into \ddot" r
# `!p snip.rv = match.group(1).replace(r"\dot{", r"\ddot{")`
# endsnippet
#


#vim:ft=snippets

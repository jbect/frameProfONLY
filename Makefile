# This Makefile shows how to generate both outputs
# programatically, without changing the source file.

LMK=latexmk -silent

CLEAR=latexmk -c $< && rm -f \
  example.dvi example.nav example.snm example.ps

OUT1=example-for-students.pdf
OUT2=example-prof-only.pdf

all: ${OUT1} ${OUT2}

${OUT1}: example.tex frameprofonly.tex
	${LMK} -pdfps $<
	mv example.pdf $@
	${CLEAR}

${OUT2}: example.tex frameprofonly.tex
	${LMK} -pdfps -latex='latex %O "\def\setPOtrue{}\input{%S}"' $<
	mv example.pdf $@
	${CLEAR}

clean:
	${LMK} -C example.tex
	rm -rf ${OUT1} ${OUT2}

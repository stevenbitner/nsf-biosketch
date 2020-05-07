PACKAGE=acmart
PDF = biosketch.pdf

all:  ${PDF}

%.pdf:  %.tex
	wget -O biosketch.bib https://dblp.org/pers/tb1/b/Bitner:Steven.bib
	pdflatex $< # Set up references
	- bibtex $* # Create compiled bibliography file (bbl)
	pdflatex $< # Link bbl to tex
	pdflatex $< # Update document references
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done # attempt to fix dynamic reference & margin issues, etc.

clean:
	$(RM)  *.log *.aux *.pdf \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi

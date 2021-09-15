#inspiration: https://github.com/eivindbergem/uio-master-thesis-latex-template/blob/master/Makefile
srcfile = main
pdf = $(srcfile).pdf
dir = src
bib = bibliography.bib

all: $(pdf)

$(pdf): $(dir)/$(srcfile).tex $(dir)/$(bib)
	cd $(dir) && latexmk -pdf -use-make $(srcfile).tex && mv $(pdf) ..

clean:
	rm $(pdf) && cd $(dir) && latexmk -CA  && rm $(srcfile).bbl $(srcfile).run.xml
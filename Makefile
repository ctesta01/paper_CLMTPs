MAIN = paper
SUPP = sm
RESP = response

all : doc sm docmin clean

doc :
	pdflatex $(MAIN).tex
	bibtex $(MAIN)
	pdflatex $(MAIN).tex
	pdflatex $(MAIN).tex

sm :
	pdflatex $(SUPP).tex
	bibtex $(SUPP)
	pdflatex $(SUPP).tex
	pdflatex $(SUPP).tex

resp:
	pdflatex $(RESP).tex
	bibtex $(RESP)
	pdflatex $(RESP).tex
	pdflatex $(RESP).tex

docmin :
	pdflatex $(MAIN).tex

arxiv:
	# Apparently, .aux files need to be preserved for cross-referencing BUT the
	# arXiv TeX engine automatically deletes any .aux files for which there are
	# corresponding PDFs. To work around this, both .tex and .bbl files need to
	# be renamed. After making the zip archive, we just restore original names.
	rm -f $(MAIN).pdf $(SUPP).pdf
	mv $(MAIN).tex $(MAIN)_arxiv.tex
	mv $(SUPP).tex $(SUPP)_arxiv.tex
	mv $(MAIN).bbl $(MAIN)_arxiv.bbl
	mv $(SUPP).bbl $(SUPP)_arxiv.bbl
	zip -r arxiv_submission.zip *
	mv $(MAIN)_arxiv.tex $(MAIN).tex
	mv $(SUPP)_arxiv.tex $(SUPP).tex
	mv $(MAIN)_arxiv.bbl $(MAIN).bbl
	mv $(SUPP)_arxiv.bbl $(SUPP).bbl

clean :
	rm -f $(addprefix $(MAIN),.aux .bbl .blg .fff .log .mw .out .thm)
	rm -f $(addprefix $(SUPP),.aux .bbl .blg .fff .log .mw .out .thm)
	rm -f $(addprefix $(RESP),.aux .blg .fff .log .mw .out)
	rm -f $(addprefix _preamble,.aux .blg .fff .log .mw .out)

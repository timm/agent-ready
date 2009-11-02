Src=paper1

all : dirs tex bib tex tex done

one : dirs tex done 

done :
	grep arning $(HOME)/tmp/${Src}.log
	@printf "\n\n\n==============================================\n"
	@printf       "see output in $(HOME)/tmp/$(Src).pdf\n"
	@printf       "==============================================\n\n\n"
	@printf "\n\nWarnings (may be none):\n\n"
	cp $(HOME)/tmp/${Src}.pdf ./

dirs : 
	- [ ! -d $(HOME)/tmp ] && mkdir $(HOME)/tmp

tex :
	- pdflatex -output-directory=$(HOME)/tmp $(Src)
	
bib : 
	- bibtex $(HOME)/tmp/$(Src)


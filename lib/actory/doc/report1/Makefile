Src=paperv1
Done=promise13-menzies

all : dirs tex bib  tex tex done

one : dirs tex done 

done :
	@printf "\n\n\n==============================================\n"
	@printf       "see output in $(HOME)/tmp/$(Src).pdf\n"
	@printf       "==============================================\n\n\n"
	@printf "\n\nWarnings (may be none):\n\n"
	grep arning $(HOME)/tmp/${Src}.log

dirs : 
	- [ ! -d $(HOME)/tmp ] && mkdir $(HOME)/tmp

tex :
	- pdflatex -output-directory=$(HOME)/tmp $(Src)
	
bib : 
	- bibtex $(HOME)/tmp/$(Src)

sheridan :
	make 
	- mkdir /tmp/sheridan
	- rm -rf /tmp/sheridan/*
	cp -r *  /tmp/sheridan
	cp $(HOME)/tmp/$(Src).pdf /tmp/sheridan/$(Done).pdf
	cd /tmp/sheridan && rm -rf .svn */.svn
	cd /tmp/sheridan && mv $(Src).tex $(Done).tex
	cd /tmp/sheridan && zip -r $(Done).zip *

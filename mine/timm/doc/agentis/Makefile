Src=agentis

all : tex bib tex tex $(Src).pdf
	
$(Src).pdf : $(Src).ps  
	pstopdf $(Src).ps

$(Src).ps  : $(Src).dvi 
	dvips $(Src).dvi -o $@

$(Src).dvi : $(Src).tex 
	latex $(Src)

tex : 
	latex $(Src)

bib :
	bibtex $(Src)

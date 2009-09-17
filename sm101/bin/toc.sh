cd wiki
All=`ls *.wiki`
cat All | gawk '	  { Let=substr($1,1,2)
                 	 	if(Let != Old)  {
							dump(Let)
							Keep = ""
							Sep = ""
				 	 	} 
				 		Keep = Sep $1
				 		Sep  = ", "
				 		Old=Let
                      }
                 END  { if (Keep) dump(Let) }
                 function dump(l) {
					print "== " l " ==="
					print " * " Keep
				}'

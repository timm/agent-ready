BEGIN {
	srand();
	coolFactor = -10;
	kmax = 10000;
	MATS = 5;
	Circuit[0,0] = "";
	OUTNUM = 1;
	OUTS[0,0] = 0;
	INNUM = 1;
	INS[0] = 0;
	GATES["AND"] = 0;
	GATES["OR"] = 0;
	GATES["XOR"] = 0;
	GATES["WIRE"] = 0;
	GATES["NAND"] = 0;
	GATES["NOR"] = 0;
	GATES["XNOR"] = 0;
	GATES["NOT"] = 0;
	GNAMES[0] = "";
	GCOUNT = 8;
	CopyNames();
	TT[0,0] = 0;
	EMAX = 0;
	#CircuitCache[0] = 0;
}

{
	for(i=1; i<=NF; i++) TT[(NR-1),(i-1)] = $i;
	OUTNUM = NR;
}

END {
	INNUM = InputNum();	
	if (OUTNUM > MATS) MATS = int (OUTNUM * 1.5);
	print "The number of inputs: " INNUM;
	print "The number of outputs: " OUTNUM;
	
	EMAX = OUTNUM * (NF + MATS);
	
	print "The required truth table is:";
	for(j=0; j<OUTNUM; j++) {
		printf ("Output " j ": "); 
		for(i=0; i<NF; i++) printf (TT[j,i]); \
		print "";
	}
	
	print "";
	
	CircuitRand();
	print "The following is the initial circuit martix";
	CircuitMatPrint(Circuit);
	
	print "";
	
	print "The following are the initial output functions";
	CircuitExpPrint(Circuit);
	
	print ""
	
	print "The initial fitness is: " E(Circuit);
	
	CircuitOptimizer(); 
	
	print "";
	
	print "The following is the final circuit martix";
	CircuitMatPrint(Circuit);
	
	print "";
	
	print "The following are the final output functions";
	CircuitExpPrint(Circuit);
	
	print ""
	
	print "The final fitness is: " E(Circuit);
	print "The final gate count is: " TotalGateCount(Circuit);
	
	#neighbour(Circuit);
	#print "\n";
	#CircuitMatPrint(Circuit);
	
	#for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]); print "";}
	
	#print TotalGateCount(Circuit);
	#print TotalWireCount(Circuit);
	
	#CircuitExpPrint(Circuit);
	
	#print E(Circuit);
	
	Evaluate(Circuit);
	for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (TT[(j-1),(i-1)]); print "";}
	print "";
	for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]); print "";}
	
	for (j=0; j<NF; j++) {
		Get01Input(j);
		printf(j " " );
		for (i=NF-1; i>=0; i--) printf(INS[i]);
		
		printf(" " OR(INS));
		print "";
	}
	#o[0] = 0;
	#o[1] = 2;
	
	#print GateCount(o);
	#print WireCount(o);
	
	#print In2Layer(13) " " In2Row(13) " " Coor2In(In2Layer(13), In2Row(13));
	
	#for (i in INS) print i ": " INS[i];
	#print EVAL(MATS-1, 0);
	
	#loop=10000;
	
	#while (loop>0) {
	#	CircuitRand(); 
	#	Evaluate();
	#	#print 
	#	loop--;
	#}	
}





#############################################
#Logic functions
###############################################
function AND(input	,buff2, i) {
	buff2 = input[0];
	for (i=1; i<INNUM; i++) buff2 = ((buff2 == 0 || input[i] == 0)? 0 : 1);
	return buff2;
}
function OR(input	,buff2, i) {
	buff2 = input[0];
	for (i=1; i<INNUM; i++) buff2 = ((buff2 == 1 || input[i] == 1)? 1 : 0);
	return buff2;
}
function XOR(input	,buff2, i) {
	buff2 = input[0];
	for (i=1; i<INNUM; i++) {
		if ((buff2 == 1 && input[i] == 1) || (buff2 == 0 && input[i] == 0)) buff2 = 0;
		else buff2 = 1;
	}   
	return buff2;
}
function WIRE(input) {return input[0];}
function NAND(input) {return (AND(input) == 1? 0: 1);}
function NOR(input) {return (OR(input) == 1? 0: 1);}
function XNOR(input) {return (XOR(input) == 1? 0: 1);}
function NOT(input) {return (WIRE(input) == 1? 0: 1);}

###############################################
#Utility functions
###############################################
function Get01Input(innum,       t, retstr, i, retstrlen) { #Convert input number to binary input
        retstr = "";
        t=innum;
	while(t) {
                if ( t%2==0 ) retstr = "0" retstr;
                else retstr = "1" retstr;
                t = int(t/2);
        }
        retstrlen = length(retstr);
	for (i=0; i<INNUM; i++) INS[i] = (i >= retstrlen? 0 : substr(retstr, retstrlen-i, 1));
}

function CopyNames(	i, count) { #Copying Gate names to GNAMES array
	count = 0;
	for (i in GATES) GNAMES[count++] = i;
}

function InputNum( incount) {
	incount = log(NF)/log(2);
	if (incount > int(incount)) incount++;
	return incount;
}

function RandInt(min, max) {return int(rand()*(max-min) + min);} # Generating an integer between min (inclusive) and max (exclusive)

function Coor2In(layer, row) {return row + INNUM + layer*MATS;} # Convert matrix coordinates to input number

function In2Layer(innum) {return int((innum - INNUM)/MATS);} # Convert input number to layer

function In2Row(innum) {return (innum - INNUM)%MATS;} # Convert input number to row

###############################################
#Circuit utility functions
###############################################

function CircuitReset(	layer, row) {for (layer=0; layer<MATS; layer++) for (row=0; row<MATS; row++) Circuit[layer,row] = "";}

function CircuitCp(orig, copy	,i) {
	for (i in orig) copy[i] = orig[i];
}

function CircuitRand(	buff, randin, ginnum, tmpin, i, layer, row) {
	tmpin[0] = 0;
	CircuitReset();
	for (layer=0; layer<MATS; layer++) {
		for (row=0; row<MATS; row++) {
			if (rand() > 0.5 || layer == MATS-1) {
				buff = GNAMES[RandInt(0,GCOUNT)];
				if(buff == "WIRE" || buff == "NOT") ginnum = 1;
				else ginnum = RandInt(2,4); # Having either 2 or 3 inputs
				for(i in tmpin) delete tmpin[i];
				while(ginnum>0) {
					do {
						randin = RandInt(0, Coor2In(layer, 0));	
					} while((Circuit[In2Layer(randin),In2Row(randin)] == "" && randin >= INNUM) || tmpin[randin] == 1);
					tmpin[randin] = 1;
					ginnum--;
				}
				for (i in tmpin) {buff = buff "," i; delete tmpin[i];}
				Circuit[layer, row] = buff;				
			}
			if (layer == MATS-1 && row == OUTNUM-1) return;
		}
	}
}

function CircuitMatPrint(c,  layer, row) {
	for (row=0; row<MATS; row++) {
		for (layer=0; layer<MATS; layer++) {
			printf(Coor2In(layer, row) ": " c[layer,row] "\t\t|");
		}
		print "";
	}
}

function CircuitExpPrint(c,	x) {
	for (x=0; x<OUTNUM; x++) print "Output " x ": " EXP(c, MATS-1, x);	
}

function EXP(c, layer, row	, express, temp, i) {
	express = "";
	split(c[layer, row], temp, ",");
	
	if (temp[1] == "WIRE") {
		if (temp[2] >= INNUM) return EXP(c, In2Layer(temp[2]), In2Row(temp[2]));
		else return temp[2];
	}
	
	express = temp[1] "(";
	for (i in temp) {
		if (i != 1) {
			if (temp[i] >= INNUM) express = express "" EXP(c, In2Layer(temp[i]), In2Row(temp[i])) ",";
			else express = express "" temp[i] ",";
		}
	}
	express = express "\b)";
	return express;
}

function GateCount(c, outputs,	outar, x, i, count) {
	count = 0;
	for (x in outputs) Gatelogger(c, outar, MATS-1, outputs[x]);
	for (i in outar) count++;
	return count;
}

function TotalGateCount(c	, outar, x, i, count) {
	count = 0;
	for (x=0; x<OUTNUM; x++) Gatelogger(c, outar, MATS-1, x);
	for (i in outar) count++;
	return count;
}

function Gatelogger(c, outar, layer, row	,temp, i) {
	if (index(c[layer, row], "WIRE") == 0) outar[Coor2In(layer, row)] = 1;
	split(c[layer, row], temp, ",");
	for (i in temp) if (i != 1 && temp[i] >= INNUM) Gatelogger(c, outar, In2Layer(temp[i]), In2Row(temp[i]));
}

function WireCount(c, outputs,	outar, x, i, count) {
	count = 0;
	for (x in outputs) Wirelogger(c, outar, MATS-1, outputs[x]);
	for (i in outar) count++;
	return count;
}

function TotalWireCount(c,	outar, x, i, count) {
	count = 0;
	for (x=0; x<OUTNUM; x++) Wirelogger(c, outar, MATS-1, x);
	for (i in outar) count++;
	return count;
}

function Wirelogger(c, outar, layer, row	,temp, i) {
	if (index(c[layer, row], "WIRE") != 0) outar[Coor2In(layer, row)] = 1;
	split(c[layer, row], temp, ",");
	for (i in temp) if (i != 1 && temp[i] >= INNUM) Wirelogger(c, outar, In2Layer(temp[i]), In2Row(temp[i]));
}

function Evaluate2(c	,i ,j) {
	#for (j in OUTS) delete OUTS[j];
	for (j=0; j<NF; j++) {
		Get01Input(j);
		
		printf( "INPUT: " );#######
		for (i=NF-1; i>=0; i--) printf(INS[i]); print "";############
		
		for (i=0; i<OUTNUM; i++) {
			print "EVAL " MATS-1 "," i;###########
			OUTS[i,j] = EVAL2(c, MATS-1, i);	
		}
	}
}

function EVAL2(c, layer, row	,temp, i, buff) {
	#for (i in buff) delete buff[i];
	split(c[layer, row], temp, ",");
	print "split " c[layer, row];##########
	for (i in temp) print i " " temp[i];#########
	for (i in temp) {
		if (i != 1 ) {
			if (temp[i] >= INNUM) {buff[i-2] = EVAL2(c, In2Layer(temp[i]), In2Row(temp[i])); print "input " i-2 " of " temp[i] " into " c[layer, row] " is " buff[i-2];}
			else {buff[i-2] = INS[temp[i]];  print "input " i-2 " of " temp[i] " into " c[layer, row] " is " buff[i-2];}
		}
	}
	if (temp[1] == "AND") {printf (temp[1] " in " layer ", " row " is " AND(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return AND(buff);}
	if (temp[1] == "OR") {printf (temp[1] " in " layer ", " row " is " OR(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return OR(buff);}
	if (temp[1] == "XOR") {printf (temp[1] " in " layer ", " row " is " XOR(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return XOR(buff);}
	if (temp[1] == "WIRE") {printf (temp[1] " in " layer ", " row " is " WIRE(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return WIRE(buff);}
	if (temp[1] == "NAND") {printf (temp[1] " in " layer ", " row " is " NAND(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return NAND(buff);}
	if (temp[1] == "NOR") {printf (temp[1] " in " layer ", " row " is " NOR(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return NOR(buff);}
	if (temp[1] == "XNOR") {printf (temp[1] " in " layer ", " row " is " XNOR(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return XNOR(buff);}
	if (temp[1] == "NOT") {printf (temp[1] " in " layer ", " row " is " NOT(buff) "=> " ); for(i in buff) printf(i " " buff[i] " "); print ""; return NOT(buff);}
}




function Evaluate(c	,i ,j) {
	#for (j in OUTS) delete OUTS[j];
	for (j=0; j<NF; j++) {
		Get01Input(j);
		for (i=0; i<OUTNUM; i++) OUTS[i,j] = EVAL(c, MATS-1, i);	
	}
}

function EVAL(c, layer, row	,temp, i, buff) {
	#for (i in buff) delete buff[i];
	split(c[layer, row], temp, ",");
	for (i in temp) {
		if (i != 1 ) {
			if (temp[i] >= INNUM) buff[i-2] = EVAL(c, In2Layer(temp[i]), In2Row(temp[i]));
			else buff[i-2] = INS[temp[i]];
		}
	}
	if (temp[1] == "AND") return AND(buff);
	if (temp[1] == "OR") return OR(buff);
	if (temp[1] == "XOR") return XOR(buff);
	if (temp[1] == "WIRE") return WIRE(buff);
	if (temp[1] == "NAND") return NAND(buff);
	if (temp[1] == "NOR") return NOR(buff);
	if (temp[1] == "XNOR") return XNOR(buff);
	if (temp[1] == "NOT") return NOT(buff);
}






#################################################
#Learning and Circuit manipulation functions
#################################################


function CircuitOptimizer(	c, cb, cn, e, eb, en, k) {
	CircuitCp(Circuit, c); e = E(c);           # Initial state, energy.
	CircuitCp(c, cb); eb = e;             # Initial "best" solution
	k = 0;                       # Energy evaluation count.
	while (k < kmax) { # Loop
		CircuitCp(c, cn);
		neighbour(cn);         #   Pick some neighbour.
		en = E(cn);               #   Compute its energy.
		if (en > eb) {         #   Is this a new best?
			CircuitCp(cn, cb); eb = en;      #     Yes, save it.
		}
		else if (rand() < P(e, en, Temperature(k))) { #     Maybe jump
			CircuitCp(cn, c); e = en;     
		}
		k = k + 1;              #   One more evaluation done
	}
	CircuitCp(cb, Circuit);                  # Return best
}

function P(e, en, temp	,buff, p) {
	buff = (e-en)/temp;
	p = (buff<(-300)? exp(-300): exp(buff));
	return p;
}

function Temperature(k) {
	return exp(coolFactor*k/kmax);
}

function E(c	, i, j, cocount, feasible) { # The fitness function
	Evaluate(c);
	cocount = 0;
	feasible = 1;
	for (i=0; i<OUTNUM; i++) {
		for(j=0; j<NF; j++) {
			if (OUTS[i,j] == TT[i,j]) cocount++; # print OUTS[i,j] " " TT[i,j] "=> " cocount;}
			else feasible = 0;
		}
	}	
	if (feasible == 1) { return (cocount + TotalWireCount(c)/TotalGateCount(c))/EMAX;} #print "GOT IT!!" (cocount + TotalWireCount(c)/TotalGateCount(c))/EMAX; 
	else return cocount/EMAX;
}


function neighbour(c,	buff, randin, ginnum, tmpin, i) {
	tmpin[0] = 0;
	for (layer=0; layer<MATS; layer++) {
		for (row=0; row<MATS; row++) {
			if (rand() > 0.33) {
				buff = GNAMES[RandInt(0,GCOUNT)];
				if(buff == "WIRE" || buff == "NOT") ginnum = 1;
				else ginnum = RandInt(2,4); # Having either 2 or 3 inputs
				for(i in tmpin) delete tmpin[i];
				while(ginnum>0) {
					do {
						randin = RandInt(0, Coor2In(layer, 0));	
					} while((c[In2Layer(randin),In2Row(randin)] == "" && randin >= INNUM) || tmpin[randin] == 1);
					tmpin[randin] = 1;
					ginnum--;
				}
				for (i in tmpin) {buff = buff "," i; delete tmpin[i];}
				c[layer, row] = buff;				
			}
			if (layer == MATS-1 && row == OUTNUM-1) return;
		}
	}
}


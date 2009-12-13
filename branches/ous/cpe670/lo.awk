BEGIN { # This part here sets up the initial program parameters
	srand(); #initializing the random function seed
	coolFactor = -10; #The cooling factor for the temperature function
	kmax = 500; #The number of iterations per run of the circuit optimizer
	MATS = 5; #The size of the circuit matrix
	Circuit[0,0] = ""; #The Circuit Matrix
	OUTNUM = 1; #The number of outputs
	OUTS[0,0] = 0; #The matrix to store the current circuit outputs
	INNUM = 1; #The number of inputs
	INS[0] = 0; #The input vector
	
	#Setting up arrays to store the number of each gate
	#**Has not been used to its full potential**
	GATES["AND"] = 0; 
	GATES["OR"] = 0;
	GATES["XOR"] = 0;
	GATES["WIRE"] = 0;
	GATES["NAND"] = 0;
	GATES["NOR"] = 0;
	GATES["XNOR"] = 0;
	GATES["NOT"] = 0;
	
	GNAMES[0] = ""; #The array to store the gate names
	GCOUNT = 8; #The number of gates available
	CopyNames(); #Copying the gates names over to the array
	TT[0,0] = 0; #The truth table matrix
	EMAX = 0; #This saves worst fitness reached
}

{
	for(i=1; i<=NF; i++) TT[(NR-1),(i-1)] = $i;
	OUTNUM = NR;
}

END {
	if (OUTNUM > MATS) MATS = int (OUTNUM * 1.5);
	INNUM = InputNum();
	print "The number of inputs: " INNUM;
	print "The number of outputs: " OUTNUM;
	
	EMAX = -1;
	
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
	
	CMatch = 0;
	
	while(CMatch == 0) {
	
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
	
		Evaluate(Circuit);
		CMatch = 1;
		for(j=0; j<OUTNUM; j++) for(i=0; i<NF; i++) if (TT[j,i] != OUTS[j,i]) CMatch = 0; 
		if (CMatch == 1) print "Its a match!!";
		else {
			print "Nope, let's try again...";
		}
		
		print "TT \t\t\t Out";
		for(j=1; j<=OUTNUM; j++) {
			for(i=1; i<=NF; i++) printf (TT[(j-1),(i-1)]);
			printf("\t");
			for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]);
			print "";
		}
	}
	
	#neighbour(Circuit);
	#print "\n";
	#CircuitMatPrint(Circuit);
	
	#for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]); print "";}
	
	#print TotalGateCount(Circuit);
	#print TotalWireCount(Circuit);
	
	#CircuitExpPrint(Circuit);
	
	#print E(Circuit);
	
#	Evaluate(Circuit);
#	for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (TT[(j-1),(i-1)]); print "";}
#	print "";
#	for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]); print "";}
#	

#	for (k=0; k<100; k++) {
#	Evaluate(Circuit);
#	for(j=1; j<=OUTNUM; j++) {for(i=1; i<=NF; i++) printf (OUTS[(j-1),(i-1)]); print "";}
#	}
#	for (j=0; j<NF; j++) {
#		Get01Input(j);
#		printf(j " " );
#		for (i=NF-1; i>=0; i--) printf(INS[i]);
#		
#		printf(" " OR(INS));
#		print "";
#	}
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
	
#	inp[0] = 0; inp[1] = 1; inp[2];
#	
#	print NAND(inp[0], inp[1], inp[2]);
}





#############################################
#Logic functions
###############################################
function AND(input1, input2, input3	,buff2) {
	buff2 = (input1 == 1 && input2 == 1? 1: 0);
	if (input3 != "") buff2 = (input3 == 1 && buff2 == 1? 1: 0);
	return buff2;
}
function OR(input1, input2, input3	,buff2) {
	buff2 = (input1 == 1 || input2 == 1? 1: 0);
	if (input3 != "") buff2 = (input3 == 1 || buff2 == 1? 1: 0);
	return buff2;
}
function XOR(input1, input2, input3	,buff2) {
	buff2 = (((input1 == 1 && input2 == 1) || (input1 == 0 && input2 == 0))? 0: 1);
	if (input3 != "") buff2 = (((buff2 == 1 && input3 == 1) || (buff2 == 0 && input3 == 0))? 0: 1);
	return buff2;
}
function WIRE(input1) {return input1;}
function NAND(input1, input2, input3) {return NOT(AND(input1, input2, input3));}
function NOR(input1, input2, input3) {return NOT(OR(input1, input2, input3));}
function XNOR(input1, input2, input3) {return NOT(XOR(input1, input2, input3));}
function NOT(input1) {return (input1 == 1? 0: 1);}

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
	return int(incount);
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

function GateCount(c, output,	outar, x, i, count) {
	count = 0;
	Gatelogger(c, outar, MATS-1, output);
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

function Evaluate(c	,i ,j) {
	for (j=0; j<NF; j++) {
		Get01Input(j);
		for (i=0; i<OUTNUM; i++) OUTS[i,j] = EVAL(c, MATS-1, i);	
	}
}

function EVAL(c, layer, row	,temp, i, buff, incount) {
	split(c[layer, row], temp, ",");
	incount=0;
	for (i in temp) {
		if (i != 1 ) {
			if (temp[i] >= INNUM) buff[incount] = EVAL(c, In2Layer(temp[i]), In2Row(temp[i]));
			else buff[incount] = INS[temp[i]];
			incount++;
		}
	}
	if (temp[1] == "AND") return AND(buff[0], buff[1], buff[2]);
	if (temp[1] == "OR") return OR(buff[0], buff[1], buff[2]);
	if (temp[1] == "XOR") return XOR(buff[0], buff[1], buff[2]);
	if (temp[1] == "WIRE") return WIRE(buff[0]);
	if (temp[1] == "NAND") return NAND(buff[0], buff[1], buff[2]);
	if (temp[1] == "NOR") return NOR(buff[0], buff[1], buff[2]);
	if (temp[1] == "XNOR") return XNOR(buff[0], buff[1], buff[2]);
	if (temp[1] == "NOT") return NOT(buff[0]);
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
		if (en < eb) {         #   Is this a new best?
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

function E(c	, i, j, iocount, feasible, ofeasible, enow) { # The fitness function
	Evaluate(c);
	enow = 0;
	feasible = 1;
	
	for (i=0; i<OUTNUM; i++) {
		ofeasible = 1;
		iocount = 0;
		for(j=0; j<NF; j++) {
			if(OUTS[i,j] != TT[i,j]) {
				iocount++;
				feasible = 0;
				ofeasible = 0;
			}
		}
		if (ofeasible == 1) { enow = enow + GateCount(c, i);}# print "Got Output " i;}
		else enow = enow + GateCount(c, i) + iocount * OUTNUM * NF;
	}
	
	if (feasible == 1) {enow = enow + TotalGateCount(c);}# print "GOT IT!!" enow;}
	else enow = enow + TotalGateCount(c) + OUTNUM * NF;
	if (enow > EMAX) {EMAX = enow; print "EMAX: " EMAX;}
	
	return enow/EMAX;
}


function neighbour(c,	buff, randin, ginnum, tmpin, i, layer, row) {
	tmpin[0] = 0;
	layer = RandInt(0, MATS);
#	for (layer=0; layer<MATS; layer++) 
	{
		for (row=0; row<MATS; row++) {
			if (rand() > 0.2) {
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


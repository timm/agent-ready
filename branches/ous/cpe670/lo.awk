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
}

{
	for(i=1; i<=NF; i++) TT[(NR-1),(i-1)] = $i;
	OUTNUM = NR;
}

END {
	INNUM = InputNum();
	
	if (OUTNUM > MATS) MATS = OUTNUM;
	#print OUTNUM;
	
	
	#for(j=1; j<=OUTNUM; j++) for(i=1; i<=NF; i++) print TT[(j-1),(i-1)];
	
	#Get01Input(5);
	
	
	
	#for (i=0; i<3; i++) print RandInt(0,7);
	
	
	#print In2Layer(5);
	#print In2Row(5);
	
	#CircuitRand();
	#CircuitMatPrint();
	
	#print TotalGateCount();
	#print TotalWireCount();
	
	#o[0] = 0;
	#o[1] = 2;
	
	#print GateCount(o);
	#print WireCount(o);
	
	#print In2Layer(13) " " In2Row(13) " " Coor2In(In2Layer(13), In2Row(13));
	
	#for (i in INS) print i ": " INS[i];
	#print EVAL(MATS-1, 0);
	
	loop=10000;
	
	while (loop>0) {
		CircuitRand(); 
		Evaluate();
		#print 
		loop--;
	}
	
}





#############################################
#Logic functions
###############################################
function AND(input	,buff) {
	buff = input[0];
	for (i=1; i<INNUM; i++) buff = buff && input[i];
	return buff;
}
function OR(input	,buff) {
	buff = input[0];
	for (i=1; i<INNUM; i++) buff = buff || input[i];
	return buff;
}
function XOR(input	,buff) {
	buff = input[0];
	for (i=1; i<INNUM; i++) {
		if ((buff == 1 && input[i] == 1) || (buff == 0 && input[i] == 0)) buff = 0;
		else buff = 1;
	}   
	return buff;
}
function WIRE(input) {return input[0];}
function NAND(input) {return !AND(input);}
function NOR(input) {return !OR(input);}
function XNOR(input) {return !XOR(input);}
function NOT(input) {return !input[0];}

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

function CircuitCp(copy, orig	,layer, row) {
	for (layer=0; layer<MATS; layer++) for (row=0; row<MATS; row++) copy[layer,row] = orig[layer,row];
}

function CircuitRand(	buff, randin, ginnum, tmpin, i) {
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

function CircuitMatPrint( layer, row) {
	for (row=0; row<MATS; row++) {
		for (layer=0; layer<MATS; layer++) {
			printf(Coor2In(layer, row) ": " Circuit[layer,row] "\t\t|");
		}
		print "";
	}
}

function GateCount(outputs,	outar, x, i, count) {
	count = 0;
	for (x in outputs) Gatelogger(outar, MATS-1, outputs[x]);
	for (i in outar) count++;
	return count;
}

function TotalGateCount(	outar, x, i, count) {
	count = 0;
	for (x=0; x<OUTNUM; x++) Gatelogger(outar, MATS-1, x);
	for (i in outar) count++;
	return count;
}

function Gatelogger(outar, layer, row	,temp, i) {
	if (index(Circuit[layer, row], "WIRE") == 0) outar[Coor2In(layer, row)] = 1;
	split(Circuit[layer, row], temp, ",");
	for (i in temp) if (i != 1 && temp[i] >= INNUM) Gatelogger(outar, In2Layer(temp[i]), In2Row(temp[i]));
}

function WireCount(outputs,	outar, x, i, count) {
	count = 0;
	for (x in outputs) Wirelogger(outar, MATS-1, outputs[x]);
	for (i in outar) count++;
	return count;
}

function TotalWireCount(	outar, x, i, count) {
	count = 0;
	for (x=0; x<OUTNUM; x++) Wirelogger(outar, MATS-1, x);
	for (i in outar) count++;
	return count;
}

function Wirelogger(outar, layer, row	,temp, i) {
	if (index(Circuit[layer, row], "WIRE") != 0) outar[Coor2In(layer, row)] = 1;
	split(Circuit[layer, row], temp, ",");
	for (i in temp) if (i != 1 && temp[i] >= INNUM) Wirelogger(outar, In2Layer(temp[i]), In2Row(temp[i]));
}

function Evaluate() {
	for (j in OUTS) delete OUTS[j];
	for (j=0; j<NF; j++) {
		Get01Input(j);
		for (i=0; i<OUTNUM; i++) OUTS[i,j] = EVAL(MATS-1, i);	
	}
}

function EVAL(layer, row	,temp, i, buff) {
	split(Circuit[layer, row], temp, ",");
	for (i in temp) {
		if (i != 1 ) {
			if (temp[i] >= INNUM) buff[i-2] = EVAL(In2Layer(temp[i]), In2Row(temp[i]));
			else {buff[i-2] = INS[temp[i]];} # print temp[i] " " INS[temp[i]] " " Coor2In(layer, row);}
			#print i-2 ": " buff[i-2] "=> " Coor2In(layer, row);
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


function SA(	c, cb, e, eb, k) {
	CircuitCp(c, Circuit); e = E(s);           # Initial state, energy.
	CircuitCp(cb, c); eb = e;             # Initial "best" solution
	k = 0;                       # Energy evaluation count.
	while (k < kmax) { # Loop
		sn = neighbour(s);         #   Pick some neighbour.
		en = E(sn);               #   Compute its energy.
		if (en < eb) {         #   Is this a new best?
			sb = sn; eb = en;      #     Yes, save it.
		}
		if (random() < P(e, en, Temperature(k/kmax))) { #     Maybe jump
			s = sn; e = en;     
		}
		k = k + 1;              #   One more evaluation done
	}
	return sb;                   # Return best
}

function P(e, en, temp) {
	return exp((e-en)/temp);
}

function Temperature(k, kmax) {
	return exp(coolFactor*k/kmax);
}

function E(s) {}


function neighbor() {}


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
	CopyNames();
	TT[0,0] = 0;
}

{
	for(i=1; i<=NF; i++) TT[(NR-1),(i-1)] = $i;
	OUTNUM = NR;
}

END {
	INNUM = InputNum();
	print OUTNUM;
	
	
	#for(j=1; j<=OUTNUM; j++) for(i=1; i<=NF; i++) print TT[(j-1),(i-1)];
	
	#Get01Input(2);
	#for (i in INS) print INS[i];
	
	
	#for (i=0; i<3; i++) print RandInt(0,7);
	
	
	
	
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

function RandInt(min, max) {
	return int(rand()*(max-min) + min);
}

function CircuitReset() {
	for (layer=0; layer<MATS; layer++) for (row=0; row<MATS; row++) Circuit[layer,row] = "";
}

function CircuitCp(copy, orig) {
	for (layer=0; layer<MATS; layer++) for (row=0; row<MATS; row++) copy[layer,row] = orig[layer,row];
}

function CircuitRand(	temp) {
	for (layer=0; layer<MATS; layer++) {
		for (row=0; row<MATS; row++) {
			if (rand() > 0.5 || row == MATS-1) {
			
				#Circuit[layer,row] = 
				
			}
		}
	}
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


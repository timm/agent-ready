times="1 2 3 4 5 6 7 8 9 10"

for i in $times;
do
	make X=060factory1.st run >> eg/run_$i
done

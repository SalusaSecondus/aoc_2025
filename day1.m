day1(filename)
	new lines,x,dir,amt,pos
	d ^readlines(filename,.lines)
	new zeroCount
	set zeroCount=0
	set x=""
	set pos=50
	for  set x=$order(lines(x)) quit:x=""  do
	. set dir=$extract(lines(x),1)
	. set amt=$extract(lines(x),2,99)
	. set amt=amt#100
	. if dir="L" set pos=pos-amt#100
	. else  set pos=pos+amt#100
	. set:pos=0 zeroCount=zeroCount+1
	write "Day1:  ",zeroCount,!
	quit
	;
part2(filename)
	new lines,x,dir,amt,pos,oldpos
	d ^readlines(filename,.lines)
	new zeroCount
	set zeroCount=0
	set x=""
	set pos=50
	for  set x=$order(lines(x)) quit:x=""  do
	. set dir=$extract(lines(x),1)
	. set amt=$extract(lines(x),2,99)
	. set zeroCount=zeroCount+(amt\100)
	. set amt=amt#100
	. set oldpos=pos
	. if dir="L" set pos=pos-amt
	. else  set pos=pos+amt
	. set:((pos=0)!(pos>99)!((oldpos>0)&(pos<0))) zeroCount=zeroCount+1
	. set pos=pos#100
	; . write lines(x)," -> ",pos," (",zeroCount,")",!
	write "Day1:  ",zeroCount,!
	quit
	;
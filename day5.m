day5(lines)
	n ranges,ingredients,cnt,idx s cnt=0,idx=""
	d parse(.lines,.ranges,.ingredients)
	for  s idx=$o(ingredients(idx)) q:idx=""  s cnt=cnt+$$inRange(.ranges,ingredients(idx))
	w "Day 5.1: ",cnt,!
	q
part2(lines)
	n ranges,ingredients,cnt,idx s cnt=0,idx=""
	d parse(.lines,.ranges,.ingredients)
	f  s idx=$o(ranges(idx))  q:idx=""  s cnt=cnt+ranges(idx)+1-idx
	w "Day 5.2: ",cnt,!
	q
parse(lines,ranges,ingredients)
	n idx,min,max,tmp s idx=""
	k ranges,ingredients
	f  s idx=$o(lines(idx)) q:lines(idx)=""  do
	. s min=$p(lines(idx),"-",1),max=$p(lines(idx),"-",2)
	. s tmp(min)=$$^max($g(tmp(min),0),max)
	f  s idx=$o(lines(idx)) q:idx=""  d ^push(.ingredients,lines(idx))
	d merge(.tmp,.ranges)
	q
inRange(ranges,val)
	q:$g(ranges(val),0) 1
	q $g(ranges($o(ranges(val),-1)),0)>=val	
merge(ranges,output)
	n idx,min,max s idx="",min=0,max=0
	k output
	f  s idx=$o(ranges(idx)) q:idx=""  do
	. i (min=0)&(max=0) s min=idx,max=ranges(idx) q
	. i idx>max s output(min)=max,min=idx,max=ranges(idx) q
	. s max=$$^max(ranges(idx),max)
	s:max>0 output(min)=max
	q
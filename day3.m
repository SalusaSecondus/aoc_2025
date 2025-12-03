day3(lines,cnt)
	n sum,idx,start,first,second,len
	s sum=0,idx=""
	f  s idx=$order(lines(idx)) q:idx=""  do
	. s sum=sum+$$joltage(lines(idx),$get(cnt,2))
	write "Day 3:  ",sum,!
	q
joltage(bank,cnt)
	n idx,res,start,tmp,len
	s res="",start=0,len=$length(bank)
	for idx=cnt:-1:1 do
	. s tmp=$$rangeMax(bank,start+1,len+1-idx)
	. s res=res_$e(tmp),start=$e(tmp,2,len)
	w:^debug bank,"=>",res,!
	q res
rangeMax(bank,start,end)
	n res,resI,idx,tmp
	s res=0,resI=0
	for idx=start:1:end s tmp=$e(bank,idx) i tmp>res s res=tmp,resI=idx
	quit res_resI
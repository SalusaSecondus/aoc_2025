day6(lines)
	n nums,ops,col,op,sum,acc,row s col="",sum=0
	d ^aocTimer("START","Parse")
	d parse(.lines,.nums,.ops)
	d ^aocTimer("END","Parse")
	d ^aocTimer("START","Math")
	f  s col=$o(ops(col)) q:col=""  do
	. s op=ops(col),acc=$s(op="*":1,op="+":0),row=""
	. f  s row=$o(nums(col,row)) q:row=""  do
	. . i op="*" s acc=acc*nums(col,row)
	. . e  s acc=acc+nums(col,row)
	. s sum=sum+acc
	d ^aocTimer("END","Math")
	w "Day 6.1:  ",sum,!
	q
part2(lines)
	n nums,ops,col,op,sum,acc,row s col="",sum=0
	d ^aocTimer("START","Parse")
	d parse2(.lines,.nums,.ops)
	d ^aocTimer("END","Parse")
	d ^aocTimer("START","Math")
	f  s col=$o(ops(col)) q:col=""  do
	. s op=ops(col),acc=$s(op="*":1,op="+":0),row=""
	. f  s row=$o(nums(col,row)) q:row=""  do
	. . i op="*" s acc=acc*nums(col,row)
	. . e  s acc=acc+nums(col,row)
	. s sum=sum+acc
	d ^aocTimer("END","Math")
	w "Day 6.2:  ",sum,!
	q
parse(lines,nums,ops)
	n lIdx,cIdx,f,pIdx,tmp s lIdx="",f=0,cIdx=0
	kill nums,ops
	f  s lIdx=$o(lines(lIdx)) q:lIdx=""  s cIdx=0 for pIdx=1:1:$l(lines(lIdx)," ") d
	. s tmp=$p(lines(lIdx)," ",pIdx) q:tmp=""
	. s cIdx=cIdx+1
	. i tmp>0 s nums(cIdx,lIdx)=tmp
	. e  s ops(cIdx)=tmp
	q
parse2(lines,nums,ops)
	n lIdx,cIdx,f,pIdx,tmp,p s lIdx="",f=0
	kill nums,ops
	f  s lIdx=$o(lines(lIdx)) q:lIdx=""  s cIdx=0,p=" " for pIdx=1:1:$l(lines(lIdx)) d
	. s tmp=$e(lines(lIdx),pIdx)
	. s:(tmp'=" ")&(p=" ") cIdx=cIdx+1
	. w:^debug "tmp=",tmp," p=",p," cIdx=",cIdx,!
	. s p=tmp
	. q:tmp=" "
	. i tmp>0 s nums(cIdx,pIdx)=$g(nums(cIdx,pIdx),"")_tmp
	. e  s ops(cIdx)=tmp
	q
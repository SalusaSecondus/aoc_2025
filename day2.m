day2(lines,smoke)
	new ranges,validCount,r,idx
	; write "foo",!
	d splitRanges(lines(0),.ranges)
	; write "bar",!
	; zwrite
	set validSum=0,idx="",r=""
	for  set r=$order(ranges(r)) quit:r=""  for idx=ranges(r,0):1:ranges(r,1) set:$$invalidId(idx) validSum=validSum+idx
	write validSum,!
	quit
invalidId(id)
	quit:($length(id)#2)=1 0
	quit $extract(id,1,$length(id)\2)=$extract(id,($length(id)\2)+1,$length(id))
splitRanges(line,result)
	new idx
	; write "Split!",!
	for idx=1:1:$length(line,",") set result(idx,0)=$piece($piece(line,",",idx),"-",1),result(idx,1)=$piece($piece(line,",",idx),"-",2)
	quit
	;
part2(lines,smoke)
	new ranges,validCount,r,idx
	; write "foo",!
	d splitRanges(lines(0),.ranges)
	; write "bar",!
	; zwrite
	set validSum=0,idx="",r=""
	for  set r=$order(ranges(r)) quit:r=""  for idx=ranges(r,0):1:ranges(r,1) set:$$invalidId2(idx) validSum=validSum+idx
	write validSum,!
	quit
invalidId2(id)
	new subLen,idLen,idx,result,i1,i2
	set idLen=$length(id)
	set result=0
	for subLen=1:1:(idLen-1) quit:result  do
	. write:^debug "subLen=",subLen,!
	. set result=(idLen#subLen=0)
	. if result for idx=1:1:(idLen\subLen)-1 quit:'result  set i1=(idx*subLen)+1,i2=i1+subLen-1,result=result&($extract(id,1,subLen)=$extract(id,i1,i2)) write:^debug result,": ",$extract(id,1,subLen),"=",$extract(id,i1,i2),!
	quit result
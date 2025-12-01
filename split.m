split(line,sep,result,limit)
	new idx,midx,cnt
	set cnt=$length(line,sep)
	if limit set midx=$$^min(limit,cnt)
	else  set midx=cnt
	for idx=1:1:midx do
	. set result(idx)=$piece(line,sep,idx)
	. set:(idx=midx)&(midx<cnt) result(idx)=$piece(line,sep,idx,cnt)
	quit
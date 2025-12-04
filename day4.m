day4(lines)
	new data,idx,count,x,y,tmp,xoff,yoff
	d parse(.lines,.data)
	set idx="data",count=0
	for  set idx=$query(@idx) quit:idx=""  do
	. s x=$qsubscript(idx,1),y=$qsubscript(idx,2),tmp=0
	. for xoff=-1:1:1 for yoff=-1:1:1 do
	. . s:(xoff'=0)!(yoff'=0) tmp=$get(data(x+xoff,y+yoff),0)+tmp
	. s:tmp<4 count=count+1
	. w:(^debug)&(tmp<4) idx,"=",@idx,"->",tmp,!
	write "Day4: ",count,!
	quit
part2(lines)
	new data,idx,count,x,y,tmp,xoff,yoff,diff
	d parse(.lines,.data)
	set diff=1,count=0
	for  quit:diff=0  do
	. set idx="data",diff=0
	. for  set idx=$query(@idx) quit:idx=""  do
	. . w:^debug "Loop",!
	. . s x=$qsubscript(idx,1),y=$qsubscript(idx,2),tmp=0
	. . for xoff=-1:1:1 for yoff=-1:1:1 do
	. . . s:(xoff'=0)!(yoff'=0) tmp=$get(data(x+xoff,y+yoff),0)+tmp
	. . s:tmp<4 diff=diff+1,count=count+1
	. . kill:tmp<4 @idx
	write "Day4: ",count,!
	quit
parse(lines,grid)
	new y,x
	set y=""
	for  set y=$order(lines(y)) quit:y=""  do
	. for x=1:1:$length(lines(y)) set:$extract(lines(y),x)="@" grid(x,y)="1"
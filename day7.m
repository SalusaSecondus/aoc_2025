day7(lines)
	n grid,source,splits,prev,curr,max,row s splits=0,max=$o(lines(""),-1)
	d parse(.lines,.grid,.source)
	s prev(source)=1
	f row=1:1:max d
	. n col s col=""
	. w:^debug $$toString(.prev),"->",$$sum(.prev),!
	. k curr
	. f  s col=$o(prev(col)) q:col=""  d
	. . n pathsToHere s pathsToHere=prev(col)
	. . i $g(grid(row,col),0) d
	. . . s splits=splits+1
	. . . s curr(col-1)=$g(curr(col-1),0)+pathsToHere
	. . . s curr(col+1)=$g(curr(col+1),0)+pathsToHere
	. . . w:^debug "(",row,",",col,")->",splits,!
	. . e  s curr(col)=$g(curr(col),0)+pathsToHere
	. . w:^debug "Curr: ",$$toString(.curr),"->",$$sum(.curr),!
	. k prev m prev=curr
	w $$^font("Day 7.1: ","BOLD"),splits,!
	s splits=0,row="" ; row is reused because its not needed anymore
	f  s row=$o(prev(row)) q:row=""  s splits=splits+prev(row)
	w $$^font("Day 7.2: ","BOLD"),splits,!
	q
parse(lines,grid,source)
	n idx,x,tmp s idx=""
	k grid,source
	f  s idx=$o(lines(idx)) q:idx=""  f x=1:1:$l(lines(idx)) s tmp=$e(lines(idx),x) s:tmp="S" source=x s:tmp="^" grid(idx,x)=1
	q
toString(arr)
	n idx,result s idx="",result="["
	for  s idx=$o(arr(idx)) q:idx=""  s result=result_idx_"="_arr(idx)_","
	q result_"]"
sum(arr)
	n idx,result s idx="",result=0
	for  s idx=$o(arr(idx)) q:idx=""  s result=result+arr(idx)
	q result
day10(lines,smoke)
	n input,graph,result,idx,tmp s result=0
	d parse(.lines,.input)
	s idx=""
	for  s idx=$o(input(idx)) q:idx=""  d
	. s tmp=$$shortestPath(.input,idx)
	. w:^debug idx,": ",input(idx),": ",tmp,!
	. s result=result+tmp
	w "Day 10.1: ",result,!
	q
part2(lines,smoke)
	n input,graph,result,idx,tmp s result=0
	d parse(.lines,.input)
	s idx=""
	for  s idx=$o(input(idx)) q:idx=""  d
	. s tmp=$$shortestJolt(.input,idx)
	. w idx,": ",input(idx,"joltage"),": ",tmp,!
	. s result=result+tmp
	w "Day 10.1: ",result,!
	q
parse(lines,result)
	n idx,len,lights,joltage s idx=""
	k result
	f  s idx=$o(lines(idx)) q:idx=""  d
	. s len=$l(lines(idx)," ")
	. s result(idx)=$p(lines(idx)," ",1)
	. s result(idx,"joltage")=$tr($p(lines(idx)," ",len),"{}")
	. f b=2:1:(len-1) s result(idx,"buttons",b-1)=$tr($p(lines(idx)," ",b),"()")
	q
freshLights(lights)
	q $tr(lights,"#",".")
applyButton(lights,button)
	n b
	f i=1:1:$l(button,",") d
	. s b=$p(button,",",i)+2
	. i $e(lights,b)="#" s $e(lights,b)="."
	. e  s $e(lights,b)="#"
	q lights
shortestPath(data,idx)
	n queue,curr,path,bIdx,button,next,result,visited,start,end,lights s result=""
	s end=data(idx),start=$$freshLights(end)
	d push^queue(.queue,"0|"_start)
	f  q:$$length^queue(.queue)=0  d
	. s curr=$$shift^queue(.queue)
	. ;w:^debug "Considering: ",curr,!
	. s path=$p(curr,"|"),lights=$p(curr,"|",2)
	. s bIdx=""
	. f  s bIdx=$o(data(idx,"buttons",bIdx)) q:bIdx=""  q:result'=""  d
	. . s button=data(idx,"buttons",bIdx)
	. . s next=$$applyButton(lights,button)
	. . i next=end s result=path+1 q
	. . d push^queue(.queue,(path+1)_"|"_next)
	q result
freshJolt(jolt)
	n idx
	f idx=1:1:$l(jolt,",") s $p(jolt,",",idx)=0
	q jolt
cmpJolt(a,b)
	n idx,result,j1,j2 s result=0
	f idx=1:1:$l(a,",") q:result>0  d
	. s j1=$p(a,",",idx),j2=$p(b,",",idx)
	. s:j1<j2 result=-1
	. s:j1>j2 result=1
	q result
applyJolt(jolt,button)
	n b i
	f i=1:1:$l(button,",") d
	. s b=$p(button,",",i)+1
	. s $p(jolt,",",b)=$p(jolt,",",b)+1
	q jolt
shortestJolt(data,idx)
	n queue,curr,path,bIdx,button,next,result,visited,start,end,cmp s result=""
	s end=data(idx,"joltage"),start=$$freshJolt(end)
	d push^queue(.queue,"0|"_start)
	f  q:$$length^queue(.queue)=0  d
	. s curr=$$shift^queue(.queue)
	. w:^debug "Considering(",idx,"): ",curr,"(",$$length^queue(.queue),")",!
	. s path=$p(curr,"|"),jolt=$p(curr,"|",2)
	. s bIdx=""
	. f  s bIdx=$o(data(idx,"buttons",bIdx)) q:bIdx=""  q:result'=""  d
	. . s button=data(idx,"buttons",bIdx)
	. . s next=$$applyJolt(jolt,button)
	. . q:$g(visited(next),0)  s visited(next)=1
	. . s cmp=$$cmpJolt(next,end)
	. . ;w:^debug "Button (",button,") -> {",next,"} ? ",cmp,!
	. . i cmp=0 s result=path+1 q
	. . i cmp<0 d push^queue(.queue,(path+1)_"|"_next)
	q result
day9(lines,smoke)
	n a,b,bestA,bestB,best,tmp s best=0,a="",b=""
	f  s a=$o(lines(a)) q:a=""  s b=a f  s b=$o(lines(b)) q:b=""  d
	. s tmp=$$area(lines(a),lines(b))
	. w:^debug lines(a),"-",lines(b),"=",tmp,!
	. q:tmp'>best
	. s best=tmp,bestA=(lines(a)),bestB=(lines(b))
	w bestA,"-",bestB,!
	w "Day 9.1: ",best,!
	q
part2(lines,smoke)
; Note that this won't handle directly adjacent nodes making a single side
	n edges,idx,rotation,tmp,d1,d2,verts,horizs s idx=""
	f  s idx=$o(lines(idx)) q:idx=""  d
	. s edges(lines(idx))=$g(lines(idx+1),lines(0))
	. s d2=$$dir(lines(idx),edges(lines(idx)))
	. i "LR"[d2 s horizs(lines(idx))=$g(lines(idx+1),lines(0))
	. e  s verts(lines(idx))=$g(lines(idx+1),lines(0))
	. i idx'=0 d
	. . s d1=$$dir(lines(idx-1),edges(lines(idx-1)))
	. . s tmp=$$turn(d1,d2)
	. . s rotation(tmp)=$g(rotation(tmp),0)+1
	; . w:^debug lines(idx),"->",edges(lines(idx)),": ",$$dir(lines(idx),edges(lines(idx))),!
	i rotation("R")>rotation("L") s rotation="R"
	e  s rotation="L"
	; zwrite edges
	; zwrite horizs
	; zwrite verts
	; q
	n a,b,bestA,bestB,best,tmp,tDir,bDir,lDir,rDir,ax,bx,ay,by s best=0,a="",b=""
	f  s a=$o(lines(a)) q:a=""  s b=a f  s b=$o(lines(b)) q:b=""  d
	. s tmp=$$area(lines(a),lines(b))
	. ;s ^debug=(4616852656=tmp)
	. q:tmp'>best
	. w:^debug !,lines(a),"-",lines(b),"=",tmp,!
	. s ax=$p(lines(a),","),ay=$p(lines(a),",",2)
	. s bx=$p(lines(b),","),by=$p(lines(b),",",2)
	. q:'$$isInside(ax,by,.edges)
	. q:'$$isInside(bx,ay,.edges)
	. ;q:$$crossesVert(ax,bx,ay,.verts,.edges)
	. ;q:$$crossesVert(ax,bx,by,.verts,.edges)
	. q:$$exitsVert(ax,bx,ay,.verts,.edges)
	. q:$$exitsVert(ax,bx,by,.verts,.edges)
	. q:$$exitsHoriz(ay,by,ax,.horizs,.edges)
	. q:$$exitsHoriz(ay,by,bx,.horizs,.edges)
	. ;s tDir=$$horizInBounds(ax,bx,$$^min(ay,by),.edges,rotation) q:tDir=0
	. ;s bDir=$$horizInBounds(ax,bx,$$^max(ay,by),.edges,rotation) q:bDir=0
	. ;s lDir=$$vertInBounds($$^min(ax,bx),ay,by,.edges,rotation) q:lDir=0
	. ;s lDir=$$vertInBounds($$^max(ax,bx),ay,by,.edges,rotation) q:lDir=0
	. s best=tmp,bestA=(lines(a)),bestB=(lines(b))
	. ;s ^debug=0
	w bestA,"-",bestB,!
	w "Day 9.2: ",best,!
	q
area(a,b)
	n xDiff,yDiff s xDiff=$p(a,",")-$p(b,","),yDiff=$p(a,",",2)-$p(b,",",2)
	s:xDiff<0 xDiff=-xDiff
	s:yDiff<0 yDiff=-yDiff
	q (xDiff+1)*(yDiff+1)
dir(a,b)
	n ax,ay,bx,by
	s ax=$p(a,","),ay=$p(a,",",2)
	s bx=$p(b,","),by=$p(b,",",2)
	q:(bx=ax)&(by>ay) "D"
	q:(bx=ax)&(by<ay) "U"
	q:(bx<ax)&(by=ay) "L"
	q:(bx>ax)&(by=ay) "R"
	halt
onHoriz(p,edges)
	n r,idx,d,px,py s r=0,idx="",px=$p(p,","),py=$p(p,",",2)
	for  s idx=$o(edges(idx)) q:(idx="")!((r'=0)&(r'=1))  d
	. s d=$$dir(idx,edges(idx))
	. i ("UD"[d)&(px=$p(idx,",")) d
	. . i (py'<$$^min($p(idx,",",2),$p(edges(idx),",",2)))&(py'>$$^max($p(idx,",",2),$p(edges(idx),",",2))) s r=1
	. if ("LR"[d)&(py=$p(idx,",",2)) d
	. . i (px'<$$^min($p(idx,","),$p(edges(idx),",")))&(px'>$$^max($p(idx,","),$p(edges(idx),","))) s r=d
	q r
onVert(p,edges)
	n r,idx,d,px,py s r=0,idx="",px=$p(p,","),py=$p(p,",",2)
	for  s idx=$o(edges(idx)) q:(idx="")!((r'=0)&(r'=1))  d
	. s d=$$dir(idx,edges(idx))
	. if ("LR"[d)&(py=$p(idx,",",2)) d
	. . i (px'<$$^min($p(idx,","),$p(edges(idx),",")))&(px'>$$^max($p(idx,","),$p(edges(idx),","))) s r=1
	. i ("UD"[d)&(px=$p(idx,",")) d
	. . i (py'<$$^min($p(idx,",",2),$p(edges(idx),",",2)))&(py'>$$^max($p(idx,",",2),$p(edges(idx),",",2))) s r=d
	q r
horizInBounds(ax,bx,y,edges,rot)
	; Doesn't handle adjacent lines
	n x,s,d,r,end s s=-1,r=$$onVert($$^min(ax,bx)_","_y,.edges),end=$$^max(ax,bx)
	f x=$$^min(ax,bx):1:end q:r="0"  d
	. s d=$$onVert(x_","_y,.edges)
	. ;w:^debug "x=",x," d=",d," s=",s," rot=",rot,!
	. i s=-1 s s=d q ; Initial
	. q:d=1 ; I'm on an edge
	. i d=0 d
	. . i (s="U")&(rot="L") s r=0 q
	. . i (s="D")&(rot="R") s r=0 q
	. q:d=0 ; I'm in the middle
	. s s=d
	w:^debug "horizInBounds(",ax,",",bx,",",y,")=",r,!
	q r
vertInBounds(x,ay,by,edges,rot)
	; Doesn't handle adjacent lines
	n y,s,d,r,end s s=-1,r=$$onHoriz(x_","_$$^min(ay,by),.edges),end=$$^max(ay,by)
	s:r=0 r=1
	f y=$$^min(ay,by):1:end q:r="0"  d
	. s d=$$onHoriz(x_","_y,.edges)
	. ;w:^debug "y=",y," d=",d," s=",s," rot=",rot,!
	. i s=-1 s s=d q ; Initial
	. q:d=1 ; I'm on an edge
	. i d=0 d
	. . i (s="R")&(rot="L") s r=0 q
	. . i (s="L")&(rot="R") s r=0 q
	. q:d=0 ; I'm in the middle
	. s s=d
	w:^debug "vertInBounds(",x,",",ay,",",by,")=",r,!
	q r	
turn(dir1,dir2)
	q:(dir1="D")&(dir2="L") "R"
	q:(dir1="D")&(dir2="R") "L"
	q:(dir1="U")&(dir2="L") "L"
	q:(dir1="U")&(dir2="R") "R"
	q:(dir1="R")&(dir2="D") "R"
	q:(dir1="R")&(dir2="U") "L"
	q:(dir1="L")&(dir2="D") "L"
	q:(dir1="L")&(dir2="U") "R"
	halt
exitsVert(ax,bx,y,verts,edges)
	n minX,maxX,minY,maxY,lineX,p1,p2,r
	s minX=$$^min(ax,bx),maxX=$$^max(ax,bx),r=0,p1=""
	f  s p1=$o(verts(p1)) q:p1=""  s p2=verts(p1) d
	. s lineX=$p(p1,","),maxY=$$^max($p(p1,",",2),$p(p2,",",2)),minY=$$^min($p(p1,",",2),$p(p2,",",2))
	. q:(y>maxY)!(y<minY) ; Doesn't cross us at all
	. q:(minX>lineX)!(maxX<lineX) ; We don't reach it
	. ; We now know we cross it. The line is in, check to see if we touch a side that is out
	. i (minX<lineX)&('$$isInside(lineX-1,y,.edges)) s r=1 q
	. i (maxX>lineX)&('$$isInside(lineX+1,y,.edges)) s r=1 q
	q r
exitsHoriz(x,ay,by,horizs,edges)
	n minX,maxX,minY,maxY,lineY,p1,p2,r
	s minY=$$^min(ay,by),maxY=$$^max(ay,by),r=0,p1=""
	f  s p1=$o(horizs(p1)) q:p1=""  s p2=horizs(p1) d
	. s lineY=$p(p1,",",2),maxX=$$^max($p(p1,","),$p(p2,",")),minX=$$^min($p(p1,","),$p(p2,","))
	. q:(x>maxX)!(x<minX) ; Doesn't cross us at all
	. q:(minY>lineY)!(maxY<lineY) ; We don't reach it
	. ; We now know we cross it. The line is in, check to see if we touch a side that is out
	. i (minY<lineY)&('$$isInside(x,lineY-1,.edges)) s r=1 q
	. i (maxY>lineY)&('$$isInside(x,lineY+1,.edges)) s r=1 q
	q r
crossesVert(ax,bx,y,verts,edges)
	n p1,r,lineX,maxY,minY,minX,maxX,endCrossed,first,lineDir s p1="",r=0,endCrossed=0
	s minX=$$^min(ax,bx),maxX=$$^max(ax,bx)
	s first=$$onHoriz(minX_","_y,.edges)
	s:first=1 first=0
	f  s p1=$o(verts(p1)) q:(p1="")!r  s p2=verts(p1) d
	. s lineX=$p(p1,","),maxY=$$^max($p(p1,",",2),$p(p2,",",2)),minY=$$^min($p(p1,",",2),$p(p2,",",2)),lineDir=$$dir(p1,p2)
	. q:(y>maxY)!(y<minY) ; Doesn't cross us at all
	. q:minX>lineX
	. q:maxX<lineX
	. ; End points are okay if we cross the same one (top/top, or bottom/bottom) twice in a row
	. ;
	. i y=minY d
	. . i endCrossed=1 s r=1 q
	. . s endCrossed=$s(endCrossed=0:-1,endCrossed=-1:0)
	. i y=maxY d
	. . i endCrossed=-1 s r=1 q
	. . s endCrossed=$s(endCrossed=0:-1,endCrossed=-1:0)
	. s:(y>minY)&(y<maxY) r=1
	w:^debug "crossesVert(",ax,",",bx,",",y,")=",r,!
	q r
crossesHoriz(ay,by,x,horizs,edges)
	n p1,r,lineY,maxY,minY,minX,maxX s p1="",r=0
	s minY=$$^min(ay,by),maxY=$$^max(ay,by)
	f  s p1=$o(horizs(p1)) q:(p1="")!r  s p2=horizs(p1) d
	. s lineY=$p(p1,",",2),maxX=$$^max($p(p1,","),$p(p2,",")),minX=$$^min($p(p1,","),$p(p2,","))
	. ;w:^debug "? ",minY,",",maxY,",",x,!
	. ; We purposefully don't want to catch the end points
	. q:(x'<maxX)!(x'>minX)
	. i (minY'>lineY)&(maxY'<lineY) s r=1 q
	w:^debug "crossesHoriz(",ay,",",by,",",x,")=",r,!
	q r
isInside(x,y,edges)
	n idx,ax,bx,ay,by,d,r,lCount,tCount,minX,maxX,minY,maxY s idx="",r="",lCount=0,tCount=0
	f  s idx=$o(edges(idx)) q:(idx="")!(r'="")  d
	. s ax=$p(idx,","),ay=$p(idx,",",2),bx=$p(edges(idx),","),by=$p(edges(idx),",",2)
	. s minX=$$^min(ax,bx),maxX=$$^max(ax,bx),minY=$$^min(ay,by),maxY=$$^max(ay,by)
	. s d=$$dir(idx,edges(idx))
	. q:("LR"[d)&(ay>y)
	. q:("UD"[d)&(ax>x)
	. i ("LR"[d)&(x'<minX)&(x'>maxX) d
	. . i ay=y s r=1 q
	. . s:x'=minX tCount=tCount+1
	. i ("UD"[d)&(y'<minY)&(y'>maxY) d
	. . i ax=x s r=1 w:^debug "  ",idx,"-",edges(idx),! q
	. . s:y'=minY lCount=lCount+1
	w:^debug&r x,",",y," is on a line",!
	q:r 1
	w:^debug x,",",y," l:",lCount," t:",tCount,!
	q (lCount#2)&(tCount#2)
	;	
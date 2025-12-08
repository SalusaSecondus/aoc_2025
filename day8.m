day8(lines,smoke)
	n circuits,dists,a,b,c,cords,dist,idx s a="",b=""
	i smoke s cords=10
	e  s cords=1000
	f  s a=$o(lines(a)) q:a=""  s b=a f  s b=$o(lines(b)) q:b=""  d
	. s dist=$$distSqr(lines(a),lines(b))
	. w:^debug lines(a),"-",lines(b),"->",dist,!
	. i $d(dists(dist)) s idx=$q(dists(dist+1,0),-1)
	. e  s idx="dists("_dist_",0)"
	. w:^debug "  ",idx,!
	. s @idx=lines(a)_"-"_lines(b)
	s idx="dists"
	f  s idx=$q(@idx) q:(idx="")!(cords=0)  d
	. s dist=@idx,a=$p(dist,"-"),b=$p(dist,"-",2)
	. s a=$$circuit(a,.circuits),b=$$circuit(b,.circuits)
	. s circuits(b)=a
	. s cords=cords-1
	; Count up all of the junctions and circuits
	s idx="",b=0
	k a
	for  s idx=$o(lines(idx)) q:idx=""  d
	. s c=$$circuit(lines(idx),.circuits)
	. s a=$g(a(c),0)
	. s:a=0 b=b+1
	. s a(c)=a+1
	k c
	s idx=""
	for  s idx=$o(a(idx)) q:idx=""  s c(a(idx))=$g(c(a(idx)),0)+1
	zwrite c
	s b=1,cords=3
	s idx=""
	for  s idx=$o(c(idx),-1) q:(idx="")!(cords=0)  d
	. n idx2
	. for idx2=1:1:c(idx) q:cords=0  s b=b*idx,cords=cords-1
	w "Day 8.1: ",b,!
	;	
	q
part2(lines,smoke)
	n circuits,dists,a,b,ac,bc,bestA,bestB,dist,idx s a="",b=""
	f  s a=$o(lines(a)) q:a=""  s b=a f  s b=$o(lines(b)) q:b=""  d
	. s dist=$$distSqr(lines(a),lines(b))
	. w:^debug lines(a),"-",lines(b),"->",dist,!
	. i $d(dists(dist)) s idx=$q(dists(dist+1,0),-1)
	. e  s idx="dists("_dist_",0)"
	. w:^debug "  ",idx,!
	. s @idx=lines(a)_"-"_lines(b)
	s idx="dists"
	f  s idx=$q(@idx) q:(idx="")  d
	. s dist=@idx,a=$p(dist,"-"),b=$p(dist,"-",2)
	. s ac=$$circuit(a,.circuits),bc=$$circuit(b,.circuits)
	. q:ac=bc
	. s bestA=a,bestB=b
	. s circuits(bc)=ac
	w "Day 8.2: ",$p(bestA,",")*$p(bestB,","),!
	q
distSqr(a,b)
	n ax,ay,az,bx,by,bz,x2,y2,z2
	s ax=$p(a,","),ay=$p(a,",",2),az=$p(a,",",3)
	s bx=$p(b,","),by=$p(b,",",2),bz=$p(b,",",3)
	s x2=ax-bx,y2=ay-by,z2=az-bz
	s x2=x2*x2,y2=y2*y2,z2=z2*z2
	q x2+y2+z2
circuit(j,c)
	n r s r=$g(c(j),j)
	q:r=j r
	s r=$$circuit(r,.c)
	s c(j)=r
	q r
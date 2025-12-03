day3(d,c)
	n r,i,s,a,b,l
	s r=0,i=""
	f  s i=$o(d(i)) q:i=""  s r=r+$$j(d(i),$g(c,2))
	w "Day 3:  ",r,!
	q
j(b,c)
	n i,r,s,t,l
	s r="",s=0,l=$l(b)
	for i=c:-1:1 s t=$$m(b,s+1,l+1-i),r=r_$e(t),s=$e(t,2,l)
	q r
m(b,s,end)
	n r,x,i,t
	s r=0
	for i=s:1:end s t=$e(b,i) s:t>r r=t,x=i
	quit r_x
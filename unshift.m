unshift(stack,val)
	new idx
	set idx=$order(stack(""))
	write "idx=",idx,!
	if idx="" set idx="1"
	set idx=idx-1
	set stack(idx)=val
	quit
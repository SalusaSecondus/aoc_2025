push(stack,val)
	new idx
	set idx=$order(stack(""),-1)
	if idx="" set idx="-1"
	set idx=idx+1
	set stack(idx)=val
	quit
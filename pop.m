pop(stack)
	new idx,result
	set idx=$order(stack(""),-1)
	if idx="" quit ""
	set result=stack(idx)
	kill stack(idx)
	quit result
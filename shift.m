shift(stack)
	new idx,result
	set idx=$order(stack(""))
	if idx="" quit ""
	set result=stack(idx)
	kill stack(idx)
	quit result
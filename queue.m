pop(stack)
	new idx,result
	set idx=$order(stack(""),-1)
	if idx="" quit ""
	set result=stack(idx)
	kill stack(idx)
	quit result
push(stack,val)
	new idx
	set idx=$order(stack(""),-1)
	if idx="" set idx="-1"
	set idx=idx+1
	set stack(idx)=val
	quit
shift(stack)
	new idx,result
	set idx=$order(stack(""))
	if idx="" quit ""
	set result=stack(idx)
	kill stack(idx)
	quit result
unshift(stack,val)
	new idx
	set idx=$order(stack(""))
	write "idx=",idx,!
	if idx="" set idx="1"
	set idx=idx-1
	set stack(idx)=val
	quit
length(stack)
	q:$order(stack(""))="" 0
	q $order(stack(""),-1)+1-$order(stack(""))
	;
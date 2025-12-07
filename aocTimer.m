aocTimer(action,name)
	n time,seconds,disp s time=$zh,seconds=(86400*$p(time,",",1))+($p(time,",",2))+($p(time,",",3)/1000000)
	i action="START" s aocTimerData(name)=seconds q
	s seconds=seconds-aocTimerData(name)
	k aocTimerData(name)
	do
	. i seconds'<1 s disp=$fn(seconds,",",3)_" s" q
	. s disp=$fn(seconds*1000,",",3)_" ms"
	w $$^font(name,"BRIGHT_MAGENTA"),": ",disp,!
	q
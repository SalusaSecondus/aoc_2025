aoc(day,part,smoke)
	n data,fn,timeName s timeName="Day "_day
	s fn="zlink ""day"_day_""""
	x fn
	if smoke d ^readlines("smoke"_day_".txt",.data)
	else  d ^aocInput(day,.data)
	set fn="^day"_day_"(.data,smoke)"
	if part=2 set fn="part2"_fn,timeName="Day "_day_".2"
	e  s timeName="Day "_day_".1"
	d ^aocTimer("START",timeName)
	d @fn
	d ^aocTimer("QUIT",timeName)
	q
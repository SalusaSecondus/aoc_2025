aoc(day,part,smoke)
	n data,fn
	if smoke d ^readlines("smoke"_day_".txt",.data)
	else  d ^aocInput(day,.data)
	set fn="^day"_day_"(.data)"
	if part=2 set fn="part2"_fn
	d @fn
	q
aocInput(day,result)
	new cmd,p,linenumber
	if $data(^aocData(day)) merge result=^aocData(day) quit
	write "Loading data for day ",day,!
	set cmd="curl -A SalusaSecondus-MUMPS -HCookie:session="_^aocSession_" https://adventofcode.com/2025/day/"_day_"/input 2>/dev/null"
	set p="Curl"
	set linenumber="0"
	open p:(command=cmd:readonly)::"PIPE"
	use p:exception="goto EOF"
	for  read result(linenumber) set linenumber=linenumber+1
EOF;
	use $PRINCIPAL
	merge ^aocData(day)=result
	quit
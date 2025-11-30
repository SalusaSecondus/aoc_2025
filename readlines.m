readlines(fn,result)
	new linenumber
	set linenumber="0"
	open fn:(readonly:ichset="ASCII")
	use fn:exception="goto EOF"
	for  read result(linenumber) set linenumber=linenumber+1
EOF;
	use $PRINCIPAL
	close fn
	quit
	
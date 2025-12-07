font(str,a,b)
	n rst,v1,v2 s rst=$g(colorMap("RESET"),"")
	if rst="" do
	. n csi s csi=$char(27,91)
	. s colorMap("RESET")=csi_"m",colorMap("BOLD")=csi_"1m",colorMap("ITALIC")=csi_"3m",colorMap("UNDERLINE")=csi_"4m",colorMap("BLINK")=csi_"5m",colorMap("INVERT")=csi_"7m"
	. s colorMap("BLACK")=csi_"30m",colorMap("RED")=csi_"31m",colorMap("GREEN")=csi_"32m",colorMap("YELLOW")=csi_"33m",colorMap("BLUE")=csi_"34m",colorMap("MAGENTA")=csi_"35m",colorMap("CYAN")=csi_"36m",colorMap("WHITE")=csi_"37m"
	. s colorMap("BRIGHT_BLACK")=csi_"90m",colorMap("BRIGHT_RED")=csi_"91m",colorMap("BRIGHT_GREEN")=csi_"92m",colorMap("BRIGHT_YELLOW")=csi_"93m",colorMap("BRIGHT_BLUE")=csi_"94m",colorMap("BRIGHT_MAGENTA")=csi_"95m",colorMap("BRIGHT_CYAN")=csi_"96m",colorMap("BRIGHT_WHITE")=csi_"97m"
	. s colorMap("BG_BLACK")=csi_"40m",colorMap("BG_RED")=csi_"41m",colorMap("BG_GREEN")=csi_"42m",colorMap("BG_YELLOW")=csi_"43m",colorMap("BG_BLUE")=csi_"44m",colorMap("BG_MAGENTA")=csi_"45m",colorMap("BG_CYAN")=csi_"46m",colorMap("BG_WHITE")=csi_"47m"
	. s colorMap("BG_BRIGHT_BLACK")=csi_"100m",colorMap("BG_BRIGHT_RED")=csi_"101m",colorMap("BG_BRIGHT_GREEN")=csi_"102m",colorMap("BG_BRIGHT_YELLOW")=csi_"103m",colorMap("BG_BRIGHT_BLUE")=csi_"104m",colorMap("BG_BRIGHT_MAGENTA")=csi_"105m",colorMap("BG_BRIGHT_CYAN")=csi_"106m",colorMap("BG_BRIGHT_WHITE")=csi_"107m"
	. s rst=colorMap("RESET")
	s v1=$g(a,""),v2=$g(b,"")
	q:v1="" rst_str
	q:v2="" colorMap(v1)_str_rst
	q colorMap(v1)_colorMap(v2)_str_rst	
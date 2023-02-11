set ns [new simulater]
set nf [open p2.nam w]
$ns namtrace-all $nf
set nd [open p2.tr w]
$ns trace-all $nf

proc finish { } {
    global ns nf nd 
    $ns flush-trace
    close$nf
    close$nd
    exec nam p2.nam &
    exit 0
}

set n0[$ns node]
set n1[$ns node]
set n2[$ns node]
set n3[$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp1 $sink0

set telnet [new Application/Telnet]
$telnet attach-agent $tcp1

$ns at 0.5 "$ftp start"
$ns at 0.5 "$telnet start"
$ns at 24.5 "$ftp stop"
$ns at 24.5 "$telnet stop"
$ns at 25.0 "finish"
$ns run
set ns [new Simulator]
set nf [open p3.nam w]
$ns namtrace-all $nf
set nd [open p3.tr w]
$ns trace-all $nd

proc finish{ } {
    global ns nf nd
    $ns flush-trace
    close $nf
    close $nd
    exec nam p3.nam &
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set sink0 [new Agent/Null]
$ns attach-agent $n3 $sink0
$ns connect $udp0 $sink0

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.005
$cbr attach-agent $udp0

set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.5 "$cbr start"
$ns at 0.5 "$ftp start"
$ns at 10.5 "$cbr stop"
$ns at 10.5 "$ftp stop"
$ns at 12.0 "finish"
$ns run
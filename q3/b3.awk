BEGIN{
    tcpcount=0;
    udpcount=0;
}
{
    event=$5;
    if(event=="tcp"){tcpcount++;}
    else if (event=="cbr"){udpcount++}
}
END{
    printf("tcp = %d",tcpcount)
    printf("udp = %d",udpcount)
}
BEGIN{
    dcount=0;
    rcount=0;
}
{
    event=$1;
    if(event=="d"){
        dcount++;
    }
    else if(event=="r"){
        rcount++;
    }
}
END{
    printf("recieved = %d\n",rcount);
    printf("dropped = %d\n",dcount);
}
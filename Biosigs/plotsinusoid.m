function plotsinusoid(f,a,startT,endT,step)
    t = (startT:step:endT);
    signal = a*cos(2*pi()*f*t);
    plot(t,signal)
return

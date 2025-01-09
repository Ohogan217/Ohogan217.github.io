function plotsinusoid2(f,a,startT,endT,step)
    %plot a complex sinusoid of frequency, 'f' and amplitude, 'a', with 'startT' 
    %and 'endT' giving the bouns of the time and 'step' giving the step size 
    t = (startT:step:endT); % create array of timesf from start to end in the specified step size
    compx = a*exp(2*pi()*f*t*i); % create a complex number using the specified inputs
    Rex = real(compx);%get the real component of compx
    Imx = imag(compx);%get the imaginary component of compx
    Ax = (t*0)+a;% create an amplitude array that is the same size as t
    tiledlayout(2,1)% create a 2 graph tiled layout to plot the angle and x
    nexttile %go to the first tile
    plot(t,Rex, 'r--') % plot the real part of x in red dashed line
    hold on % keep the real part of x
    plot(t,Imx, 'b-.'); % plot the imaginart part of x in a blue dot and dashed line
    plot(t,Ax,'g-') % plot the amplitude of x
    xlabel('time') % label x axis as time
    ylabel('amplitude')% label y axis as amplitude
    ylim ([-a-1 a+1]) % add 1 to the y bounds, as to increase the amount of graph shown
    legend('Re(x)', 'Im(x)', 'Amp(x)')%add a legend
    title('PlotSinusoid2 - Amplitude')%add a title
    nexttile % next tile
    plot(t,(mod((360*f*t),360)))% Plot the angle vs time
    xlabel('time')%label x
    ylabel('Angle')%label y
    title('PlotSinusoid2 - Angle')% title
    
    return
end
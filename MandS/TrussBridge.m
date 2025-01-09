%constants
lengthm = 4.5;
lengthl = lengthm*sqrt(2);
beamwidth = .12;
bridgewidth = 4.5;
framestepsize = 1;
root2 = sqrt(2);

densityasphalt = 2322;
densityconcrete = 2500;
densitysteels275 = 7850;
Esteels275 = 210*10^9;
g = -9.81;

mlorryfr = 17.86;
mlorryback = 58.4;
dynloadinc = 0.46;
lorrywheelbase = 3.97;

bridgelength = lengthm*6;
beamarea = beamwidth^2;
mdeck = lengthm * bridgewidth *((densityconcrete * 0.175) + (densityasphalt*0.05));
dynmlorryfr = mlorryfr *(1+dynloadinc);
dynmlorryback = mlorryback * (1+dynloadinc);
mbarm = beamarea * lengthm *densitysteels275;
mbarl = mbarm*root2;

k = zeros(4,4);

knownforces = zeros(1, 24);

jointpos = [0,0; 1,0; 1,1; 2,1; 2,0; 3,0; 3,1; 4,1; 4,0; 5,0; 5,1; 6,0];
jointpos = jointpos*lengthm;
 
memberaxis = [1 2 5 6; 1 2 3 4; 3 4 5 6; 5 6 7 8; 5 6 9 10; 3 4 9 10; 7 8 9 10; 7 8 13 14; 9 10 13 14; 9 10 11 12; 11 12 13 14; 13 14 15 16; 11 12 15 16; 11 12 17 18; 15 16 17 18; 15 16 21 22; 17 18 21 22; 17 18 19 20; 19 20 21 22; 21 22 23 24; 19 20 23 24];

memberpos = [0 0 1 1; 0 0 1 0; 1 0 1 1; 1 1 2 1; 1 1 2 0; 1 0 2 0; 2 0 2 1; 2 1 3 1; 2 1 3 0; 2 0 3 0; 3 0 3 1; 3 1 4 1; 3 0 4 1; 3 0 4 0; 4 0 4 1; 4 1 5 1; 4 0 5 1; 4 0 5 0; 5 0 5 1; 5 1 6 0; 5 0 6 0]; 
memberpos = memberpos*lengthm;
n = 0;
fig = figure();
rgb = [0 0 0];
%calculate deflection and forces
for lorrybackloc = 1:framestepsize:2
    gsm = zeros(24, 24);
    n = n+1;
    
    %get angle matrix
    for beamnumber = 1:21
        dy = memberpos(beamnumber, 2) - memberpos(beamnumber, 4);
        dx = memberpos(beamnumber, 1) - memberpos(beamnumber, 3);
        length = sqrt(dy^2 +dx^2);
        angle = atan(dy/dx);
        c2 = (cos(angle))^2;
        s2 = (sin(angle))^2;
        cs = sin(angle)*cos(angle);
        csmatrix = [c2 cs -c2 -cs; cs s2 -cs -s2; -c2 -cs c2 cs; -cs -s2 cs s2];
        
        k = (beamarea*Esteels275/length)*csmatrix; 
        
        for xside = 1:4
            for yside = 1:4
            a = k(xside, yside);
            gsm(memberaxis(beamnumber,xside), memberaxis(beamnumber, yside)) = gsm(memberaxis(beamnumber,xside), memberaxis(beamnumber, yside))+a;
            end
        end
   
    end
    
   mknown = zeros(1,24);
   numberbarl = [1 0 2 1 1 2 0 1 1 1 0 1];
   numberbarm = [2 4 3 4 4 4 4 4 4 3 4 2]; 
   amountroad = [1/4 1/2 0 0 1/2 1/2 0 0 1/2 1/2 0 1/4];
   
   mjy = numberbarm*(mbarm)/2;
   mjy = mjy + numberbarl * (mbarl)/2;
   mjy = mjy + amountroad *mdeck;
   
  %lorry mass
   lorrybackjoints = lorrybackloc/lengthm;
   if lorrybackjoints <0
       return
   else
     lorrybackj1 = floor(lorrybackjoints);
     lorrybackj2 = ceil(lorrybackjoints);
     mlorrybackj1 = dynmlorryback * (lorrybackjoints - lorrybackj1);
     mlorrybackj2 = dynmlorryback * (lorrybackj2 - lorrybackjoints);
     mknown(lorrybackj1+1) = mlorrybackj1; 
     mknown(lorrybackj2+1) = mlorrybackj2; 
   end
   
   lorryfrontjoints = (lorrybackloc+lorrywheelbase)/lengthm;
   if lorryfrontjoints <0
       return
   else
     lorryfrontj1 = floor(lorryfrontjoints);
     lorryfrontj2 = ceil(lorryfrontjoints);
     mlorryfrontj1 = dynmlorryfr * (lorryfrontjoints - lorryfrontj1);
     mlorryfrontj2 = dynmlorryfr * (lorryfrontj2 - lorryfrontjoints);
     mknown(lorryfrontj1+1) = mlorryfrontj1; 
     mknown(lorryfrontj2+1) = mlorryfrontj2; 
   end
   
  %lorry mass
   for n = 2:2:24
       mknown(n) = mknown(n) + mjy(n/2);
   end
   
   fknown = mknown'*g;
   
   %also add van weight here
   gsmspec = zeros(24,24);
   gsmspec(:,1:21) = gsm(:,3:23);
   gsmspec(1,22) = 1;
   gsmspec(2,23) = 1;
   gsmspec(24,24) = 1;

   v = Gauss_Elimination_tp(gsmspec, fknown);
   
   rax = v(22);
   ray = v(23);
   rby = v(24);
   
   zero12 = zeros(12,1);
   one12  = ones(12,1)*lengthm;
   deflections = zeros(12,2);
   
   for n = 1:21
       if mod(n,2) <= 0.4
           deflections(n/2+1,2) = v(n);
       else
           deflections((n+1)/2+1,1) = v(n);
       end
   end
   
   jointpos = jointpos + deflections;
   
   jointpos0 = [jointpos zero12];
   jointpos1 = [jointpos one12];
   joints = [jointpos0;jointpos1];
   
   clf
   %fromt beams
   for n = 1:11
       pt1 = joints(n,:);
       pt2 = joints(n+1,:);
       Makebeam(pt1, pt2);  
   end
   skip2nodes = [1 2 4 6 9 10];
   for n = 1:6
       pt1 = joints(skip2nodes(n),:);
       pt2 = joints(skip2nodes(n)+2,:);
       Makebeam(pt1, pt2);
   end
    for n = 2:2:8
       pt1 = joints(n,:);
       pt2 = joints(n+3,:);
       Makebeam(pt1, pt2);
       
    end
    %back beams
    for n = 1:11
      pt1 = joints(n+12,:);
      pt2 = joints(n+13,:);
      Makebeam(pt1, pt2);  
    end
   for n = 1:6
       pt1 = joints(skip2nodes(n)+12,:);
       pt2 = joints(skip2nodes(n)+14,:);
       Makebeam(pt1, pt2);
       
   end
    for n = 2:2:8
       pt1 = joints(n+12,:);
       pt2 = joints(n+15,:);
       Makebeam(pt1, pt2);
      
    end
    
    %cross beams
   for n = 1:12
       pt1 = joints(n,:);
       pt2 = joints(n+12,:);
       Makebeam(pt1, pt2);
       
   end
   %road
   roadnodes = [1 2 5 9 12];
   for n = 1:4
       pt1 = joints(roadnodes(n),:);
       pt2 = joints(roadnodes(n)+12,:);
       pt4 = joints(roadnodes(n+1),:);
       pt3 = joints(roadnodes(n+1)+12,:);
       x = [pt1(1);pt2(1); pt3(1); pt4(1)];
       y = [pt1(2);pt2(2); pt3(2); pt4(2)];
       z = [pt1(3);pt2(3); pt3(3); pt4(3)];
       patch(x, y, z, 'k');
   end
   
   axis equal
   axis off
   shading interp
   light;

   
   lorry(lorrybackloc)
   movieframe(n) = getframe(fig, [10 10 520 400]);
end

writtenmovie = VideoWriter('Bridgeanimation', 'MPEG-4');

writtenmovie.FrameRate = 20;

open(writtenmovie);
writeVideo(movieframe, writtenmovie);
close(writtenmovie);

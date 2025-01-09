function Lorry(position)
    % Lorry(position):
    % Creat a basix, lowpoly 3d model of a lorry in 3d space, displaced a
    % certain distance on the x axis.
    % Input position = the distance that the lorry has been displaced on the
    % x axis.
    %
    % Version 1: created 10/04/22. Author: O. Hogan
   
    novertsc = 24;
    wheelbase = 3.97;
    totalwidth = 4.3;
    wheelradius = .7;
    wheelwidth = .2;
    truckheight = 4;
    overhangl = 1.2;
    overhangw = .1;
    overhangh = -.1;
    lorrycolour = [.51 .8 .51];

    wheelloc = [0 0 wheelradius; 0 totalwidth-wheelwidth wheelradius; wheelbase 0 wheelradius; wheelbase totalwidth-wheelwidth wheelradius];
    wheelloc(:,1) = wheelloc(:,1)+position;

    theta = [0 : (2*pi)/novertsc: 2*pi*(1-(1/novertsc))];


    for m =1:4
        wheelverts = zeros(novertsc*2, 3);
        for n = 1:novertsc
            wheelverts(n,1) = wheelradius*cos(theta(n));
            wheelverts(n,3) = wheelradius*sin(theta(n));
            wheelverts(n+novertsc,:) = wheelverts(n,:);
            wheelverts(n+novertsc,2) = wheelwidth;
        end
        wheelverts(1:novertsc*2,:) = wheelverts(1:novertsc*2,:) + wheelloc(m,:);
        xcoord = wheelverts(:,1);
        ycoord = wheelverts(:,2);
        zcoord = wheelverts(:,3);
        for n = 1:novertsc-1
           x = [xcoord(n); xcoord(n+1); xcoord(n+1+novertsc); xcoord(n+novertsc)];
           y = [ycoord(n); ycoord(n+1); ycoord(n+1+novertsc); ycoord(n+novertsc)];
           z = [zcoord(n); zcoord(n+1); zcoord(n+1+novertsc); zcoord(n+novertsc)];
           patch(x,y,z, 'k', 'LineStyle','none', 'FaceLighting', 'phong') 
        end
        x = [xcoord(1); xcoord(novertsc); xcoord(2*novertsc); xcoord(novertsc+1)];
        y = [ycoord(1); ycoord(novertsc); ycoord(2*novertsc); ycoord(novertsc+1)];
        z = [zcoord(1); zcoord(novertsc); zcoord(2*novertsc); zcoord(novertsc+1)];
        patch(x,y,z, 'k', 'LineStyle','none', 'FaceLighting', 'phong')
        xf = xcoord(1:novertsc);
        yf = ycoord(1:novertsc);
        zf = zcoord(1:novertsc);

        xb = xcoord(novertsc+ 1:2*novertsc);
        yb = ycoord(novertsc+ 1:2*novertsc);
        zb = zcoord(novertsc+ 1:2*novertsc);

        patch(xf, yf, zf, 'k', 'LineStyle','none', 'FaceLighting', 'phong');
        patch(xb, yb, zb, 'k', 'LineStyle','none', 'FaceLighting', 'phong');
    end

    %trucktop
    trucktoploc = wheelloc(1,:);

    truckvertsdispx = [ wheelbase/2;-overhangl ; -overhangl ; wheelbase/2  ; wheelbase/2;-overhangl ; -overhangl ; wheelbase/2 ; wheelbase+overhangl; wheelbase+overhangl ;wheelbase+overhangl; wheelbase+overhangl];
    truckvertsdispy = [overhangw ;overhangw ; totalwidth - overhangw ; totalwidth - overhangw; overhangw ; overhangw; totalwidth - overhangw ; totalwidth - overhangw; overhangw; totalwidth - overhangw; overhangw; totalwidth - overhangw];
    truckvertsdispz = [-overhangh; -overhangh ; -overhangh; -overhangh ; truckheight - wheelradius;  truckheight - wheelradius; truckheight - wheelradius;  truckheight - wheelradius; -overhangh ; truckheight/2 - wheelradius;  truckheight/2 - wheelradius;-overhangh ];
    truckverts = [truckvertsdispx, truckvertsdispy, truckvertsdispz];
    truckverts = truckverts + trucktoploc;

    for n = 1:3
        x = [truckverts(n,1); truckverts(n+1,1); truckverts(n+5,1); truckverts(n+4,1)];
        y = [truckverts(n,2); truckverts(n+1,2); truckverts(n+5,2); truckverts(n+4,2)];
        z = [truckverts(n,3); truckverts(n+1,3); truckverts(n+5,3); truckverts(n+4,3)];
        patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')
    end
    

    x = [truckverts(5,1); truckverts(6,1); truckverts(7,1); truckverts(8,1)];
    y = [truckverts(5,2); truckverts(6,2); truckverts(7,2); truckverts(8,2)];
    z = [truckverts(5,3); truckverts(6,3); truckverts(7,3); truckverts(8,3)];
    patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')

    x = [truckverts(12,1); truckverts(10,1); truckverts(11,1); truckverts(9,1)];
    y = [truckverts(12,2); truckverts(10,2); truckverts(11,2); truckverts(9,2)];
    z = [truckverts(12,3); truckverts(10,3); truckverts(11,3); truckverts(9,3)];
    patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')

    x = [truckverts(5,1); truckverts(11,1); truckverts(9,1); truckverts(1,1)];
    y = [truckverts(5,2); truckverts(11,2); truckverts(9,2); truckverts(1,2)];
    z = [truckverts(5,3); truckverts(11,3); truckverts(9,3); truckverts(1,3)];
    patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')

    x = [truckverts(5,1); truckverts(8,1); truckverts(10,1); truckverts(11,1)];
    y = [truckverts(5,2); truckverts(8,2); truckverts(10,2); truckverts(11,2)];
    z = [truckverts(5,3); truckverts(8,3); truckverts(10,3); truckverts(11,3)];
    patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')

    x = [truckverts(12,1); truckverts(10,1); truckverts(8,1); truckverts(4,1)];
    y = [truckverts(12,2); truckverts(10,2); truckverts(8,2); truckverts(4,2)];
    z = [truckverts(12,3); truckverts(10,3); truckverts(8,3); truckverts(4,3)];
    patch(x,y,z,lorrycolour, 'LineStyle','none', 'FaceLighting', 'phong')
    
    view(3)
end
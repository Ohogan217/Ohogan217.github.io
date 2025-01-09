function Makebeam(pt1, pt2)

width = .12;

radius = width/sqrt(2);
noverts = 4;
theta = [(pi)/noverts : (2*pi)/noverts: 2*pi];
angle = atan((pt1(2)-pt2(2))/(pt1(1)-pt2(1)));

points = zeros(noverts+1,3);
   for n = 1:noverts
       points(n,2) = radius*cos(theta(n));
       points(n,1) = radius*sin(theta(n))*cos(angle);
       points(n,3) = radius*sin(angle);
       if points(n,1)>0
           points(n,3) = points(n,3)*-1;
       end
   end
points(noverts+1,:) = points(1,:);

basepoints = points + pt1;
toppoints = points + pt2;


rgb = [1 1 1];


for n=1:noverts
    x = [basepoints(n+1,1); basepoints(n,1); toppoints(n,1); toppoints(n+1,1)];
    y = [basepoints(n+1,2); basepoints(n,2); toppoints(n,2); toppoints(n+1,2)];
    z = [basepoints(n+1,3); basepoints(n,3); toppoints(n,3); toppoints(n+1,3)];
    patch(x, y, z, 'Facecolor', rgb);
end



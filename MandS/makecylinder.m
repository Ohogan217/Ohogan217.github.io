function   makecylinder(noverts, height, radius, offsetx, offsety, offsetz)

if noverts<=0 ||height ==0 ||radius <=0 
    error('invalid inputs')
    return
end

if  ~isreal(noverts) ||~isreal(height) ||~isreal(radius)|| ~isreal(offsetx) ||~isreal(offsety) ||~isreal(offsetz)
   error('Inputs must be real numbers') 
end 
offsetmatrix = [offsetx, offsety, offsetz];

theta = [0 : (2*pi)/noverts: 2*pi*(1-(1/noverts))];

vertcoordbottom = [radius*cos(theta); radius*sin(theta); zeros(1,noverts)];
vertcoordtop = [radius*cos(theta); radius*sin(theta); (ones(1,noverts)* height)];

vertgroup = [vertcoordbottom vertcoordtop]';

vertgroup = vertgroup + (ones(noverts*2,3).*offsetmatrix);

facematrix = [[1:noverts];[1:noverts]' [[2:noverts] 1]' [(noverts+[2:noverts]) noverts+1]' ((noverts+[1:noverts])')*ones(1,noverts-3);noverts+[1:noverts]];

patch('Vertices',vertgroup, 'Faces', facematrix, 'FaceColor','blue')
view(3)
end
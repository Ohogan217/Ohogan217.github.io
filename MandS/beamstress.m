function [colour] = beamstress(pt1, pt2, maxelongation)
    % [colour] = beamstress(elongation, maxelongation):
    % Return a RGB value corresponding to the amount of stress in a beam, red
    % indicating compression, and blue indicating tension . 
    % Input elongation = number refering to the fraction elongation of the
    % beam relative to its inital size
    % Input maxelongation = number refering to the maximum elongation of the
    % beam relative to its inital size
    % Output Colour = 3x1 array with values refering to the RGB colour of
    % the beam
    % Version 1: created 10/04/22. Author: O. Hogan
    root2 = sqrt(2);
    
    distance = sqrt((pt1(1)-pt2(1))^2 + (pt1(2)-pt2(2))^2 + (pt1(3)-pt2(3))^2);
    if distance < 5
       elongation = ((distance/4.5) - 1);
    else
       elongation = ((distance/4.5*root2) - 1);
    end
    shade = (elongation/maxelongation)^2;
    
    if elongation == 0
        colour = [1 1 1];
    else
        if shade >= 1
            shade = 1;
        end
        if elongation > 0
            colour = [1 1-shade 1-shade];
        else
            colour = [1-shade 1-shade 1];
        end
    end
end
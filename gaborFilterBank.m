function gaborArray = gaborFilterBank(u,v,m,n)

% GABORFILTERBANK generates a custum Gabor filter bank. 
% It creates a u by v cell array, whose elements are m by n matrices; 
% each matrix being a 2-D Gabor filter.
% 
% 
% Inputs:
%       u	:	No. of scales (usually set to 4) 
%       v	:	No. of orientations (usually set to 8)
%       m	:	No. of rows in a 2-D Gabor filter (an odd integer number, usually set to 39)
%       n	:	No. of columns in a 2-D Gabor filter (an odd integer number, usually set to 39)
% 
% Output:
%       gaborArray: A u by v array, element of which are m by n 
%                   matries; each matrix being a 2-D Gabor filter   

    if (nargin ~= 4)    % Check correct number of arguments
        error('There must be four input arguments (Number of scales and orientations and the 2-D size of the filter)!')
    end


    %% Create Gabor filters
    % Create u*v gabor filters each being an m by n matrix

    gaborArray = cell(1,v);
    fmax = 3;
    gama = sqrt(2);
    eta = sqrt(2);

    for i = u

        fu = fmax/((sqrt(2))^(i-1));
        alpha = fu/gama;
        beta = fu/eta;

        for j = 1:v
            tetav = ((j-1)/(v-1))*pi;
            gFilter = zeros(m,n);

            for x = 1:m
                for y = 1:n
                    xprime = (x-((m+1)/2))*cos(tetav)+(y-((n+1)/2))*sin(tetav);
                    yprime = -(x-((m+1)/2))*sin(tetav)+(y-((n+1)/2))*cos(tetav);
                    gFilter(x,y) = (fu^2/(pi*gama*eta))*exp(-((alpha^2)*(xprime^2)+(beta^2)*(yprime^2)))*exp(1i*2*pi*fu*xprime);
                end
            end
            gaborArray{1,j} = gFilter;

        end
    end


    %% Show Gabor filters (Please comment this section if not needed!)

    % Show magnitudes of Gabor filters:
%     figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
%     for i = u
%         for j = 1:v        
%             %subplot(u,v,(i-1)*v+j);        
%             subplot(2,v,j);        
%             imshow(abs(gaborArray{1,j}),[]);title('Magnitude');
%             hold on;
%             subplot(2,v,j+v);        
%             imshow(real(gaborArray{1,j}),[]);title('Orientation');
%             hold off;
%         end
%     end
end

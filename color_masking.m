function maskedRGBImage = color_masking(rgbImage,color)
% Color_Masking: This function extracts the pixels that in the required 
% color. It will mask the remaining part of the image by removing the pixel
% intensities from it moves it value to zero. 
% Inputs:
%   rgbImage      : RGB image frame 
%   color         : The color of the object required so that the remaining
%                   objects are maksed.
% Output:
%   maskedRGBImage:Unneccesary object masked and returned.
%
% Sample use 
%   maskedRGBImage = color_masking('Input.jpg','smoke');
%   maskedRGBImage = color_masking("Input.jpg','fire');
%
% Version 2015-11-02
%
%
    if nargin < 1                                                          % check if there are enough aruguments
        error('There are no enough input arguments')
    end
    if nargin < 2
        color = 'smoke';
    end
    
    hsvImage    = rgb2hsv(rgbImage);                                       % Convert RGB image to HSV
    hImage      = hsvImage(:,:,1);                                         % Extract out the H, S, and V images individually
    sImage      = hsvImage(:,:,2);
    vImage      = hsvImage(:,:,3);
    
    % Now apply each color band's particular thresholds to the color band
    hueMask             = (hImage >= color.hueThresholdLow) &        (hImage <= color.hueThresholdHigh);
    saturationMask      = (sImage >= color.saturationThresholdLow) & (sImage <= color.saturationThresholdHigh);
    valueMask           = (vImage >= color.valueThresholdLow) &      (vImage <= color.valueThresholdHigh);
    
    
    ObjectsMask         = uint8(hueMask & saturationMask & valueMask);
    % Tell user that we're going to filter out small objects.
    smallAcceptableArea = 100; 

    % Get rid of small objects.  Note: bwareaopen returns a logical.
    ObjectsMask         = uint8(bwareaopen(ObjectsMask, smallAcceptableArea));
    
    % Smooth the border using a morphological closing operation, imclose().
    structuringElement  = strel('disk',4);
    ObjectsMask         = imclose(ObjectsMask, structuringElement);
    
    % Fill in any holes in the regions, since they are most likely red also.
    ObjectsMask         = uint8(imfill(ObjectsMask,'holes'));
    
    % Use the yellow object mask to mask out the yellow-only portions of the rgb image.
    maskedImageR        = ObjectsMask .* rgbImage(:,:,1);
    maskedImageG        = ObjectsMask .* rgbImage(:,:,2);
    maskedImageB        = ObjectsMask .* rgbImage(:,:,3);

    % Concatenate the masked color bands to form the rgb image.
    maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);    
end
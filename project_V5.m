close all; clear all; clc;                                                 %#ok<CLSCR> % close & clear all previous works.
workspace;

fontSize    = 12;                                                          % For letters on the axis.

showfigs    = 'Yes';                                                       % to show Figure choose between 'Yes'/ 'No'
% showfigs    = 'No';
% savefigs    = 'Yes';
savefigs    = 'No';                                                        % save the figures 
% savedata    = 'Yes';
savedata    = 'No';
%% Step 1 - Load Video.
[FileName,PathName] = uigetfile({'*.avi','AVI(.avi)';...                   % choosing the movie required to be loaded.
                                 '*.mkv','MKV(.mkv)';...
                                 '*.flv','FLV(.flv)';...
                                 '*.3gp','3GPP(.3gp)';...
                                 '*.mp4','MPEG(.mp4)';...
                                 '*.wmv','Windows(.wmv)';...
                                 '*.*','All Files'},...
                                 'Select Movie');   
if ((strcmpi(FileName,'Bikent_01.avi') == 1) || (strcmpi(FileName,'Bikent_02.avi') == 1)...
        || (strcmpi(FileName,'Bikent_03.avi') == 1) || (strcmpi(FileName,'Bikent_04.avi') == 1)...
        || (strcmpi(FileName,'Bikent_05.avi') == 1) || (strcmpi(FileName,'Bikent_06.avi') == 1)...
        || (strcmpi(FileName,'Bikent_07.avi') == 1) || (strcmpi(FileName,'Bikent_08.avi') == 1))
    colorvalues = 1;
elseif ((strcmpi(FileName,'Visor_01.mpg') == 1) || (strcmpi(FileName,'Visor_02.avi') == 1)...
        || (strcmpi(FileName,'Visor_03.mpg') == 1) || (strcmpi(FileName,'Visor_04.mpg') == 1)...
        || (strcmpi(FileName,'Visor_05.mpg') == 1) || (strcmpi(FileName,'Visor_06.mpg') == 1)...
        || (strcmpi(FileName,'Visor_07.mpg') == 1) || (strcmpi(FileName,'Visor_08.mpg') == 1))
    colorvalues = 2;
end

if (colorvalues == 1)
    color.hueThresholdLow         = 0;
    color.hueThresholdHigh        = 1;
	color.saturationThresholdLow  = 0;
	color.saturationThresholdHigh = 0.28;
	color.valueThresholdLow       = 0.38;    
	color.valueThresholdHigh      = 0.97;
elseif colorvalues == 2
    color.hueThresholdLow         = 0;
    color.hueThresholdHigh        = 1;
	color.saturationThresholdLow  = 0;
	color.saturationThresholdHigh = 0.28;
	color.valueThresholdLow       = 0.65;    
	color.valueThresholdHigh      = 0.93;
end
movieFullFileName = fullfile(PathName,FileName);
videoObject = VideoReader(movieFullFileName);
% Intialization of Information
rgbImage = read(videoObject, 1);
[rows, columns, numberOfColorBands] = size(rgbImage);

numberOfFrames      = videoObject.NumberOfFrames;                          % no of frames
start_frame         = 1;
end_frame           = numberOfFrames;
orientations        = 5;                                                   % number of orientations used for Gabor Filter.
% create the filter bank for custom gabor filter
gaborArray          = gaborFilterBank(4,orientations,39,39);               % 4 directions, 5 orientations, filter 39x39

%%
features_smoke      = [];
features_nonsmoke   = [];
features_sp         = zeros(1,orientations*4);
features_tmp        = zeros(1,orientations*4);
features_spt        = zeros(end_frame-start_frame+1,orientations*4);
features_temp       = zeros(end_frame-start_frame+1,orientations*4);
Eblock              = zeros(numberOfFrames,1);
for frames = start_frame:end_frame
    %% Step 2 - Preprocessing    
    rgbImage        = read(videoObject, frames);                           % reading the video Frames
    if (strcmpi(showfigs,'Yes') == 1)
        subplot(1,2,1); 
        imshow(rgbImage); drawnow;
    end
    maskedRGBImage  = color_masking(rgbImage,color);                       % Color masking the image 
    if frames == start_frame
        prev_maskedImage    = maskedRGBImage;
        currentmaskedImage  = maskedRGBImage;
    else
        currentmaskedImage  = maskedRGBImage - prev_maskedImage;
        prev_maskedImage    = maskedRGBImage;
    end
%     if (strcmpi(showfigs,'Yes') == 1)
%         subplot(1,3,2);
%         imshow(maskedRGBImage);   
%         subplot(1,3,3);
%         imshow(currentmaskedImage);   
%     end
    [m, n] = size(currentmaskedImage);
    [~,LH,HL,HH] = dwt2(rgb2gray(currentmaskedImage),'db1');            % applying the dwt 
     E = HL.^2 + LH.^2 + HH.^2;                          % Calculating the energy of each pixel.
     Eblock(frames,1) = sum(sum(E))/(m*n);
     subplot(1,2,2);
     plot(Eblock,'r-','LineWidth',1);
%     %% Step 3 - Apply the Gabor Filter   
%    gaborResult_sp = gaborFiltering(maskedRGBImage,gaborArray); 
%    gaborResult_tmp= gaborFiltering(currentmaskedImage,gaborArray); 
%     if (strcmpi(showfigs,'Yes') == 1)
%         for j = 1:5
%             subplot(3,5,j+5);
%             imshow(gaborResult_sp{j});
%         end
%         for j = 1:5
%             subplot(3,5,j+10);
%             imshow(gaborResult_tmp{j});
%         end
%     end
%     %features_sp=[];
%     for j=1:5
%        features_sp((j-1)*4+1)    = entropy(gaborResult_sp{j});
%        features_sp((j-1)*4+2)    = std2(gaborResult_sp{j});
%        features_sp((j-1)*4+3)    = mean2(gaborResult_sp{j});
%        features_sp((j-1)*4+4)    = sum(sum(gaborResult_sp{j}.^2));
%        features_tmp((j-1)*4+1)   = entropy(gaborResult_tmp{j});
%        features_tmp((j-1)*4+2)   = std2(gaborResult_tmp{j});
%        features_tmp((j-1)*4+3)   = mean2(gaborResult_tmp{j});
%        features_tmp((j-1)*4+4)   = sum(sum(gaborResult_tmp{j}.^2));
%     end
%     features_spt(frames,:)    = features_sp;                                      
%     features_temp(frames,:)   = features_tmp;
%     if (strcmpi(savefigs,'Yes') == 1)
%         if (strcmpi(FileName,'Bikent_01.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_01\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_02.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_02\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_03.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_03\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_04.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_04\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_05.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_05\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_06.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_06\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_07.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_07\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Bikent_08.avi') == 1)
%             saveas(gcf,['D:\figures\Bikent_08\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_01.mpg') == 1)
%             saveas(gcf,['D:\figures\Visor_01\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_02.avi') == 1)
%             saveas(gcf,['D:\figures\Visor_02\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_03.mpg') == 1)
%             saveas(gcf,['D:\figures\Visor_03\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_04.mpg') == 1)
%             saveas(gcf,['D:\figures\Visor_04\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_05.avi') == 1)
%             saveas(gcf,['D:\figures\Visor_05\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_06.avi') == 1)
%             saveas(gcf,['D:\figures\Visor_06\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_07.avi') == 1)
%             saveas(gcf,['D:\figures\Visor_07\',num2str(frames),'.png']);
%         elseif (strcmpi(FileName,'Visor_08.avi') == 1)
%             saveas(gcf,['D:\figures\Visor_08\',num2str(frames),'.png']);
%         end
%     end
% end
%     % Step 4 - Apply the statstacial parameters
%     if (strcmpi(savedata,'Yes') == 1)
%         if (strcmpi(FileName,'Bikent_01.avi') == 1)
%             save('D:\figures\Bikent_01\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_01\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_02.avi') == 1)
%             save('D:\figures\Bikent_02\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_02\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_03.avi') == 1)
%             save('D:\figures\Bikent_03\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_03\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_04.avi') == 1)
%             save('D:\figures\Bikent_04\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_04\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_05.avi') == 1)
%             save('D:\figures\Bikent_05\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_05\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_06.avi') == 1)
%             save('D:\figures\Bikent_06\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_06\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_07.avi') == 1)
%             save('D:\figures\Bikent_07\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_07\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Bikent_08.avi') == 1)
%             save('D:\figures\Bikent_08\features_spt.mat','features_spt');
%             save('D:\figures\Bikent_08\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_01.mpg') == 1)
%             save('D:\figures\Visor_01\features_spt.mat','features_spt');
%             save('D:\figures\Visor_01\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_02.avi') == 1)
%             save('D:\figures\Visor_02\features_spt.mat','features_spt');
%             save('D:\figures\Visor_02\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_03.mpg') == 1)
%             save('D:\figures\Visor_03\features_spt.mat','features_spt');
%             save('D:\figures\Visor_03\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_04.mpg') == 1)
%             save('D:\figures\Visor_04\features_spt.mat','features_spt');
%             save('D:\figures\Visor_04\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_05.avi') == 1)
%             save('D:\figures\Visor_05\features_spt.mat','features_spt');
%             save('D:\figures\Visor_05\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_06.avi') == 1)
%             save('D:\figures\Visor_06\features_spt.mat','features_spt');
%             save('D:\figures\Visor_06\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_07.avi') == 1)
%             save('D:\figures\Visor_07\features_spt.mat','features_spt');
%             save('D:\figures\Visor_07\features_temp.mat','features_temp');
%         elseif (strcmpi(FileName,'Visor_08.avi') == 1)
%             save('D:\figures\Visor_08\features_spt.mat','features_spt');
%             save('D:\figures\Visor_08\features_temp.mat','features_temp');
%         end
end
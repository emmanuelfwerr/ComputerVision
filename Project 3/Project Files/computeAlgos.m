function [k] = computeAlgos(myFolder, lambda)
%% reading 

filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
imageArray = zeros(length(theFiles));

baseFileName = theFiles(1).name;
fullFileName = fullfile(myFolder, baseFileName);
%fprintf(1, 'Now reading %s\n', fullFileName);
imageArray = imread(fullFileName); 
[rows,columns, ~] = size(imageArray);

greyImages = zeros(rows, columns, length(theFiles));
greyImages(:,:,1) = rgb2gray(imageArray);

for k = 2 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  %fprintf(1, 'Now reading %s\n', fullFileName);
  % reading
  imageArray = imread(fullFileName);   
  %imshow(imageArray);  % Display image.
  greyImages(:,:,k) = rgb2gray(imageArray);
  %drawnow; % Force display to update immediately.
end

output = zeros(rows,columns);

%% Simple Background Subtraction


M_bs = zeros(rows, columns, length(theFiles));
B_bs = greyImages(:,:,1);
%lambda = 35;

for i = 2 : (length(theFiles))
    I = greyImages(:,:,i);
    diff = abs(B_bs - I);
    output(diff <= lambda) = 0;
    output(diff > lambda) = 1;
%     for p = 1 : rows
%         for q = 1 : columns        
%            if(diff(p,q) > lambda)
%                output(p,q) = 1;
%            end
%            if(diff(p,q) <= lambda)
%                output(p,q) = 0;
%            end
%         end
%     end
    M_bs(:,:,i) = output;
%     imshow(M_bs(:, :, i));
%     drawnow;
end



%% Simple Frame Differencing

M_fd = zeros(rows, columns, length(theFiles));
B_fd = zeros(rows, columns, length(theFiles));
B_fd(:,:,1) = greyImages(:,:,1);

%lambda = 40;  
%while i < length(theFiles) 
for i = 2 : (length(theFiles))
    I = greyImages(:,:,i);
    diff = abs(B_fd(:,:,i-1) - I);
    output(diff <= lambda) = 0;
    output(diff > lambda) = 1;
%     for p = 1 : rows
%         for q = 1 : columns        
%            if(diff(p,q) > lambda)
%                output(p,q) = 1;
%            end
%            if(diff(p,q) <= lambda)
%                output(p,q) = 0;
%            end
%         end
%     end
    M_fd(:,:,i) = output;
%     imshow(M_fd(:,:,i));
%     drawnow;
    B_fd(:,:,i) = I;
end


%% Adaptive Background Subtraction
M_abs = zeros(rows, columns, length(theFiles));
B_abs = zeros(rows, columns, length(theFiles));
B_abs(:,:,1) = greyImages(:,:,1);

%lambda = 35;
alpha = 0.1;
%while i < length(theFiles)
for i = 2 : (length(theFiles))    
   I = greyImages(:,:,i);
   diff = abs(B_abs(:,:,i-1) - I);
   output(diff <= lambda) = 0;
    output(diff > lambda) = 1;
%     for p = 1 : rows
%         for q = 1 : columns        
%            if(diff(p,q) > lambda)
%                output(p,q) = 1;
%            end
%            if(diff(p,q) <= lambda)
%                output(p,q) = 0;
%            end
%         end
%     end
    M_abs(:,:,i) = output;
    B_abs(:,:,i) = alpha*I + ((1- alpha)*B_abs(:,:,i-1));
%     imshow(M_abs(:,:,i));
%     drawnow;
end    

%% Persistent Frame Differencing 

M_pfd = zeros(rows, columns, length(theFiles));
B_pfd = zeros(rows, columns, length(theFiles));
H = zeros(rows, columns, length(theFiles));
B_pfd(:,:,1) = greyImages(:,:, 1);
H(:,:,1) = 0;
gamma = 17;

%lambda = 35;
%while i < length(theFiles)
for i = 2 : (length(theFiles))    
   I = greyImages(:,:,i);
   diff = abs(B_pfd(:,:,i-1) - I);
   output(diff <= lambda) = 0;
   output(diff > lambda) = 1;
%     for p = 1 : rows
%         for q = 1 : columns        
%            if(diff(p,q) > lambda)
%                output(p,q) = 1;
%            end
%            if(diff(p,q) <= lambda)
%                output(p,q) = 0;
%            end
%         end
%     end
    M_pfd(:,:,i) = output;
    tmp = max(H(:,:,i-1) - gamma, 0);
    H(:,:,i) = max(255 * M_pfd(:,:,i), tmp);
    %H(:,:,i) = H(:,:,i);
%     imshow(H(:,:,i)/255);
%     drawnow;
    B_pfd(:,:,i) = I;
end

%% Video writing

% p = 100;
% A = [M_bs(:,:,p), M_fd(:,:,p); M_abs(:,:,p), H(:,:,p)/255];
% imshow(A)
% outputVideo=VideoWriter('arenaW.avi');
% outputVideo.FrameRate=30;
% open(outputVideo);
% 
% for p = 1: length(theFiles)
%     img = [M_bs(:,:,p), M_fd(:,:,p); M_abs(:,:,p), H(:,:,p)/255]; %// This line and the following can be reduced to only 1 line.
%     writeVideo(outputVideo,img); %// The actual pixel values are in 'cdata'
% end
% close(gcf)
% close(outputVideo);

end


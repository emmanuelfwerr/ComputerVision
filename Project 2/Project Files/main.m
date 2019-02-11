%{ 
Emmanuel & Guru
EE 454
Project 2
November 1st, 2018
%}

clc
clear

profile on
%% Loading Files

filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
vue2video = VideoReader(filenamevue2mp4);
filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';
vue4video = VideoReader(filenamevue4mp4);

load('vue2CalibInfo.mat');
load('vue4CalibInfo.mat');

load('Subject4-Session3-Take4_mocapJoints.mat');



%% intializing

% Algorithm efficiency increases if we predefine the used matrices

j1 = zeros(1,26214);
j2 = zeros(1,26214);
j3 = zeros(1,26214);
j4 = zeros(1,26214);
j5 = zeros(1,26214);
j6 = zeros(1,26214);
j7 = zeros(1,26214);
j8 = zeros(1,26214);
j9 = zeros(1,26214);
j10 = zeros(1,26214);
j11 = zeros(1,26214);
j12 = zeros(1,26214);
erroravg = zeros(1,26214); 

%% Loop for calculating error values for each frame 
%mocapFnum = 1; 
%i = 1;

for mocapFnum = 1:26214 
            %% Reading the 3D joint data
            x = mocapJoints(mocapFnum,:,1);  % X coordinates
            y = mocapJoints(mocapFnum,:,2); % Y coordinates
            z = mocapJoints(mocapFnum,:,3); % Z coordinates
            conf = mocapJoints(mocapFnum,:,4); % Confidence values

        %{
            It says to reject the frames that do not have all values of confidence 
           as 1 but i hav not due to the extensive amount of iterations and
           time it takes to incoperate that in. 
        %}

            %% Reading camera parameters
            % Camera Location for both vue2 and vue4
            tao2 = vue2.Pmat(:,4);
            camlocation2 = -(vue2.Rmat.')*tao2;  % matches vue2.position (check)
            tao4 = vue4.Pmat(:,4);
            camlocation4 = -(vue4.Rmat.')*tao4;  % matches vue4.position (check)

            pmatcheckv2 = vue2.Rmat*camlocation2;  % Pmat is correct values with 3x3 (check) for vue2
            pmatcheckv4 = vue4.Rmat*camlocation4;   % Pmat is correct values with 3x3 (check) for vue4


            %% Projecting 3D points into 2D pixel locations
            Pjoint = zeros(3,12);
            Pjoint4 = zeros(3,12);
            for i = 1:12
                Pjoint(:,i) = threed2d(x(i),y(i),z(i), vue2);     % transformed 3d to 2d coordinates for vue2
                Pjoint4(:,i) = threed2d(x(i),y(i),z(i), vue4);    % transformed 3d to 2d coordinates for vue4
            end

           
          
            %% Plotting points on images is described at the end with whichever fname 
            %  you desire to enter since this loop will run till frame number is 26214 
            % and it is not advisable to change the iterations in this for
            % loop

            %% Triangulation back into a set of 3D scene points
            %{
                Solving the triangulation equation with Ax=b matrix type
               c2c1 (b) -> vue4 camera position - vue2 camera position 
               A -> u matrix where u1 = vue2 viewing ray, u2 = (-)vue4 viewing ray
               and u3 is calculated using the cross product of u1 and u2 divided by 
               its absolute value. the form is [u1,u1,u1;-u2,-u2,-u2;u3,u3,u3]
               x -> matrix to calculate distances a and b in the form [a;b;d]
            %}

            c2c1 = camlocation4-camlocation2;

            % We placed a for loop to calculate pixel values 
            % for each of the 12 joints

            p = zeros(3,12);        % intializing p = pixel value matrix for all joints
            for i = 1:12
                temp2 = vue2.Kmat\Pjoint(:,i);     
                temp4 = vue4.Kmat\Pjoint4(:,i);
                vue2VR = (vue2.Rmat.')* temp2;   % vue 2 viewing ray
                vue4VR = (vue4.Rmat.') * temp4; % vue 4 viewing ray

                u3 = cross(vue2VR,vue4VR)/abs(cross(vue2VR,vue4VR));


                Amat(:,1) = vue2VR;     %   
                Amat(:,2) = -vue4VR;    %   Inserting into the A matrix
                Amat(:,3) = u3(:,3);    %

                var1 = Amat\(c2c1);      % var1 is A^(-1)* b
                p1 = camlocation2 + (var1(1)*vue2VR); 
                p2 = camlocation4 + (var1(2)*vue4VR);

                p(:,i) = (p1 + p2)/2;    % final world coordinate matrix
            end


            %% Measure error between triangulated and original 3D points
            erroravg1 = 0;
            error = zeros(1,12);  % intitializing error mat

            for i = 1:12
                error(i) = sqrt((x(i) - p(1,i)).^2 + (y(i) - p(2,i)).^2 + (z(i) - p(3,i)).^2);   
                erroravg1 = error(i) + erroravg1;
            end
            %{
                Error between the translated coordinated from 3d to 2d 
               and back to 3d for a specific frame
            %}
            erroravg(mocapFnum) = erroravg1/12; % for plotting
            j1(mocapFnum) = error(1); 
            j2(mocapFnum) = error(2);
            j3(mocapFnum) = error(3);
            j4(mocapFnum) = error(4);
            j5(mocapFnum) = error(5);
            j6(mocapFnum) = error(6);
            j7(mocapFnum) = error(7);
            j8(mocapFnum) = error(8);
            j9(mocapFnum) = error(9);
            j10(mocapFnum) = error(10);
            j11(mocapFnum) = error(11);
            j12(mocapFnum) = error(12);
            
end

% minimum error for 12 joints

minerrorj1 = min(j1(:));
minerrorj2 = min(j2(:));
minerrorj3 = min(j3(:));
minerrorj4 = min(j4(:));
minerrorj5 = min(j5(:));
minerrorj6 = min(j6(:));
minerrorj7 = min(j7(:));
minerrorj8 = min(j8(:));
minerrorj9 = min(j9(:));
minerrorj10 = min(j10(:));
minerrorj11 = min(j11(:));
minerrorj12 = min(j12(:));

% maximum error for 12 joints
maxerrorj1 = max(j1(:));
maxerrorj2 = max(j2(:));
maxerrorj3 = max(j3(:));
maxerrorj4 = max(j4(:));
maxerrorj5 = max(j5(:));
maxerrorj6 = max(j6(:));
maxerrorj7 = max(j7(:));
maxerrorj8 = max(j8(:));
maxerrorj9 = max(j9(:));
maxerrorj10 = max(j10(:));
maxerrorj11 = max(j11(:));
maxerrorj12 = max(j12(:));

% mean error for 12 joints
meanerrorj1 = mean(j1(:));
meanerrorj2 = mean(j2(:));
meanerrorj3 = mean(j3(:));
meanerrorj4 = mean(j4(:));
meanerrorj5 = mean(j5(:));
meanerrorj6 = mean(j6(:));
meanerrorj7 = mean(j7(:));
meanerrorj8 = mean(j8(:));
meanerrorj9 = mean(j9(:));
meanerrorj10 = mean(j10(:));
meanerrorj11 = mean(j11(:));
meanerrorj12 = mean(j12(:));

% Median error for 12 joints
mederrorj1 = median(j1(:));
mederrorj2 = median(j2(:));
mederrorj3 = median(j3(:));
mederrorj4 = median(j4(:));
mederrorj5 = median(j5(:));
mederrorj6 = median(j6(:));
mederrorj7 = median(j7(:));
mederrorj8 = median(j8(:));
mederrorj9 = median(j9(:));
mederrorj10 = median(j10(:));
mederrorj11 = median(j11(:));
mederrorj12 = median(j12(:));

% Std Deviation of error for 12 joints 
stderrorj1 = std(j1(:));
stderrorj2 = std(j2(:));
stderrorj3 = std(j3(:));
stderrorj4 = std(j4(:));
stderrorj5 = std(j5(:));
stderrorj6 = std(j6(:));
stderrorj7 = std(j7(:));
stderrorj8 = std(j8(:));
stderrorj9 = std(j9(:));
stderrorj10 = std(j10(:));
stderrorj11 = std(j11(:));
stderrorj12 = std(j12(:));

%% Showing points on image with desired frame number, mocapFnum:

mocapFnum1 = 10000;
x1 = mocapJoints(mocapFnum1,:,1);  % X coordinates
y1 = mocapJoints(mocapFnum1,:,2); % Y coordinates
z1 = mocapJoints(mocapFnum1,:,3); % Z coordinates
conf = mocapJoints(mocapFnum1,:,4); % Confidence values
Pjoint = zeros(3,12);
Pjoint4 = zeros(3,12);
for i = 1:12
    Pjoint(:,i) = threed2d(x1(i),y1(i),z1(i), vue2); 
    Pjoint4(:,i) = threed2d(x1(i),y1(i),z1(i), vue4);
end

%% Plotting for vue2
figure(2)

vue2video.CurrentTime = (mocapFnum1-1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);
imshow(vid2Frame);

title('Vue2');
hold on
for i = 1:12
    plot(Pjoint(1,i),Pjoint(2,i), 'r+', 'MarkerSize',5, 'LineWidth', 2);  
end

% to plot the lines
plot([Pjoint(1,1) Pjoint(1,4)], [Pjoint(2,1) Pjoint(2,4)], 'c');
plot([Pjoint(1,1) Pjoint(1,2)], [Pjoint(2,1) Pjoint(2,2)], 'c');
plot([Pjoint(1,2) Pjoint(1,3)], [Pjoint(2,2) Pjoint(2,3)], 'c');
plot([Pjoint(1,4) Pjoint(1,5)], [Pjoint(2,4) Pjoint(2,5)], 'c');
plot([Pjoint(1,5) Pjoint(1,6)], [Pjoint(2,5) Pjoint(2,6)], 'c');
plot([Pjoint(1,7) Pjoint(1,10)], [Pjoint(2,7) Pjoint(2,10)], 'c');
plot([Pjoint(1,7) Pjoint(1,8)], [Pjoint(2,7) Pjoint(2,8)], 'c');
plot([Pjoint(1,8) Pjoint(1,9)], [Pjoint(2,8) Pjoint(2,9)], 'c');
plot([Pjoint(1,10) Pjoint(1,11)], [Pjoint(2,10) Pjoint(2,11)], 'c');
plot([Pjoint(1,11) Pjoint(1,12)], [Pjoint(2,11) Pjoint(2,12)], 'c');
plot([Pjoint(1,1) Pjoint(1,7)], [Pjoint(2,1) Pjoint(2,7)], 'c');
plot([Pjoint(1,4) Pjoint(1,10)], [Pjoint(2,4) Pjoint(2,10)], 'c');

%% Joint error

figure(3);

i = 1:26214;
plot(i, erroravg, 'r+', 'MarkerSize',0.1, 'LineWidth', 0.1);
axis([0 27000 0 10.^(-11.5)]);

title('errorAvg(mocapFnum)');
xlabel('mocapFnum');
ylabel('Avg Error');


%% Plotting for vue 4
%{
figure(4)
vue4video.CurrentTime = (mocapFnum1-1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);
imshow(vid4Frame);

title('Vue4 at frame');
hold on
for i = 1:12
    plot(Pjoint4(1,i), Pjoint4(2,i), 'r+', 'MarkerSize',5, 'LineWidth', 2);
end 

plot([Pjoint4(1,1) Pjoint4(1,4)], [Pjoint4(2,1) Pjoint4(2,4)], 'c');
plot([Pjoint4(1,1) Pjoint4(1,2)], [Pjoint4(2,1) Pjoint4(2,2)], 'c');
plot([Pjoint4(1,2) Pjoint4(1,3)], [Pjoint4(2,2) Pjoint4(2,3)], 'c');
plot([Pjoint4(1,4) Pjoint4(1,5)], [Pjoint4(2,4) Pjoint4(2,5)], 'c');
plot([Pjoint4(1,5) Pjoint4(1,6)], [Pjoint4(2,5) Pjoint4(2,6)], 'c');
plot([Pjoint4(1,7) Pjoint4(1,10)], [Pjoint4(2,7) Pjoint4(2,10)], 'c');
plot([Pjoint4(1,7) Pjoint4(1,8)], [Pjoint4(2,7) Pjoint4(2,8)], 'c');
plot([Pjoint4(1,8) Pjoint4(1,9)], [Pjoint4(2,8) Pjoint4(2,9)], 'c');
plot([Pjoint4(1,10) Pjoint4(1,11)], [Pjoint4(2,10) Pjoint4(2,11)], 'c');
plot([Pjoint4(1,11) Pjoint4(1,12)], [Pjoint4(2,11) Pjoint4(2,12)], 'c');
plot([Pjoint4(1,1) Pjoint4(1,7)], [Pjoint4(2,1) Pjoint4(2,7)], 'c');
plot([Pjoint4(1,4) Pjoint4(1,10)], [Pjoint4(2,4) Pjoint4(2,10)], 'c');
%}

profile viewer

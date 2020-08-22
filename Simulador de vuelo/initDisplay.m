% displays a quadrotor
function [rotor,crs,f]=initDisplay()

global rotor crs f;

%% parameters:
d_rotor  = 0.3;  % [m]
l_arm    = 0.3;  % [m]
height   = 0.1; % [m]
rot_crns = 10;   % number of corners of rotor disk
t_crs    = 0.01; % thickness of cross [m]

%% construct geometry in body frame
% rotor:
rotor(1).center = [l_arm;0;-height/2];
rotor(2).center = [0;l_arm;-height/2];
rotor(3).center = [-l_arm;0;-height/2];
rotor(4).center = [0;-l_arm;-height/2];
for i=1:4
    for c=1:rot_crns
        alpha=2*pi/rot_crns*c;
        rotor(i).vertices(:,c)=rotor(i).center + d_rotor/2*[cos(alpha);sin(alpha);0];
    end
end

% cross:
crs(1).vertices(:,1)=[t_crs/2;t_crs/2;height/2];
crs(1).vertices(:,2)=[t_crs/2+l_arm;t_crs/2;height/2];
crs(1).vertices(:,3)=[t_crs/2+l_arm;-t_crs/2;height/2];
crs(1).vertices(:,4)=[t_crs/2;-t_crs/2;height/2];

crs(1).vertices(:,5)=[t_crs/2;t_crs/2;height/2-t_crs];
crs(1).vertices(:,6)=[-t_crs/2+l_arm;t_crs/2;height/2-t_crs];
crs(1).vertices(:,7)=[-t_crs/2+l_arm;-t_crs/2;height/2-t_crs];
crs(1).vertices(:,8)=[t_crs/2;-t_crs/2;height/2-t_crs];

crs(1).vertices(:,9)=[-t_crs/2+l_arm;t_crs/2;-height/2+t_crs];
crs(1).vertices(:,10)=[t_crs/2+l_arm;t_crs/2;-height/2+t_crs];
crs(1).vertices(:,11)=[t_crs/2+l_arm;-t_crs/2;-height/2+t_crs];
crs(1).vertices(:,12)=[-t_crs/2+l_arm;-t_crs/2;-height/2+t_crs];

% regular pattern by turning:
for j=1:3
    for k=1:size(crs(1).vertices,2)
        crs(1+j).vertices(:,k)=...
            [cos(j*pi/2), -sin(j*pi/2), 0;...
             sin(j*pi/2),  cos(j*pi/2), 0;...
             0,            0,           1]...
             *crs(1).vertices(:,k);
    end
end

% connect to faces
for l=1:4
    crs(l).faces(:,1)=[1;2;3;4]; % ground
    crs(l).faces(:,2)=[5;6;7;8]; % ground upper
    crs(l).faces(:,3)=[9;10;11;12]; % top
    crs(l).faces(:,4)=[2;3;11;10]; % front
    crs(l).faces(:,5)=[6;7;12;9]; % back
    crs(l).faces(:,6)=[1;2;6;5]; % right
    crs(l).faces(:,7)=[4;3;7;8]; % left
    crs(l).faces(:,8)=[2;10;9;6]; % right
    crs(l).faces(:,9)=[3;7;12;11]; % left
end

%% display
% set up display:
f=figure(1);
set(gcf,'Position',[8 20 1024+8 768+20]);
cla
whitebg([0 0 0]);
set(gcf,'Color','k');
plot3(0,0,0);
hold on
view(190,22)
axis equal
axis([-1 1 -1 1 -1 1]); % Axis limits
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');
%set(gca,'XDir','reverse')
set(gca,'YDir','reverse')
set(gca,'ZDir','reverse')
grid on

% rotor:
rotor(1).handle = patch('faces',[1:1:size(rotor(1).vertices,2)],...
    'vertices',rotor(1).vertices','FaceColor',[1 0 0]);
rotor(2).handle = patch('faces',[1:1:size(rotor(2).vertices,2)],...
    'vertices',rotor(2).vertices','FaceColor',[0 1 0]);
rotor(3).handle = patch('faces',[1:1:size(rotor(3).vertices,2)],...
    'vertices',rotor(3).vertices','FaceColor',[0.5 0.5 0.5]);
rotor(4).handle = patch('faces',[1:1:size(rotor(4).vertices,2)],...
    'vertices',rotor(4).vertices','FaceColor',[0.5 0.5 0.5]);

% cross
for i=1:4
    crs(i).handle=patch('faces',crs(i).faces',...
        'vertices',crs(i).vertices','FaceColor',[0.7 0.7 0.7]);
end
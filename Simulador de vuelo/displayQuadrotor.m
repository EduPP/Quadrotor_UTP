% display into figure f
function [] = displayQuadrotor(in)

x=in(1);
xdot=in(4);
y=-in(2);
ydot=in(5);
z=-in(3);
zdot=in(6);
phi=in(7);
dotroll=in(10);
theta=in(8);
dotpitch=in(11);
psi=in(9);
dotyaw=in(12);

global rotor crs f;

%copy such that it can be modified:
disp_rotor=rotor;
disp_crs=crs;

% rotation matrix:
R_EB=[cos(psi)*cos(theta) cos(psi)*sin(theta)*sin(phi)-sin(psi)*cos(phi) cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi);...
      sin(psi)*cos(theta) sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi) sin(psi)*sin(theta)*cos(phi)-cos(psi)*sin(phi);...
      -sin(theta) cos(theta)*sin(phi) cos(theta)*cos(phi)]; %Body to Earth

%rotate and translate
for i=1:4
    for j=1:size(rotor(i).vertices,2)
        disp_rotor(i).vertices(:,j)=R_EB*rotor(i).vertices(:,j)...
            +[x;y;z];
    end
    for j=1:size(crs(i).vertices,2)
        disp_crs(i).vertices(:,j)=R_EB*crs(i).vertices(:,j)...
            +[x;y;z];
    end
end
    

figure(f);


% rotor:
set(rotor(1).handle,'vertices',disp_rotor(1).vertices');
set(rotor(2).handle,'vertices',disp_rotor(2).vertices');
set(rotor(3).handle,'vertices',disp_rotor(3).vertices');
set(rotor(4).handle,'vertices',disp_rotor(4).vertices');

% cross
for i=1:4
   set(crs(i).handle,'vertices',disp_crs(i).vertices');
end

axis equal
axis([x-1 x+1 y-1 y+1 z-1 z+1]); % Axis limits


out(1)=x;
out(2)=xdot;
out(3)=y;
out(4)=ydot;
out(5)=z;
out(6)=zdot;
out(7)=phi;
out(8)=dotroll;
out(9)=theta;
out(10)=dotpitch;
out(11)=psi;
out(12)=dotyaw;

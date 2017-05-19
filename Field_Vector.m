%Main Operation with GUI Inputs
clear all
%Current Date and time
Year = 2015;
Month = 1;
Day = 1;
Hour = 0;
Minutes = 0;
Seconds = 0;


%   Days Decimal days since January 1, 2015 for IGRF Model
Current_Date_String = strcat(num2str(Month),'/',num2str(Day),'/',num2str(Year));
%   Format Month/Day/Year
Days_since_Jan_1st_2015 = daysact('1/1/2015', Current_Date_String);

% Vector Field of IGRF Model for line of sight of CHIME and Ground Station
Earths_Mean_Radius = 6371.2; % Reference radius used in IGRF and used to define altitude [km]

%   CHIME Coordinates: 	49° 19? 15.6? N, 119° 37? 26.4? W
%   49.321 (theta),-119.624 (phi) or 240.376
%   Altitude for vector field (km)
CHIME_Theta = 49.321;
CHIME_Phi = 240.376;
Altitude_Vector_Field = 400;
%   Angle_Range in degrees can replace with a normal value
Angle_Range = atand(2000/(400+Earths_Mean_Radius));

Mesh_Size = 500;

%   Matrix memory allocation (theta increase by column to the right, phi
%   increases by row downwards) (Defined by Lat, Long reference frame)
%   equator is 0 theta, phi is 0 at greenwich merdian
x_matrix = zeros(Mesh_Size, Mesh_Size);
y_matrix = zeros(Mesh_Size, Mesh_Size);
z_matrix = zeros(Mesh_Size, Mesh_Size);
Bx_matrix = zeros(Mesh_Size, Mesh_Size);
By_matrix = zeros(Mesh_Size, Mesh_Size);
Bz_matrix = zeros(Mesh_Size, Mesh_Size);

for column = 1:Mesh_Size
    theta = CHIME_Theta - Angle_Range + (Angle_Range*column*2/Mesh_Size);
    for row = 1:Mesh_Size
        phi = CHIME_Phi - Angle_Range + (Angle_Range*row*2/Mesh_Size);
        
        r = Earths_Mean_Radius + Altitude_Vector_Field;
        [x, y, z] = sph2cart(deg2rad(phi), deg2rad(theta), r);
        x_matrix(row, column) = x;
        y_matrix(row, column) = y;
        z_matrix(row, column) = z;
        
        [Br ,Bt, Bp] = IGRF_Model(r, theta, phi,Days_since_Jan_1st_2015);
        [Bx, By, Bz] = sph2cart(Bp, Bt, Br);
        Bx_matrix(row, column) = Bx;
        By_matrix(row, column) = By;
        Bz_matrix(row, column) = Bz;
    end
end


%   plot vector field, Earth and CHIME
figure;
quiver3(x_matrix, y_matrix, z_matrix, Bx_matrix, By_matrix, Bz_matrix)
hold on
[x_earth, y_earth, z_earth] = sphere(200);

colormap summer
shading interp
Earth=surfl(Earths_Mean_Radius*x_earth,Earths_Mean_Radius*y_earth,Earths_Mean_Radius*z_earth);
set(Earth, 'edgecolor','none');
hold on
[CHIME_Cart_x, CHIME_Cart_y, CHIME_Cart_z] = sph2cart(deg2rad(CHIME_Phi), deg2rad(CHIME_Theta), Earths_Mean_Radius+0.05);
[x_CHIME, y_CHIME, z_CHIME] = sphere(200);
shading interp
CHIME=surfl(50*x_CHIME+CHIME_Cart_x,50*y_CHIME+CHIME_Cart_y,50*z_CHIME+CHIME_Cart_z);



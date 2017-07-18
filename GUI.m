function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 18-Jul-2017 03:50:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Launch_Date_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Launch_Date_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Launch_Date_Input as text
%        str2double(get(hObject,'String')) returns contents of Launch_Date_Input as a double


% --- Executes during object creation, after setting all properties.
function Launch_Date_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Launch_Date_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Orbital_Interval_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Orbital_Interval_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Orbital_Interval_Input as text
%        str2double(get(hObject,'String')) returns contents of Orbital_Interval_Input as a double


% --- Executes during object creation, after setting all properties.
function Orbital_Interval_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Orbital_Interval_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Semimajor_Axis_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Semimajor_Axis_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Semimajor_Axis_Input as text
%        str2double(get(hObject,'String')) returns contents of Semimajor_Axis_Input as a double


% --- Executes during object creation, after setting all properties.
function Semimajor_Axis_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Semimajor_Axis_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Inclination_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Inclination_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Inclination_Input as text
%        str2double(get(hObject,'String')) returns contents of Inclination_Input as a double


% --- Executes during object creation, after setting all properties.
function Inclination_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Inclination_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Eccentricity_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Eccentricity_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Eccentricity_Input as text
%        str2double(get(hObject,'String')) returns contents of Eccentricity_Input as a double


% --- Executes during object creation, after setting all properties.
function Eccentricity_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Eccentricity_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Num_of_Orbits_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Num_of_Orbits_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_of_Orbits_Input as text
%        str2double(get(hObject,'String')) returns contents of Num_of_Orbits_Input as a double


% --- Executes during object creation, after setting all properties.
function Num_of_Orbits_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_of_Orbits_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Arg_of_Perigee_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Arg_of_Perigee_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Arg_of_Perigee_Input as text
%        str2double(get(hObject,'String')) returns contents of Arg_of_Perigee_Input as a double


% --- Executes during object creation, after setting all properties.
function Arg_of_Perigee_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Arg_of_Perigee_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RAAN_Input_Callback(hObject, eventdata, handles)
% hObject    handle to RAAN_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RAAN_Input as text
%        str2double(get(hObject,'String')) returns contents of RAAN_Input as a double


% --- Executes during object creation, after setting all properties.
function RAAN_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RAAN_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Inertia_Tensor_Input_CreateFcn(hObject, eventdata, handles)
% set the tables 'Data' property to a cell array of empty matrices. 
% The size of the cell array determines the number of rows and columns in the table.
set(hObject, 'Data', cell(3));
set(hObject, 'RowName', {'X', 'Y', 'Z'}, 'ColumnName', {'X', 'Y', 'Z'});
% hObject    handle to Inertia_Tensor_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Run_Simulation.
function Run_Simulation_Callback(hObject, eventdata, handles)
Msg_Box = msgbox('Running Simulation');
Launch_Date = datetime(get(handles.Launch_Date_Input, 'string'),'InputFormat','dd-MMM-yyyy HH:mm:ss');
Eccentricity = str2double(get(handles.Eccentricity_Input, 'string'));
Inclination = str2double(get(handles.Inclination_Input, 'string'));
Semimajor_Axis = str2double(get(handles.Semimajor_Axis_Input, 'string'));
Orbital_Interval = str2double(get(handles.Orbital_Interval_Input, 'string'));
RAAN = str2double(get(handles.RAAN_Input, 'string'));
Arg_of_Perigee = str2double(get(handles.Arg_of_Perigee_Input, 'string'));
Num_of_Orbits = str2double(get(handles.Num_of_Orbits_Input, 'string'));
Magnetic_Moment = [1; 1; 1];
Results = Model_Executor(Launch_Date, Eccentricity, Inclination, Semimajor_Axis, Orbital_Interval, RAAN, Arg_of_Perigee, Num_of_Orbits, Magnetic_Moment);
assignin('base', 'Results', Results);
axes(handles.Main_Plot)

cla reset;

All_Items = get(handles.Plot_Controller, 'string');
Selected_Index = get(handles.Plot_Controller, 'Value');
Selected_Item = All_Items{Selected_Index};

if isequal(Selected_Item, 'ECEF')
    plot3(Results(:,8),Results(:,9),Results(:,10))
end
if isequal(Selected_Item, 'ECI')
    plot3(Results(:,5), Results(:,6), Results(:,7))
end
hold on
x = line([0 10000000],[0,0],[0,0],'color','r');
y = line([0 0],[0,10000000],[0,0],'color','g');
z = line([0 0],[0,0],[0,10000000],'color','b');
if(get(handles.Plot_Earth, 'Value') == 1)
    hold on
    [x_earth, y_earth, z_earth] = sphere(200);
    colormap summer
    shading interp
    Earth=surfl(6371000*x_earth,6371000*y_earth,6371000*z_earth);
    set(Earth, 'edgecolor','none');
end
if(get(handles.Plot_CHIME, 'Value') == 1)
    hold on
    %   CHIME Coordinates: 	49° 19? 15.6? N, 119° 37? 26.4? W
    %   49.321 (theta),-119.624 (phi) or 240.376
    [CHIME_Cart_x, CHIME_Cart_y, CHIME_Cart_z] = sph2cart(deg2rad(240.376), deg2rad(49.321), 6371050);
    [x_CHIME, y_CHIME, z_CHIME] = sphere(200);
    shading interp
    CHIME=surfl(50000*x_CHIME+CHIME_Cart_x,50000*y_CHIME+CHIME_Cart_y,50000*z_CHIME+CHIME_Cart_z);
end
delete(Msg_Box);
if isequal(Selected_Item, 'ECEF')
    hold on
    p = plot3(Results(1,8), Results(1, 9), Results(1, 10), 'o', 'MarkerFaceColor', 'red');
    hold off
    axis manual
    for k = 2:length(Results(:,8))
        p.XData = Results(k,8);
        p.YData = Results(k,9);
        p.ZData = Results(k,10);
        set(handles.Timer, 'string', datestr(Launch_Date + seconds(Results(k,4))));
        pause(0.05)
        drawnow;
    end
end
if isequal(Selected_Item, 'ECI')
    hold on
    p = plot3(Results(1,5), Results(1, 6), Results(1, 7), 'o', 'MarkerFaceColor', 'red');
    hold off
    axis manual
    for k = 2:length(Results(:,5))
        p.XData = Results(k,5);
        p.YData = Results(k,7);
        p.ZData = Results(k,8);
        set(handles.Timer, 'string', datestr(Launch_Date + seconds(Results(k,4))));
        pause(0.05)
        drawnow;
    end
end
% hObject    handle to Run_Simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Main_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Main_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Main_Plot


% --- Executes on button press in Raw_Data_To_csv.
function Raw_Data_To_csv_Callback(hObject, eventdata, handles)
% hObject    handle to Raw_Data_To_csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Plot_Earth.
function Plot_Earth_Callback(hObject, eventdata, handles)
% hold on
%     [x_earth, y_earth, z_earth] = sphere(200);
%     colormap summer
%     shading interp
%     Earth=surfl(6371000*x_earth,6371000*y_earth,6371000*z_earth);
%     set(Earth, 'edgecolor', 'none');
%     set(gcf,'renderer','opengl'); 
%     alphaVal = x_earth;
%     set(Earth,  'texturemap', 'AlphaDataMapping', 'none', 'AlphaData', alphaVal);
% if(get(handles.Plot_Earth, 'Value') == 0)
%     %set(Earth, 'facecolor', 'none');
%     alpha(Earth, 0);
% end
% hObject    handle to Plot_Earth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
% Hint: get(hObject,'Value') returns toggle state of Plot_Earth


% --- Executes on button press in Plot_CHIME.
function Plot_CHIME_Callback(hObject, eventdata, handles)
% hold on
%     %   CHIME Coordinates: 	49° 19? 15.6? N, 119° 37? 26.4? W
%     %   49.321 (theta),-119.624 (phi) or 240.376
%     [CHIME_Cart_x, CHIME_Cart_y, CHIME_Cart_z] = sph2cart(deg2rad(240.376), deg2rad(49.321), 6371050);
%     [x_CHIME, y_CHIME, z_CHIME] = sphere(200);
%     shading interp
%     CHIME=surfl(50000*x_CHIME+CHIME_Cart_x,50000*y_CHIME+CHIME_Cart_y,50000*z_CHIME+CHIME_Cart_z);
%     set(gcf,'renderer','opengl'); 
%     %set(CHIME,'FaceAlpha',  'texturemap', 'AlphaDataMapping', 'none', 'AlphaData');
% if(get(handles.Plot_CHIME, 'Value') == 0)
%     set(CHIME, 'edgecolor', 'none');
% end
% hObject    handle to Plot_CHIME (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of Plot_CHIME


% --- Executes on selection change in Plot_Controller.
function Plot_Controller_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Controller (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Plot_Controller contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plot_Controller


% --- Executes during object creation, after setting all properties.
function Plot_Controller_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plot_Controller (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Timer_Callback(hObject, eventdata, handles)
% hObject    handle to Timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Timer as text
%        str2double(get(hObject,'String')) returns contents of Timer as a double


% --- Executes during object creation, after setting all properties.
function Timer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Timer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_Config.
function Load_Config_Callback(hObject, eventdata, handles)
[FileName, PathName] = uigetfile('*.ini', 'Select Model Configuration File')
ini = IniConfig();
ini.ReadFile(strcat(PathName, FileName))
% sections = ini.GetSections()
% keys = ini.GetKeys(sections{1})
% values = ini.GetValues(sections{1}, keys)

set(handles.Orbital_Interval_Input, 'string', num2str(ini.GetValues('Model', 'Orbit_Interval')));
set(handles.Num_of_Orbits_Input, 'string', num2str(ini.GetValues('Model', 'Num_Orbits')));
set(handles.Eccentricity_Input, 'string', num2str(ini.GetValues('Orbit', 'Eccentricity')));
set(handles.Inclination_Input, 'string', num2str(ini.GetValues('Orbit', 'Inclination')));
set(handles.Semimajor_Axis_Input, 'string', num2str(ini.GetValues('Orbit', 'Semimajor_Axis')));
set(handles.RAAN_Input, 'string', num2str(ini.GetValues('Orbit', 'RAAN')));
set(handles.Arg_of_Perigee_Input, 'string', num2str(ini.GetValues('Orbit', 'Arg_of_Perigee')));
% hObject    handle to Load_Config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

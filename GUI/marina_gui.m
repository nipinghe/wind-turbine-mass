function varargout = marina_gui(varargin)
% MARINA_GUI MATLAB code for marina_gui.fig
%      MARINA_GUI, by itself, creates a new MARINA_GUI or raises the existing
%      singleton*.
%
%      H = MARINA_GUI returns the handle to a new MARINA_GUI or the handle to
%      the existing singleton*.
%
%      MARINA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARINA_GUI.M with the given input arguments.
%
%      MARINA_GUI('Property','Value',...) creates a new MARINA_GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before marina_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to marina_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help marina_gui

% Last Modified by GUIDE v2.5 21-Aug-2012 16:40:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @marina_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @marina_gui_OutputFcn, ...
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

% --- Executes just before marina_gui is made visible.
function marina_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to marina_gui (see VARARGIN)

% Choose default command line output for marina_gui
handles.output = hObject;

%DEFAULT VARIABLES
%handles.generator='PMG';        %Induction Generator

%Write initial values
set(handles.power,'string',num2str(3.0));
set(handles.speed,'string',num2str(14));


%generator type
handles.val.generator='IG';  %default generator type induction generator

%Modify Gearbox Options
set(handles.DD, 'Enable', 'off');
set(handles.hydraulic_gear, 'Enable', 'off');       

%cooling
handles.val.cooling='air';

%gearbox
handles.val.gearbox='multi_stage';

%Get initial values to val argument
handles.val.power=str2double(get(handles.power, 'String'));
handles.val.speed=str2double(get(handles.speed, 'String'));
% 
% handles.pair_type = get(hObject,'tag');
% guidata(hObject, handles);


% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes marina_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%ARKA PLAN RESMI EKLEMECE
% create an axes that spans the whole gui
%ah = axes('unit', 'normalized', 'position', [0.6 0.5 0.35 0.4]); 
% import the background image and show it on the axes
%bg = imread('./images/DFIG_3G.png'); imagesc(bg);
% prevent plotting over the background and turn the axis off
%set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
%uistack(ah, 'bottom');

axes(handles.ViewBox1);
image1=imread('./images/DFIG_3G.png');
image(image1);
axis off;
axis image;
%imshow(image1);
 

% --- Outputs from this function are returned to the command line.
function varargout = marina_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of power as text
%        str2double(get(hObject,'String')) returns contents of power as a double
handles.val.power = str2double(get(hObject, 'String'));
if isnan(handles.val.power)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed as text
%        str2double(get(hObject,'String')) returns contents of speed as a double
handles.val.speed = str2double(get(hObject, 'String'));
if isnan(handles.val.speed)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new speed value
guidata(hObject,handles)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%GEARBOX
%gearbox(gear_ratio,torque,speed)
%input torque
torque=handles.val.power*30/(pi*handles.val.speed)*1e6;  %Torque(Nm)= Power/w

switch handles.val.gearbox % Generator Type
    case 'DD'
        handles.val.gearbox_mass=0;
        handles.val.gearbox_efficiency=1;
        handles.val.generator_speed=handles.val.speed; %Generator speed same with turbine speed
        
    case 'single_stage'  %UPDATE
        handles.val.gear_ratio=4.84*handles.val.power^0.26; %function of gear ratio as a function of power from Upwind Report
        handles.val.generator_speed=handles.val.gear_ratio*handles.val.speed;

        [handles.val.gearbox_efficiency,handles.val.gearbox_mass,handles.val.gearbox_cost]=gearbox(handles.val.gear_ratio,torque,handles.val.speed);
        
    case 'multi_stage'
        handles.val.generator_speed=1500; %assume a 1500 rpm machine
        handles.val.gear_ratio=handles.val.generator_speed/handles.val.speed; 
        
        [handles.val.gearbox_efficiency,handles.val.gearbox_mass,handles.val.gearbox_cost]=gearbox(handles.val.gear_ratio,torque,handles.val.speed);
    
    case 'hydraulic_gear'   
        handles.val.generator_speed=1500; %assume a 1500 rpm synchronous machine
        handles.val.gearbox_mass=10;
        [handles.val.gearbox_efficiency,handles.val.gearbox_mass]=hydraulic(handles.val.power,handles.val.speed);
end

set(handles.gearbox_mass, 'string', num2str(handles.val.gearbox_mass));  


%GENERATOR
switch handles.val.generator % Generator Type
    case 'IG'
        [handles.val.generator_mass,handles.val.generator_efficiency]=induction_generator(handles.val.power,handles.val.generator_speed,handles.val.cooling);
        % Code for when radiobutton1 is selected.
    case 'PMG'
        [handles.val.generator_mass,handles.val.generator_efficiency]=pm_generator(handles.val.power,handles.val.generator_speed,handles.val.cooling);
        
        % Code for when radiobutton2 is selected.
    case 'SG'
        [handles.val.generator_mass,handles.val.generator_efficiency]=eesg_generator(handles.val.power,handles.val.generator_speed,handles.val.cooling);
        % Code for when togglebutton1 is selected.
    case 'hts'
        % Code for when togglebutton2 is selected.
        [handles.val.generator_mass,handles.val.generator_efficiency]=superconducting_generator(handles.val.power,handles.val.speed);
    % Continue with more cases as necessary.
    otherwise
        % Code for when there is no match.
end

set(handles.generator_mass, 'string', num2str(handles.val.generator_mass));


%BEARING
handles.val.bearing_mass=main_bearing(handles.val.power);
set(handles.bearing_mass, 'string', num2str(handles.val.bearing_mass));

%LOW SPEED SHAFT
%cost may be added
if strcmp(handles.val.gearbox,'DD')
    handles.val.shaft_mass=0;
else
    handles.val.shaft_mass=low_speed_shaft(handles.val.power);
end
set(handles.shaft_mass, 'string', num2str(handles.val.shaft_mass));


%Calculate total mass
handles.val.total_mass=round(10*(handles.val.gearbox_mass+handles.val.generator_mass+handles.val.bearing_mass+handles.val.shaft_mass)/1000)/10;
set(handles.total_mass, 'string', num2str(handles.val.total_mass));

%Write Efficiency Values
set(handles.gearbox_eff, 'string', num2str(100*handles.val.gearbox_efficiency));
set(handles.generator_eff, 'string', num2str(100*handles.val.generator_efficiency));
%Overall efficiency
set(handles.total_eff, 'string', num2str(round(100*100*handles.val.generator_efficiency*handles.val.gearbox_efficiency)/100));

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Reset default values
%DEFAULT VARIABLES
%handles.generator='PMG';        %Induction Generator

%Write initial values
set(handles.power,'string',num2str(3.0));
set(handles.speed,'string',num2str(14));


%generator type
handles.val.generator='IG';  %default generator type induction generator
set(handles.IG, 'Value', 1);

%Modify Gearbox Options
set(handles.DD, 'Enable', 'off');
set(handles.hydraulic_gear, 'Enable', 'off');       

%cooling
handles.val.cooling='air';
set(handles.air, 'Value', 1);
%gearbox
handles.val.gearbox='multi_stage';
set(handles.multi_stage, 'Value', 1);

%Get initial values to val argument
handles.val.power=str2double(get(handles.power, 'String'));
handles.val.speed=str2double(get(handles.speed, 'String'));


%update image
axes(handles.ViewBox1);
image1=imread('./images/DFIG_3G.png');
image(image1);
axis off;
axis image;

calculate_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function gearbox_eff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gearbox_eff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function generator_eff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to generator_eff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function total_eff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_eff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function gearbox_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gearbox_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function generator_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to generator_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function bearing_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bearing_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function total_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in generator.
function generator_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in generator 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'IG'
        handles.val.generator='IG';
        %Modify Gearbox Options
        set(handles.DD, 'Enable', 'off');
        set(handles.single_stage, 'Enable', 'on');
        set(handles.multi_stage, 'Enable', 'on');
        set(handles.hydraulic_gear, 'Enable', 'off');
        
        %enable cooling
        set(handles.air, 'Enable', 'on');
        set(handles.water, 'Enable', 'on');
                
        set(handles.multi_stage, 'Value', 1);
        handles.val.gearbox='multi_stage';
        
        %update image
        image1=imread('./images/DFIG_3G.png');
 
    case 'PMG'
        handles.val.generator='PMG';
        %Modify Gearbox Options
        set(handles.DD, 'Enable', 'on');
        set(handles.single_stage, 'Enable', 'on');
        set(handles.multi_stage, 'Enable', 'on');
        set(handles.hydraulic_gear, 'Enable', 'off');
        
        %disable cooling
        set(handles.air, 'Enable', 'off');
        set(handles.water, 'Enable', 'off');
        
        set(handles.DD, 'Value', 1);            
        handles.val.gearbox='DD';
        %update image
        image1=imread('./images/DDPMG.png');
      
    case 'SG'
        handles.val.generator='SG';
        %Modify Gearbox Options
        set(handles.DD, 'Enable', 'on');
        set(handles.single_stage, 'Enable', 'off');
        set(handles.multi_stage, 'Enable', 'on');
        set(handles.hydraulic_gear, 'Enable', 'on');    
        
        %enable cooling
        set(handles.air, 'Enable', 'on');
        set(handles.water, 'Enable', 'on');
                
        set(handles.multi_stage, 'Value', 1);
        handles.val.gearbox='multi_stage';

        %update image                
        image1=imread('./images/EESG_3G.png');

    case 'hts'
        handles.val.generator='hts';       
        %Modify Gearbox Options
        set(handles.DD, 'Enable', 'on');
        set(handles.single_stage, 'Enable', 'off');
        set(handles.multi_stage, 'Enable', 'off');
        set(handles.hydraulic_gear, 'Enable', 'off');
        
        %disable cooling
        set(handles.air, 'Enable', 'off');
        set(handles.water, 'Enable', 'off');
        
        %default selection
        set(handles.DD, 'Value', 1);
        handles.val.gearbox='DD';
        %update image
        image1=imread('./images/HTSG.png');
end

        %plot image
        axes(handles.ViewBox1);
        image(image1);
        axis off;
        axis image;
        
guidata(hObject,handles)


% --- Executes when selected object is changed in cooling.
function cooling_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in cooling 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'air'
        handles.val.cooling='air';
       % Code for when radiobutton1 is selected.
    case 'water'
        handles.val.cooling='water';
        % Code for when radiobutton2 is selected.
    otherwise
        % Code for when there is no match.
end
guidata(hObject,handles)


% --- Executes when selected object is changed in gearbox.
function gearbox_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in gearbox 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    
    case 'DD'
        handles.val.gearbox='DD';
        %Generator type
        %update image
        switch handles.val.generator
            case 'SG'
                 image1=imread('./images/EESG.png');      
            case 'PMG'
                  image1=imread('./images/DDPMG.png');
            case 'hts'
                  image1=imread('./images/HTSG.png');
        end                
        
    case 'single_stage'
        handles.val.gearbox='single_stage';
        
        %update image
        switch handles.val.generator
            case 'IG'
                 image1=imread('./images/DFIG_1G.png');      
            case 'PMG'
                  image1=imread('./images/PMG_1G.png');
        end

                    

    case 'multi_stage'
        handles.val.gearbox='multi_stage';
        
        %update image
        switch handles.val.generator
            case 'SG'
                 image1=imread('./images/EESG_3G.png');      
            case 'PMG'
                  image1=imread('./images/PMG_3G.png');
            case 'IG'
                  image1=imread('./images/DFIG_3G.png');
        end
        % Code for when togglebutton1 is selected.
    case 'hydraulic_gear'
        handles.val.gearbox='hydraulic_gear';
        %update image
        image1=imread('./images/EESG_hydraulics.png');
        % Code for when togglebutton2 is selected.
    % Continue with more cases as necessary.
    otherwise
        % Code for when there is no match.
end
           %Write image     
           axes(handles.ViewBox1);
           image(image1);
           axis off;
           axis image;
guidata(hObject,handles)

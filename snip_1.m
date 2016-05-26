function varargout = snip_1(varargin)
% SNIP_1 MATLAB code for snip_1.fig
%      SNIP_1, by itself, creates a new SNIP_1 or raises the existing
%      singleton*.
%
%      H = SNIP_1 returns the handle to a new SNIP_1 or the handle to
%      the existing singleton*.
%
%      SNIP_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SNIP_1.M with the given input arguments.
%
%      SNIP_1('Property','Value',...) creates a new SNIP_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before snip_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to snip_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help snip_1

% Last Modified by GUIDE v2.5 26-May-2016 20:48:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @snip_1_OpeningFcn, ...
                   'gui_OutputFcn',  @snip_1_OutputFcn, ...
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



% --- Executes just before snip_1 is made visible.
function snip_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to snip_1 (see VARARGIN)

% Choose default command line output for snip_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global ROOT_PATH


fp = fopen('annotation.config', 'r');
ROOT_PATH = fscanf(fp, '%s');


% UIWAIT makes snip_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = snip_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% edit object name
function edit_object_Callback(hObject, eventdata, handles)
% hObject    handle to edit_object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_object as text
%        str2double(get(hObject,'String')) returns contents of edit_object as a double
global object_name
object_name = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit_object_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% start button
% --- Executes on button press in Start_button.
function Start_button_Callback(hObject, eventdata, handles)
% hObject    handle to Start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name object_affordance object_path image_path ...
    object_link object_coord object_v_check I I2
% initiate default values
object_name = 0;
object_affordance = 0;
object_path = 0;
image_path = 0;
object_link = 0;
object_coord = 0;
object_v_check = 0;

% crop image
t = java.awt.Toolkit.getDefaultToolkit();
rectangle = java.awt.Rectangle(t.getScreenSize());
robo = java.awt.Robot;
image1 = robo.createScreenCapture(rectangle);
% save screenshot
filehandle = java.io.File('full_scr');
javax.imageio.ImageIO.write(image1,'jpg',filehandle);
% rename
% % movefile('tester',[object_name,'.jpg']);
% crop
% % I = imread([object_name,'.jpg']);
I = imread('full_scr');
I2 = imcrop(I);
imshow(I2);

% --- Executes on key press with focus on Start_button and none of its controls.
function Start_button_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Start_button (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
global object_affordance
object_affordance = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function url_link_Callback(hObject, eventdata, handles)
% hObject    handle to url_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of url_link as text
%        str2double(get(hObject,'String')) returns contents of url_link as a double
global object_link
object_link = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function url_link_CreateFcn(hObject, eventdata, handles)
% hObject    handle to url_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global object_v_check
object_v_check = get(hObject,'Value');


% save button
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name I2 object_affordance object_path image_path object_link object_coord...
    object_v_check  rootdb ROOT_PATH rect_obj rect_pose

% delete the intermediate file
try
    load('rootdb.mat');
catch
    warning('no database present, a new database is created')
end

%imwrite(I2,[object_name,'.png']);
imwrite(I2,[ROOT_PATH,'\',object_name,'.png']);
object_path = [ROOT_PATH,'\',object_name,'.png'];
%object_path = which([object_name,'.png']);

[x,y,z] = size(I2);
rootdb.db.(object_name).width = y;
rootdb.db.(object_name).height = x;
rootdb.db.(object_name).affordance = object_affordance;
rootdb.db.(object_name).obj_path = object_path;
rootdb.db.(object_name).image_path = image_path;
rootdb.db.(object_name).link = object_link;
% % rootdb.db.(object_name).coord = object_coord;
rootdb.db.(object_name).video_check = object_v_check;
rootdb.db.(object_name).pos_obj = rect_obj;
rootdb.db.(object_name).pos_pose = rect_pose;
save('rootdb.mat','rootdb');
delete('full_scr');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_obj
h_obj = imrect;
rect_obj = getPosition(h_obj);
% rect_obj = getrect;
% rectangle('Position', rect_obj, 'EdgeColor', 'b');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_pose
h_pose = imrect;
rect_pose = getPosition(h_pose);
% rect_pose = getrect;
% rectangle('Position', rect_pose, 'EdgeColor', 'r');

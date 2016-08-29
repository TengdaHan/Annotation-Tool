<<<<<<< HEAD
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

% Last Modified by GUIDE v2.5 16-Aug-2016 18:28:09

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

global ROOT_PATH object_name object_affordance ...
    file_path image_path object_link object_coord object_v_check rect_obj...
    rect_pose wrist1_xy wrist2_xy ...
    elbow1_xy elbow2_xy shoulder1_xy shoulder2_xy head_xy ...
    toggle_state frame_index_start frame_index_end
fp = fopen('annotation.config', 'r');
ROOT_PATH = fscanf(fp, '%s');
object_name = [];
object_affordance = [];

file_path = 0;
image_path = 0;
object_link = 0;
object_coord = 0;
object_v_check = 0;

rect_obj = [];
rect_pose = [];
wrist1_xy = [];
wrist2_xy = [];
elbow1_xy = [];
elbow2_xy = [];
shoulder1_xy = [];
shoulder2_xy = [];
head_xy = [];

toggle_state = 0;
frame_index_start = 0;
frame_index_end = 0;

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

% start button
% --- Executes on button press in start_screenshot.
function start_screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to start_screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2 file_index
% initiate default values
file_index = 0;
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
state_str = sprintf('%s\n%s','Got screenshot,','You can crop now.');
set(handles.state_text,'String',state_str);

I = imread('full_scr');
I2 = imcrop(I);
imshow(I2);
delete('full_scr');
state_str = sprintf('%s\n%s','Image cropped,','You can annotate now.');
set(handles.state_text,'String',state_str);

% --- Executes on key press with focus on start_screenshot and none of its controls.
function start_screenshot_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to start_screenshot (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

function edit_url_Callback(hObject, eventdata, handles)
% hObject    handle to edit_url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_url as text
%        str2double(get(hObject,'String')) returns contents of edit_url as a double
global object_link
object_link = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit_url_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_video.
function checkbox_video_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state_text of checkbox_video
global object_v_check
object_v_check = get(hObject,'Value');


% save button
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name I I2 object_affordance file_path image_path object_link ...
    object_v_check  rootdb ROOT_PATH rect_obj rect_pose wrist1_xy wrist2_xy ...
    elbow1_xy elbow2_xy shoulder1_xy shoulder2_xy head_xy ...
    file_index filename_cell folder_name img_path video_path frame_index ...

%load database
try
    load('rootdb.mat');
catch
    helpdlg('no database present, a new database is created', 'Info');
    rootdb = struct;
end

%check object_name is not None
if isempty(object_name);
    helpdlg('Object Name is not provided','Info');
    return
end

% %check repeated object name
% if isfield(rootdb.name, object_name);
%     rootdb.name.(object_name) = rootdb.name.(object_name)+1;
% else
%     helpdlg('New Object Name Detected','Info');
%     rootdb.name.(object_name) = 1;
% end
% 
% %auto-name
% object_name_n = strcat(object_name,num2str(rootdb.name.(object_name)));

%save file
if not (isempty(I2)); %crop image mode
    try
        %imwrite(I2,fullfile(ROOT_PATH,[object_name_n,'.png']));
        imwrite(I2,fullfile(ROOT_PATH,[object_name,'.png']));
    catch
        mkdir(ROOT_PATH);
        %imwrite(I2,fullfile(ROOT_PATH,[object_name_n,'.png']));
        imwrite(I2,fullfile(ROOT_PATH,[object_name,'.png']));
        helpdlg(['Directory "',ROOT_PATH,'" is created'],'Info');
    end
    %get path
    %file_path = fullfile(ROOT_PATH,[object_name_n,'.png']);
    file_path = fullfile(ROOT_PATH,[object_name,'.png']);
    [~,file_name,~] = fileparts(file_path);
    [x,y,~] = size(I2);
    clear I2;
else
    if not (isempty(frame_index)); %load video mode
        file_path = video_path;
    elseif file_index == 0; %load image mode
        file_path = img_path;
    else %load folder mode
        file_path = fullfile(folder_name,filename_cell{1,file_index});
    end
    [~,file_name,~] = fileparts(file_path);
    [x,y,~] = size(I);
end

%save info to database
% for i = 1:length(object_name);
%     rootdb.db.(file_path).(object_name(i)) = struct;
%     rootdb.db.(file_path).(object_name(i)).affordance = strsplit(object_affordance(i),',');
%     rootdb.db.(file_path).(object_name(i)).position = rect_obj(i);
% end
rootdb.db.(file_name).object(1)=struct;
rootdb.db.(file_name).object(1).name = object_name;
rootdb.db.(file_name).object(1).affordance = strsplit(object_affordance,',');
rootdb.db.(file_name).object(1).position = rect_obj;

rootdb.db.(file_name).width = y;
rootdb.db.(file_name).height = x;

rootdb.db.(file_name).image_path = image_path;
rootdb.db.(file_name).link = object_link;
rootdb.db.(file_name).video_check = object_v_check;
rootdb.db.(file_name).frame = frame_index;

rootdb.db.(file_name).pos_pose = rect_pose;
rootdb.db.(file_name).wrist_L = wrist1_xy;
rootdb.db.(file_name).wrist_R = wrist2_xy;
rootdb.db.(file_name).elbow_L = elbow1_xy;
rootdb.db.(file_name).elbow_R = elbow2_xy;
rootdb.db.(file_name).shoulder_L = shoulder1_xy;
rootdb.db.(file_name).shoulder_R = shoulder2_xy;
rootdb.db.(file_name).head = head_xy;

save('rootdb.mat','rootdb');

rect_obj = [];
rect_pose = [];
wrist1_xy = [];
wrist2_xy = [];
elbow1_xy = [];
elbow2_xy = [];
shoulder1_xy = [];
shoulder2_xy = [];
head_xy = [];

%check whether screenshot mode or file loading mode
if file_index == 0;
    state_str = sprintf('%s','Annotation saved.');
    set(handles.state_text,'String',state_str);
    return
else
    file_index = file_index + 1;
    if file_index > length(filename_cell);
        helpdlg('All Files in Current Folder are Loaded','Success');
        return
    end
    index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
    set(handles.index_text,'String',index_str);
    state_str = sprintf('%s\n%s\n%s','Annotation saved,','Click "Crop" to crop,','Or Click "Skip & Next".');
    set(handles.state_text,'String',state_str);
    
    I = imread(fullfile(folder_name,filename_cell{1,file_index}));
    imshow(I);
%     I2 = imcrop(I);
%     imshow(I2);
end


% --- Executes on button press in object_box.
function object_box_Callback(hObject, eventdata, handles)
% hObject    handle to object_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_obj
h_obj = imrect;
h_obj_child = get(h_obj, 'Children');
%get handle for context menu of imrect
h_obj_cmenu = get(h_obj_child(1),'UIContextMenu');
%add properties in context menu of imrect
itemnew = uimenu(h_obj_cmenu, 'Label', 'Properties','Callback', @obj_properties);
rect_obj = [rect_obj; getPosition(h_obj)];

function obj_properties(hObject, eventdata, handles)
global object_name object_affordance 
prompt = {'Object Name:','Object Affordance:'};
dlg_title = 'Object';
num_lines = [1,40];
if isempty(object_name);
    defaultans = {'',''};
else
    defaultans = {object_name,object_affordance};
end

answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer);
    return
else
    if not (isempty(answer{1,1}));
        object_name = lower(answer{1,1});
        object_affordance = lower(answer{2,1});
    else
        return 
    end
end



% --- Executes on button press in posture_box.
function posture_box_Callback(hObject, eventdata, handles)
% hObject    handle to posture_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_pose
h_pose = imrect;
h_pose_child = get(h_pose, 'Children');
%get handle for context menu of imrect
h_pose_cmenu = get(h_pose_child(1),'UIContextMenu');
%add properties in context menu of imrect
itemnew = uimenu(h_pose_cmenu, 'Label', 'Posture Info','Callback', @pose_info);
rect_pose = [rect_pose;getPosition(h_pose)];

function pose_info(hObject, eventdata, handles)
helpdlg('This is a rectangle for human posture','Info');


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function view_annotation_Callback(hObject, eventdata, handles)
% hObject    handle to view_annotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ROOT_PATH rootdb
[anno_name,path_name] = uigetfile('*.*','View Annotation: Select the image',ROOT_PATH);
if isempty(anno_name);
    return
end

[~,anno_filename,~] = fileparts(anno_name);

imshow(fullfile(path_name,anno_name));

rectangle('Position',rootdb.db.(anno_filename).object(1).position,'Edgecolor','b');
if not (isempty(rootdb.db.(anno_filename).pos_pose));
    rectangle('Position',rootdb.db.(anno_filename).pos_pose,'Edgecolor','r');
end
%display wrist
if not (isempty(rootdb.db.(anno_filename).wrist_L));
    h_wrist1 = impoint(gca,rootdb.db.(anno_filename).wrist_L);
    setColor(h_wrist1,'r');
    setString(h_wrist1,'L');
end

if not (isempty(rootdb.db.(anno_filename).wrist_R));
    h_wrist2 = impoint(gca,rootdb.db.(anno_filename).wrist_R);
    setColor(h_wrist2,'r');
    setString(h_wrist2,'R');
end
%display elbow
if not (isempty(rootdb.db.(anno_filename).elbow_L));
    h_elbow1 = impoint(gca,rootdb.db.(anno_filename).elbow_L);
    setColor(h_elbow1,'y');
    setString(h_elbow1,'L');
end

if not (isempty(rootdb.db.(anno_filename).elbow_R));
    h_elbow2 = impoint(gca,rootdb.db.(anno_filename).elbow_R);
    setColor(h_elbow2,'y');
    setString(h_elbow2,'R');
end
%display shoulder
if not (isempty(rootdb.db.(anno_filename).shoulder_L));
    h_shoulder1 = impoint(gca,rootdb.db.(anno_filename).shoulder_L);
    setColor(h_shoulder1,'c');
    setString(h_shoulder1,'L');
end

if not (isempty(rootdb.db.(anno_filename).shoulder_R));
    h_shoulder2 = impoint(gca,rootdb.db.(anno_filename).shoulder_R);
    setColor(h_shoulder2,'c');
    setString(h_shoulder2,'R');
end
%display head
if not (isempty(rootdb.db.(anno_filename).head));
    h_head = impoint(gca,rootdb.db.(anno_filename).head);
    setColor(h_head,'m');
end
%setString(h_head,'head');
%display other info (TODO: affordance path etc.)
state_str = sprintf('%s\n%s%s','Annotation: ',anno_filename,' is loaded.');
set(handles.state_text,'String',state_str);

helpdlg({'Red --- Wrist' 'Yellow --- Elbow' 'Cyan --- Shoulder'...
     'Magenta --- Head'},'Info');


% --- Executes on button press in wrist1.
function wrist1_Callback(hObject, eventdata, handles)
% hObject    handle to wrist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrist1_xy
%uiwait(msgbox('Locate first wrist'));
h_wrist1 = impoint;
setColor(h_wrist1,'r');
setString(h_wrist1,'wrist-L');
wrist1_xy = getPosition(h_wrist1);

% --- Executes on button press in wrist2.
function wrist2_Callback(hObject, eventdata, handles)
% hObject    handle to wrist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrist2_xy
h_wrist2 = impoint;
setColor(h_wrist2,'r');
setString(h_wrist2,'wrist-R');
wrist2_xy = getPosition(h_wrist2);

% --- Executes on button press in elbow1.
function elbow1_Callback(hObject, eventdata, handles)
% hObject    handle to elbow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elbow1_xy
h_elbow1 = impoint;
setColor(h_elbow1,'y');
setString(h_elbow1,'elbow-L');
elbow1_xy = getPosition(h_elbow1);

% --- Executes on button press in elbow2.
function elbow2_Callback(hObject, eventdata, handles)
% hObject    handle to elbow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elbow2_xy
h_elbow2 = impoint;
setColor(h_elbow2,'y');
setString(h_elbow2,'elbow-R');
elbow2_xy = getPosition(h_elbow2);

% --- Executes on button press in shoulder1.
function shoulder1_Callback(hObject, eventdata, handles)
% hObject    handle to shoulder1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shoulder1_xy
h_shoulder1 = impoint;
setColor(h_shoulder1,'c');
setString(h_shoulder1,'shoulder-L');
shoulder1_xy = getPosition(h_shoulder1);

% --- Executes on button press in shoulder2.
function shoulder2_Callback(hObject, eventdata, handles)
% hObject    handle to shoulder2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shoulder2_xy
h_shoulder2 = impoint;
setColor(h_shoulder2,'c');
setString(h_shoulder2,'shoulder-R');
shoulder2_xy = getPosition(h_shoulder2);

% --- Executes on button press in head.
function head_Callback(hObject, eventdata, handles)
% hObject    handle to head (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global head_xy
h_head = impoint;
setColor(h_head,'m');
setString(h_head,'head');
head_xy = getPosition(h_head);

% --- Executes on button press in skip.
function skip_Callback(hObject, eventdata, handles)
% hObject    handle to skip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename_cell file_index I folder_name 
if file_index == 0;
    helpdlg('"Skip & Next" is Invalid in This Mode','Info');
    return
end

file_index = file_index + 1;
if file_index > length(filename_cell);
    helpdlg('All Files in Current Folder are Loaded','Success');
    return
end

index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
set(handles.index_text,'String',index_str);
state_str = sprintf('%s\n%s\n%s','You can annotate now,','or Click "Crop" to crop,','or Click "Skip & Next".');
set(handles.state_text,'String',state_str);

I = imread(fullfile(folder_name,filename_cell{1,file_index}));
imshow(I);

% --------------------------------------------------------------------
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I img_path file_index object_name
[filename,loadpath] = uigetfile('*.*','Source Selector');
if filename==0;
    return
else
    img_path = strcat(loadpath,filename);
    I = imread(img_path);
    axes(handles.axes2);
    imshow(I);
    state_str = sprintf('%s\n%s\n%s','Image loaded,','You can annotate now,','or Click "Crop" to crop.');
    set(handles.state_text,'String',state_str);
    file_index = 0;
    object_name = [];
    
end

% --- Executes during object creation, after setting all properties.
function load_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function load_folder_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2 filename_cell file_index folder_name
folder_name = uigetdir('C:\','Select Directory to Load');
if folder_name==0;
    return
else
    dir_info = dir(folder_name);
    dir_length = length(dir_info);
    filename_cell = cell(1,dir_length-2);
    for i = 3:dir_length;
        filename_cell{1,i-2} = dir_info(i).name;
    end
    I = imread(fullfile(folder_name,dir_info(i).name));
    imshow(I);
    I2 = [];
    
    file_index = 1;
    index_str = ['Index: ','1','/',num2str(dir_length-2)];
    set(handles.index_text,'String',index_str);
    
    state_str = sprintf('%s\n%s\n%s','You can annotate now.',' or Click "Crop" to crop,','Or click "Skip & Next".');
    set(handles.state_text,'String',state_str);
    
%     I2 = imcrop(I);
%     imshow(I2);
end

% --------------------------------------------------------------------
function load_video_Callback(hObject, eventdata, handles)
% hObject    handle to load_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nFrame v frame_index video_path
[filename,loadpath] = uigetfile('*.*','Source Selector');
if filename==0;
    return
else
    video_path = strcat(loadpath,filename);
    v = VideoReader(video_path);
    nFrame = v.NumberOfFrame;
    
    axes(handles.axes2);
    imshow(read(v,1));
    
    set(handles.slider, 'Min', 1);
    set(handles.slider, 'Max', nFrame);
    set(handles.slider, 'SliderStep', [1,10]/(nFrame-1));
    set(handles.slider, 'Value', 1); % set to beginning of sequence
    
    state_str = sprintf('%s\n%s\n%s','Video loaded,','Use slide bar to view and annotate,','then click "Save & Next".');
    set(handles.state_text,'String',state_str);
    
    frame_index = 1;
    index_str = ['1/',num2str(nFrame)];
    set(handles.index_text,'String',index_str);
end

% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name object_affordance file_path image_path ...
    object_link object_coord object_v_check next_flag ...
    I I2 rect_obj rect_pose wrist1_xy wrist2_xy elbow1_xy elbow2_xy...
    shoulder1_xy shoulder2_xy head_xy file_index filename_cell

index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
set(handles.index_text,'String',index_str);

state_str = sprintf('%s\n%s','Reset the annotation,','You can annotate now.');
set(handles.state_text,'String',state_str);

object_name = 0;
object_affordance = 0;
file_path = 0;
image_path = 0;
object_link = 0;
object_coord = 0;
object_v_check = 0;
clear I2 rect_obj rect_pose wrist1_xy wrist2_xy elbow1_xy elbow2_xy...
    shoulder1_xy shoulder2_xy head_xy

% I2 = imcrop(I);
% axes(handles.axes2);
% imshow(I2);
axes(handles.axes2);
imshow(I);
I2 = [];

% --- Executes during object creation, after setting all properties.
function index_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2
I2 = imcrop(I);
axes(handles.axes2);
imshow(I2);
state_str = sprintf('%s\n%s\n%s','Image cropped,','You can annotate now,','then click "Save & Next".');
set(handles.state_text,'String',state_str);


% --- Executes during object creation, after setting all properties.
function state_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to state_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global nFrame v I frame_index
%n = get(hObject, 'Value');
frame_index = round(hObject.Value);
hObject.Value = frame_index;
I = read(v,frame_index);
axes(handles.axes2);
imshow(I);

index_str = [num2str(frame_index),'/',num2str(nFrame)];
set(handles.index_text,'String',index_str);



% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in start_toggle.
function start_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to start_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start_toggle
global toggle_state frame_index frame_index_start frame_index_end
toggle_start = get(hObject,'Value');
if (toggle_state==0) && (toggle_start==1);
    frame_index_start = frame_index;
    toggle_state = 1;
    hObject.String = 'Stop';
elseif (toggle_state==1) && (toggle_start==0);
    frame_index_end = frame_index;
    toggle_state = 0;
    hObject.String = 'Start';
    if frame_index_end <= frame_index_start;
        helpdlg({'Frame Index Error : Ending frame index must be larger than starting frame index'},'Error');
        return
    end
    if isempty(frame_index_start) && isempty(frame_index_end);
        return
    end
    activity_annotation(hObject, eventdata, handles);
    helpdlg({'Save Tempral Action ?'; strcat('Starting frame = ',num2str(frame_index_start));
        strcat('ending frame = ',num2str(frame_index_end))},'Info');
else
    return
end

function activity_annotation(hObject, eventdata, handles)
global activity 
prompt = {'Activity:'};
dlg_title = 'Annotation';
num_lines = [1,40];
defaultans = {''};
activity = inputdlg(prompt,dlg_title,num_lines,defaultans);

% --- Executes on button press in video_cancel.
function video_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to video_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle_state frame_index_start frame_index_end
toggle_state = 0;
frame_index_start = 0;
frame_index_end = 0;


% --- Executes on button press in temporal_save.
function temporal_save_Callback(hObject, eventdata, handles)
% hObject    handle to temporal_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frame_index_start frame_index_end rootdb activity nFrame video_path
%load database
try
    load('rootdb.mat');
catch
    helpdlg('no database present, a new database is created', 'Info');
    rootdb = struct;
end
if isempty(activity);
    helpdlg('Activity name is not provided','Warning');
end
if not (isfield(rootdb, 'videodb'));
    rootdb.videodb = struct;
end

n = length(fieldnames(rootdb.videodb));
rootdb.videodb.activity(n+1).start_index = frame_index_start;
[h_start,m_start,s_start]=hms(seconds(round(frame_index_start/30,1)));
rootdb.videodb.activity(n+1).start_time = [h_start,m_start,s_start];

rootdb.videodb.activity(n+1).end_index = frame_index_end;
[h_end,m_end,s_end]=hms(seconds(round(frame_index_end/30,1)));
rootdb.videodb.activity(n+1).end_time = [h_end,m_end,s_end];

rootdb.videodb.activity(n+1).total_frame = nFrame;
[h_total,m_total,s_total]=hms(seconds(round(nFrame/30,1)));
rootdb.videodb.activity(n+1).total_time = [h_total,m_total,s_total];

rootdb.videodb.activity(n+1).action_label = activity;
rootdb.videodb.activity(n+1).video_path = video_path;

if not (isfield(rootdb, 'actions'));
    rootdb.actions = struct;
end

if isfield(rootdb.actions, activity{1,1});
    rootdb.actions.(activity{1,1}) = rootdb.actions.(activity{1,1}) + 1;
else
    rootdb.actions.(activity{1,1}) = 1;
end
save('rootdb.mat','rootdb');
state_str = sprintf('%s\n','Temporal Action Saved');
set(handles.state_text,'String',state_str);


=======
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

% Last Modified by GUIDE v2.5 16-Aug-2016 18:28:09

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

global ROOT_PATH object_name object_affordance ...
    file_path image_path object_link object_coord object_v_check rect_obj...
    rect_pose wrist1_xy wrist2_xy ...
    elbow1_xy elbow2_xy shoulder1_xy shoulder2_xy head_xy ...
    toggle_state frame_index_start frame_index_end
fp = fopen('annotation.config', 'r');
ROOT_PATH = fscanf(fp, '%s');
object_name = [];
object_affordance = [];

file_path = 0;
image_path = 0;
object_link = 0;
object_coord = 0;
object_v_check = 0;

rect_obj = [];
rect_pose = [];
wrist1_xy = [];
wrist2_xy = [];
elbow1_xy = [];
elbow2_xy = [];
shoulder1_xy = [];
shoulder2_xy = [];
head_xy = [];

toggle_state = 0;
frame_index_start = 0;
frame_index_end = 0;

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

% start button
% --- Executes on button press in start_screenshot.
function start_screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to start_screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2 file_index
% initiate default values
file_index = 0;
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
state_str = sprintf('%s\n%s','Got screenshot,','You can crop now.');
set(handles.state_text,'String',state_str);

I = imread('full_scr');
I2 = imcrop(I);
imshow(I2);
delete('full_scr');
state_str = sprintf('%s\n%s','Image cropped,','You can annotate now.');
set(handles.state_text,'String',state_str);

% --- Executes on key press with focus on start_screenshot and none of its controls.
function start_screenshot_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to start_screenshot (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

function edit_url_Callback(hObject, eventdata, handles)
% hObject    handle to edit_url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_url as text
%        str2double(get(hObject,'String')) returns contents of edit_url as a double
global object_link
object_link = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit_url_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_url (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_video.
function checkbox_video_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state_text of checkbox_video
global object_v_check
object_v_check = get(hObject,'Value');


% save button
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name I I2 object_affordance file_path image_path object_link ...
    object_v_check  rootdb ROOT_PATH rect_obj rect_pose wrist1_xy wrist2_xy ...
    elbow1_xy elbow2_xy shoulder1_xy shoulder2_xy head_xy ...
    file_index filename_cell folder_name img_path video_path frame_index ...

%load database
try
    load('rootdb.mat');
catch
    helpdlg('no database present, a new database is created', 'Info');
    rootdb = struct;
end

%check object_name is not None
if isempty(object_name);
    helpdlg('Object Name is not provided','Info');
    return
end

% %check repeated object name
% if isfield(rootdb.name, object_name);
%     rootdb.name.(object_name) = rootdb.name.(object_name)+1;
% else
%     helpdlg('New Object Name Detected','Info');
%     rootdb.name.(object_name) = 1;
% end
% 
% %auto-name
% object_name_n = strcat(object_name,num2str(rootdb.name.(object_name)));

%save file
if not (isempty(I2)); %crop image mode
    try
        %imwrite(I2,fullfile(ROOT_PATH,[object_name_n,'.png']));
        imwrite(I2,fullfile(ROOT_PATH,[object_name,'.png']));
    catch
        mkdir(ROOT_PATH);
        %imwrite(I2,fullfile(ROOT_PATH,[object_name_n,'.png']));
        imwrite(I2,fullfile(ROOT_PATH,[object_name,'.png']));
        helpdlg(['Directory "',ROOT_PATH,'" is created'],'Info');
    end
    %get path
    %file_path = fullfile(ROOT_PATH,[object_name_n,'.png']);
    file_path = fullfile(ROOT_PATH,[object_name,'.png']);
    [~,file_name,~] = fileparts(file_path);
    [x,y,~] = size(I2);
    clear I2;
else
    if not (isempty(frame_index)); %load video mode
        file_path = video_path;
    elseif file_index == 0; %load image mode
        file_path = img_path;
    else %load folder mode
        file_path = fullfile(folder_name,filename_cell{1,file_index});
    end
    [~,file_name,~] = fileparts(file_path);
    [x,y,~] = size(I);
end

%save info to database
% for i = 1:length(object_name);
%     rootdb.db.(file_path).(object_name(i)) = struct;
%     rootdb.db.(file_path).(object_name(i)).affordance = strsplit(object_affordance(i),',');
%     rootdb.db.(file_path).(object_name(i)).position = rect_obj(i);
% end
rootdb.db.(file_name).object(1)=struct;
rootdb.db.(file_name).object(1).name = object_name;
rootdb.db.(file_name).object(1).affordance = strsplit(object_affordance,',');
rootdb.db.(file_name).object(1).position = rect_obj;

rootdb.db.(file_name).width = y;
rootdb.db.(file_name).height = x;

rootdb.db.(file_name).image_path = image_path;
rootdb.db.(file_name).link = object_link;
rootdb.db.(file_name).video_check = object_v_check;
rootdb.db.(file_name).frame = frame_index;

rootdb.db.(file_name).pos_pose = rect_pose;
rootdb.db.(file_name).wrist_L = wrist1_xy;
rootdb.db.(file_name).wrist_R = wrist2_xy;
rootdb.db.(file_name).elbow_L = elbow1_xy;
rootdb.db.(file_name).elbow_R = elbow2_xy;
rootdb.db.(file_name).shoulder_L = shoulder1_xy;
rootdb.db.(file_name).shoulder_R = shoulder2_xy;
rootdb.db.(file_name).head = head_xy;

save('rootdb.mat','rootdb');

rect_obj = [];
rect_pose = [];
wrist1_xy = [];
wrist2_xy = [];
elbow1_xy = [];
elbow2_xy = [];
shoulder1_xy = [];
shoulder2_xy = [];
head_xy = [];

%check whether screenshot mode or file loading mode
if file_index == 0;
    state_str = sprintf('%s','Annotation saved.');
    set(handles.state_text,'String',state_str);
    return
else
    file_index = file_index + 1;
    if file_index > length(filename_cell);
        helpdlg('All Files in Current Folder are Loaded','Success');
        return
    end
    index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
    set(handles.index_text,'String',index_str);
    state_str = sprintf('%s\n%s\n%s','Annotation saved,','Click "Crop" to crop,','Or Click "Skip & Next".');
    set(handles.state_text,'String',state_str);
    
    I = imread(fullfile(folder_name,filename_cell{1,file_index}));
    imshow(I);
%     I2 = imcrop(I);
%     imshow(I2);
end


% --- Executes on button press in object_box.
function object_box_Callback(hObject, eventdata, handles)
% hObject    handle to object_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_obj
h_obj = imrect;
h_obj_child = get(h_obj, 'Children');
%get handle for context menu of imrect
h_obj_cmenu = get(h_obj_child(1),'UIContextMenu');
%add properties in context menu of imrect
itemnew = uimenu(h_obj_cmenu, 'Label', 'Properties','Callback', @obj_properties);
rect_obj = [rect_obj; getPosition(h_obj)];

function obj_properties(hObject, eventdata, handles)
global object_name object_affordance 
prompt = {'Object Name:','Object Affordance:'};
dlg_title = 'Object';
num_lines = [1,40];
if isempty(object_name);
    defaultans = {'',''};
else
    defaultans = {object_name,object_affordance};
end

answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if isempty(answer);
    return
else
    if not (isempty(answer{1,1}));
        object_name = lower(answer{1,1});
        object_affordance = lower(answer{2,1});
    else
        return 
    end
end



% --- Executes on button press in posture_box.
function posture_box_Callback(hObject, eventdata, handles)
% hObject    handle to posture_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rect_pose
h_pose = imrect;
h_pose_child = get(h_pose, 'Children');
%get handle for context menu of imrect
h_pose_cmenu = get(h_pose_child(1),'UIContextMenu');
%add properties in context menu of imrect
itemnew = uimenu(h_pose_cmenu, 'Label', 'Posture Info','Callback', @pose_info);
rect_pose = [rect_pose;getPosition(h_pose)];

function pose_info(hObject, eventdata, handles)
helpdlg('This is a rectangle for human posture','Info');


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function view_annotation_Callback(hObject, eventdata, handles)
% hObject    handle to view_annotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ROOT_PATH rootdb
[anno_name,path_name] = uigetfile('*.*','View Annotation: Select the image',ROOT_PATH);
if isempty(anno_name);
    return
end

[~,anno_filename,~] = fileparts(anno_name);

imshow(fullfile(path_name,anno_name));

rectangle('Position',rootdb.db.(anno_filename).object(1).position,'Edgecolor','b');
if not (isempty(rootdb.db.(anno_filename).pos_pose));
    rectangle('Position',rootdb.db.(anno_filename).pos_pose,'Edgecolor','r');
end
%display wrist
if not (isempty(rootdb.db.(anno_filename).wrist_L));
    h_wrist1 = impoint(gca,rootdb.db.(anno_filename).wrist_L);
    setColor(h_wrist1,'r');
    setString(h_wrist1,'L');
end

if not (isempty(rootdb.db.(anno_filename).wrist_R));
    h_wrist2 = impoint(gca,rootdb.db.(anno_filename).wrist_R);
    setColor(h_wrist2,'r');
    setString(h_wrist2,'R');
end
%display elbow
if not (isempty(rootdb.db.(anno_filename).elbow_L));
    h_elbow1 = impoint(gca,rootdb.db.(anno_filename).elbow_L);
    setColor(h_elbow1,'y');
    setString(h_elbow1,'L');
end

if not (isempty(rootdb.db.(anno_filename).elbow_R));
    h_elbow2 = impoint(gca,rootdb.db.(anno_filename).elbow_R);
    setColor(h_elbow2,'y');
    setString(h_elbow2,'R');
end
%display shoulder
if not (isempty(rootdb.db.(anno_filename).shoulder_L));
    h_shoulder1 = impoint(gca,rootdb.db.(anno_filename).shoulder_L);
    setColor(h_shoulder1,'c');
    setString(h_shoulder1,'L');
end

if not (isempty(rootdb.db.(anno_filename).shoulder_R));
    h_shoulder2 = impoint(gca,rootdb.db.(anno_filename).shoulder_R);
    setColor(h_shoulder2,'c');
    setString(h_shoulder2,'R');
end
%display head
if not (isempty(rootdb.db.(anno_filename).head));
    h_head = impoint(gca,rootdb.db.(anno_filename).head);
    setColor(h_head,'m');
end
%setString(h_head,'head');
%display other info (TODO: affordance path etc.)
state_str = sprintf('%s\n%s%s','Annotation: ',anno_filename,' is loaded.');
set(handles.state_text,'String',state_str);

helpdlg({'Red --- Wrist' 'Yellow --- Elbow' 'Cyan --- Shoulder'...
     'Magenta --- Head'},'Info');


% --- Executes on button press in wrist1.
function wrist1_Callback(hObject, eventdata, handles)
% hObject    handle to wrist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrist1_xy
%uiwait(msgbox('Locate first wrist'));
h_wrist1 = impoint;
setColor(h_wrist1,'r');
setString(h_wrist1,'wrist-L');
wrist1_xy = getPosition(h_wrist1);

% --- Executes on button press in wrist2.
function wrist2_Callback(hObject, eventdata, handles)
% hObject    handle to wrist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wrist2_xy
h_wrist2 = impoint;
setColor(h_wrist2,'r');
setString(h_wrist2,'wrist-R');
wrist2_xy = getPosition(h_wrist2);

% --- Executes on button press in elbow1.
function elbow1_Callback(hObject, eventdata, handles)
% hObject    handle to elbow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elbow1_xy
h_elbow1 = impoint;
setColor(h_elbow1,'y');
setString(h_elbow1,'elbow-L');
elbow1_xy = getPosition(h_elbow1);

% --- Executes on button press in elbow2.
function elbow2_Callback(hObject, eventdata, handles)
% hObject    handle to elbow2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elbow2_xy
h_elbow2 = impoint;
setColor(h_elbow2,'y');
setString(h_elbow2,'elbow-R');
elbow2_xy = getPosition(h_elbow2);

% --- Executes on button press in shoulder1.
function shoulder1_Callback(hObject, eventdata, handles)
% hObject    handle to shoulder1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shoulder1_xy
h_shoulder1 = impoint;
setColor(h_shoulder1,'c');
setString(h_shoulder1,'shoulder-L');
shoulder1_xy = getPosition(h_shoulder1);

% --- Executes on button press in shoulder2.
function shoulder2_Callback(hObject, eventdata, handles)
% hObject    handle to shoulder2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shoulder2_xy
h_shoulder2 = impoint;
setColor(h_shoulder2,'c');
setString(h_shoulder2,'shoulder-R');
shoulder2_xy = getPosition(h_shoulder2);

% --- Executes on button press in head.
function head_Callback(hObject, eventdata, handles)
% hObject    handle to head (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global head_xy
h_head = impoint;
setColor(h_head,'m');
setString(h_head,'head');
head_xy = getPosition(h_head);

% --- Executes on button press in skip.
function skip_Callback(hObject, eventdata, handles)
% hObject    handle to skip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename_cell file_index I folder_name 
if file_index == 0;
    helpdlg('"Skip & Next" is Invalid in This Mode','Info');
    return
end

file_index = file_index + 1;
if file_index > length(filename_cell);
    helpdlg('All Files in Current Folder are Loaded','Success');
    return
end

index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
set(handles.index_text,'String',index_str);
state_str = sprintf('%s\n%s\n%s','You can annotate now,','or Click "Crop" to crop,','or Click "Skip & Next".');
set(handles.state_text,'String',state_str);

I = imread(fullfile(folder_name,filename_cell{1,file_index}));
imshow(I);

% --------------------------------------------------------------------
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I img_path file_index object_name
[filename,loadpath] = uigetfile('*.*','Source Selector');
if filename==0;
    return
else
    img_path = strcat(loadpath,filename);
    I = imread(img_path);
    axes(handles.axes2);
    imshow(I);
    state_str = sprintf('%s\n%s\n%s','Image loaded,','You can annotate now,','or Click "Crop" to crop.');
    set(handles.state_text,'String',state_str);
    file_index = 0;
    object_name = [];
    
end

% --- Executes during object creation, after setting all properties.
function load_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function load_folder_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2 filename_cell file_index folder_name
folder_name = uigetdir('C:\','Select Directory to Load');
if folder_name==0;
    return
else
    dir_info = dir(folder_name);
    dir_length = length(dir_info);
    filename_cell = cell(1,dir_length-2);
    for i = 3:dir_length;
        filename_cell{1,i-2} = dir_info(i).name;
    end
    I = imread(fullfile(folder_name,dir_info(i).name));
    imshow(I);
    I2 = [];
    
    file_index = 1;
    index_str = ['Index: ','1','/',num2str(dir_length-2)];
    set(handles.index_text,'String',index_str);
    
    state_str = sprintf('%s\n%s\n%s','You can annotate now.',' or Click "Crop" to crop,','Or click "Skip & Next".');
    set(handles.state_text,'String',state_str);
    
%     I2 = imcrop(I);
%     imshow(I2);
end

% --------------------------------------------------------------------
function load_video_Callback(hObject, eventdata, handles)
% hObject    handle to load_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nFrame v frame_index video_path
[filename,loadpath] = uigetfile('*.*','Source Selector');
if filename==0;
    return
else
    video_path = strcat(loadpath,filename);
    v = VideoReader(video_path);
    nFrame = v.NumberOfFrame;
    
    axes(handles.axes2);
    imshow(read(v,1));
    
    set(handles.slider, 'Min', 1);
    set(handles.slider, 'Max', nFrame);
    set(handles.slider, 'SliderStep', [1,10]/(nFrame-1));
    set(handles.slider, 'Value', 1); % set to beginning of sequence
    
    state_str = sprintf('%s\n%s\n%s','Video loaded,','Use slide bar to view and annotate,','then click "Save & Next".');
    set(handles.state_text,'String',state_str);
    
    frame_index = 1;
    index_str = ['1/',num2str(nFrame)];
    set(handles.index_text,'String',index_str);
end

% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global object_name object_affordance file_path image_path ...
    object_link object_coord object_v_check next_flag ...
    I I2 rect_obj rect_pose wrist1_xy wrist2_xy elbow1_xy elbow2_xy...
    shoulder1_xy shoulder2_xy head_xy file_index filename_cell

index_str = ['Index: ',num2str(file_index),'/',num2str(length(filename_cell))];
set(handles.index_text,'String',index_str);

state_str = sprintf('%s\n%s','Reset the annotation,','You can annotate now.');
set(handles.state_text,'String',state_str);

object_name = 0;
object_affordance = 0;
file_path = 0;
image_path = 0;
object_link = 0;
object_coord = 0;
object_v_check = 0;
clear I2 rect_obj rect_pose wrist1_xy wrist2_xy elbow1_xy elbow2_xy...
    shoulder1_xy shoulder2_xy head_xy

% I2 = imcrop(I);
% axes(handles.axes2);
% imshow(I2);
axes(handles.axes2);
imshow(I);
I2 = [];

% --- Executes during object creation, after setting all properties.
function index_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I I2
I2 = imcrop(I);
axes(handles.axes2);
imshow(I2);
state_str = sprintf('%s\n%s\n%s','Image cropped,','You can annotate now,','then click "Save & Next".');
set(handles.state_text,'String',state_str);


% --- Executes during object creation, after setting all properties.
function state_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to state_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global nFrame v I frame_index
%n = get(hObject, 'Value');
frame_index = round(hObject.Value);
hObject.Value = frame_index;
I = read(v,frame_index);
axes(handles.axes2);
imshow(I);

index_str = [num2str(frame_index),'/',num2str(nFrame)];
set(handles.index_text,'String',index_str);



% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in start_toggle.
function start_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to start_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start_toggle
global toggle_state frame_index frame_index_start frame_index_end
toggle_start = get(hObject,'Value');
if (toggle_state==0) && (toggle_start==1);
    frame_index_start = frame_index;
    toggle_state = 1;
    hObject.String = 'Stop';
elseif (toggle_state==1) && (toggle_start==0);
    frame_index_end = frame_index;
    toggle_state = 0;
    hObject.String = 'Start';
    if frame_index_end <= frame_index_start;
        helpdlg({'Frame Index Error : Ending frame index must be larger than starting frame index'},'Error');
        return
    end
    if isempty(frame_index_start) && isempty(frame_index_end);
        return
    end
    activity_annotation(hObject, eventdata, handles);
    helpdlg({'Save Tempral Action ?'; strcat('Starting frame = ',num2str(frame_index_start));
        strcat('ending frame = ',num2str(frame_index_end))},'Info');
else
    return
end

function activity_annotation(hObject, eventdata, handles)
global activity 
prompt = {'Activity:'};
dlg_title = 'Annotation';
num_lines = [1,40];
defaultans = {''};
activity = inputdlg(prompt,dlg_title,num_lines,defaultans);

% --- Executes on button press in video_cancel.
function video_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to video_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toggle_state frame_index_start frame_index_end
toggle_state = 0;
frame_index_start = 0;
frame_index_end = 0;


% --- Executes on button press in temporal_save.
function temporal_save_Callback(hObject, eventdata, handles)
% hObject    handle to temporal_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frame_index_start frame_index_end rootdb activity nFrame video_path
%load database
try
    load('rootdb.mat');
catch
    helpdlg('no database present, a new database is created', 'Info');
    rootdb = struct;
end
if isempty(activity);
    helpdlg('Activity name is not provided','Warning');
end
if not (isfield(rootdb, 'videodb'));
    rootdb.videodb = struct;
end

n = length(fieldnames(rootdb.videodb));
rootdb.videodb.activity(n+1).start_index = frame_index_start;
[h_start,m_start,s_start]=hms(seconds(round(frame_index_start/30,1)));
rootdb.videodb.activity(n+1).start_time = [h_start,m_start,s_start];

rootdb.videodb.activity(n+1).end_index = frame_index_end;
[h_end,m_end,s_end]=hms(seconds(round(frame_index_end/30,1)));
rootdb.videodb.activity(n+1).end_time = [h_end,m_end,s_end];

rootdb.videodb.activity(n+1).total_frame = nFrame;
[h_total,m_total,s_total]=hms(seconds(round(nFrame/30,1)));
rootdb.videodb.activity(n+1).total_time = [h_total,m_total,s_total];

rootdb.videodb.activity(n+1).action_label = activity;
rootdb.videodb.activity(n+1).video_path = video_path;

if not (isfield(rootdb, 'actions'));
    rootdb.actions = struct;
end

if isfield(rootdb.actions, activity{1,1});
    rootdb.actions.(activity{1,1}) = rootdb.actions.(activity{1,1}) + 1;
else
    rootdb.actions.(activity{1,1}) = 1;
end
save('rootdb.mat','rootdb');
state_str = sprintf('%s\n','Temporal Action Saved');
set(handles.state_text,'String',state_str);


>>>>>>> c97a6fa638773713605659b35952b1bb38abf0d1

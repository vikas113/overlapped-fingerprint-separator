function varargout = fingerprint_gui(varargin)
% FINGERPRINT_GUI MATLAB code for fingerprint_gui.fig
%      FINGERPRINT_GUI, by itself, creates a new FINGERPRINT_GUI or raises the existing
%      singleton*.
%
%      H = FINGERPRINT_GUI returns the handle to a new FINGERPRINT_GUI or the handle to
%      the existing singleton*.
%
%      FINGERPRINT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINT_GUI.M with the given input arguments.
%
%      FINGERPRINT_GUI('Property','Value',...) creates a new FINGERPRINT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fingerprint_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fingerprint_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fingerprint_gui

% Last Modified by GUIDE v2.5 23-Jan-2016 22:25:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fingerprint_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @fingerprint_gui_OutputFcn, ...
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


% --- Executes just before fingerprint_gui is made visible.
function fingerprint_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fingerprint_gui (see VARARGIN)

% Choose default command line output for fingerprint_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes fingerprint_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global preview;
preview=imread('C:\Users\Vikas\Desktop\gitpro\gui\Images\preview.jpg');
axes(handles.axes1);
imshow(preview);
axes(handles.axes2);
imshow(preview);


% --- Outputs from this function are returned to the command line.
function varargout = fingerprint_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global info;
global type;
[file,cancel]=imgetfile;
if(cancel)
    errordlg('NO IMAGE SELECTED','ERROR');
end
info=imfinfo(file);
type=info.ColorType;
if(strcmp(type,'indexed'))
    [temp,map]=imread(file);
    data=ind2rgb(temp,map);
else
    data=imread(file);
end
axes(handles.axes1);
imshow(data);
axes(handles.axes2);
imshow(data);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=getimage(handles.axes2);
[filename,pathname]=uiputfile;
if(filename~=0)
    imwrite(image,strcat(pathname,filename));
end

% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
image=rgb2gray(data);
axes(handles.axes2);
imshow(image);
% --- Executes on button press in ext.
function ext_Callback(hObject, eventdata, handles)
% hObject    handle to ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
query=questdlg('Are You Sure You Want To Exit?','Query','Yes','No','Cancel','No');
if(query=='Yes')
    close(handles.figure1);
end;
% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
% hObject    handle to binary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
image=im2bw(data);
axes(handles.axes2);
imshow(image);
% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global preview;
axes(handles.axes1);
imshow(preview);
axes(handles.axes2);
 imshow(preview);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=getimage(handles.axes1);
axes(handles.axes2);
imshow(image);

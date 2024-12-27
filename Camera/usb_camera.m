function varargout = usb_camera(varargin)
% USB_CAMERA MATLAB code for usb_camera.fig
%      USB_CAMERA, by itself, creates a new USB_CAMERA or raises the existing
%      singleton*.
%
%      H = USB_CAMERA returns the handle to a new USB_CAMERA or the handle to
%      the existing singleton*.
%
%      USB_CAMERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USB_CAMERA.M with the given input arguments.
%
%      USB_CAMERA('Property','Value',...) creates a new USB_CAMERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before usb_camera_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to usb_camera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help usb_camera

% Last Modified by GUIDE v2.5 24-Apr-2021 11:04:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @usb_camera_OpeningFcn, ...
                   'gui_OutputFcn',  @usb_camera_OutputFcn, ...
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


% --- Executes just before usb_camera is made visible.
function usb_camera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to usb_camera (see VARARGIN)

% Choose default command line output for usb_camera
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes usb_camera wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = usb_camera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global video_obj;
global count_take_pic;
count_take_pic=1;%拍照计数器,摄像头开始时设为1
video_obj = videoinput('winvideo', 2);
set(video_obj,'ReturnedColorSpace','rgb');
videoRes = get(video_obj, 'VideoResolution');
nBands = get(video_obj, 'NumberOfBands');
axes(handles.axes1);
hImage = image(zeros(videoRes(2), videoRes(1), nBands));
preview(video_obj,hImage);
start(video_obj);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global video_obj;
stop(video_obj);
closepreview(video_obj);
delete(video_obj);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count_take_pic;
global video_obj;%拍照计数器
mypic = getsnapshot(video_obj);
axes(handles.axes2);
imshow(mypic);
N_col=size(mypic,2);
cd('C:\Users\任小猪\Desktop\毕设\Camera\left_pic')
left_pic=mypic(:,1:N_col/2,:);
% imwrite(left_pic,strcat(strcat('wb',num2str(count_take_pic)),'.jpg'))
imwrite(left_pic,strcat('hanfengNew',strcat(num2str(count_take_pic)),'.jpg'))
cd('C:\Users\任小猪\Desktop\毕设\Camera\right_pic')
right_pic=mypic(:,N_col/2+1:end,:);
% imwrite(right_pic,strcat(strcat('wb',num2str(count_take_pic)),'.jpg'))
imwrite(right_pic,strcat('hanfengNew',strcat(num2str(count_take_pic)),'.jpg'))
count_take_pic=count_take_pic+1;



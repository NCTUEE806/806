function varargout = canny(varargin)
% CANNY MATLAB code for canny.fig
%      CANNY, by itself, creates a new CANNY or raises the existing
%      singleton*.
%
%      H = CANNY returns the handle to a new CANNY or the handle to
%      the existing singleton*.
%
%      CANNY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CANNY.M with the given input arguments.
%
%      CANNY('Property','Value',...) creates a new CANNY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before canny_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to canny_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help canny

% Last Modified by GUIDE v2.5 28-Jan-2015 19:27:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @canny_OpeningFcn, ...
                   'gui_OutputFcn',  @canny_OutputFcn, ...
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


% --- Executes just before canny is made visible.
function canny_OpeningFcn(hObject, eventdata, handles, varargin)



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to canny (see VARARGIN)

% Choose default command line output for canny
handles.output = hObject;
handles.num=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes canny wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = canny_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)

%if handles.num>0
% close figure 1
% close figure 2
% close figure 3
% close figure 4
%end
handles.num=handles.num+1;
[filename, pathname]=uigetfile({'*.*'},'Pick a file','D:\samplePicture\');
img=imread([ pathname,filename]);    %get the image
% figure
imshow(img);
I=rgb2gray(img);
img = anisodiff2D(I, 2, 60,1/7, 2);
BW2 = edge(img,'canny');
BW2=bwmorph(BW2,'skel',Inf);
[GX,GY]=gaussgradient(double(img))

B=sqrt(GX.*GX+GY.*GY);

[row col]=size(I);
seed = zeros(size(I))

seedTemp=[0 0];

for i=2:row-1
    for j=2:col-1
        count=0;
        if BW2(i,j)==1
            for m=i-1:i+1
                for n=j-1:j+1
                  if BW2(m,n)==1
                      count=count+1;
                  end
                end
            end
            if(count<3)
                seed(i,j)=255;
                seedTemp=[seedTemp; i j];
            end
        end
    end
end

seedTemp=seedTemp(2:end,:)
[row col]=size(seedTemp);
J = zeros(size(I))
for i=1:row
     A = regionGrowing(B,seedTemp(i,1),seedTemp(i,2),3,30)
     J=J|A;
end
figure
imshow((J)); %logical
figure
imshow(uint8(seed));
title('seed')
figure
imshow(BW2); %logical
figure
imshow(uint8(B)); % gradient
% for i=1:row
%     for j=1:col
%      if J(i,j)>0
%         BW2(i,j)=1;
%      end
%     end
% end
figure
imshow((BW2|J));
title('tile')

a='D:\CannyResult\'
b= [a filename(1:end-4) '.bmp']
imwrite(BW2, b);

% Denoise = anisodiff2D(I, 15, 60,1/7, 2);
% J=histeq(uint8(Denoise));
% %figure
% %imshow(J);
% BW3 = edge(J,'canny');
% i=1
% c= [a filename(1:end-4) int2str(i) '.bmp']
% imwrite(BW3, c);


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

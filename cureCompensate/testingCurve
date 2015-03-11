close all

img=imread('testingCurve.bmp');    %get the image

imshow(img);
img=rgb2gray(img);
img=logical(img);

edgeresult=edgeCompensate(img);
figure
imshow(edgeresult);
figure
imshow(edgeresult|img);

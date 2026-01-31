%Problem 1
img = imread('C:\Users\Ansugan\Downloads\Banana-Single.jpg');
i = rgb2gray (img);
imshow(i);

title('Original Image');

i = double(i);

gamma1 = 0.3;
gamma2 = 3.0;

Image1 = 255 * (i / 255).^gamma1;
Image2 = 255 * (i/ 255).^gamma2;

i= uint8(i);
Image1 = uint8(Image1);
Image2 = uint8(Image2);

figure;
subplot(3, 3, 1);
imshow(i);
title ("Original Image");
subplot(3, 3, 2);
imshow(Image1);
title('Power-law Transformation 0.3)');
subplot(3, 3, 3);
imshow(Image2);
title('Power-law Transformation 3.0)');
%% 


%Problem 2

i = rgb2gray(imread('C:\Users\Ansugan\Downloads\Banana-Single.jpg'));

i = double(i);


bitplane1 = bitget(i, 1);
bitplane2 = bitget(i, 2);
bitplane3 = bitget(i, 3);
bitplane4 = bitget(i, 4);
bitplane5 = bitget(i, 5);
bitplane6 = bitget(i, 6);
bitplane7 = bitget(i, 7);
bitplane8 = bitget(i, 8);

figure;
subplot (4, 4, 1);
imshow(bitplane1, []);
title("Bit plane 1");
subplot (4, 4, 2);
imshow(bitplane2, []);
title("Bit plane 2");
subplot (4, 4, 3);
imshow(bitplane3, []);
title("Bit plane 3");
subplot (4, 4, 4);
imshow(bitplane4, []);
title("Bit plane 4");
subplot (4, 4, 5);
imshow(bitplane5, []);
title("Bit plane 5");
subplot (4, 4, 6);
imshow(bitplane6, []);
title("Bit plane 6");
subplot (4, 4, 7);
imshow(bitplane7, []);
title("Bit plane 7");
subplot (4, 4, 8);
imshow(bitplane8, []);
title("Bit plane 8");


highest4bits = bitplane8*(2^8) + bitplane7*(2^7) + bitplane6*(2^6) + bitplane5*(2^5);
highest2bits = bitplane8*(2^8) + bitplane7*(2^7);


figure;
subplot(3, 3, 1);
imshow(uint8(i));
title ("Original Image");

subplot (3, 3, 2);
imshow(highest2bits, []);
title("2bit planes");

subplot(3, 3, 3);
imshow(highest4bits, []);
title("4bit planes");
%%
%Problem 3

img = imread('C:\Users\Ansugan\Downloads\Banana-Single.jpg');
i = rgb2gray (img);
% imshow(i);
% title('Original Image');

i = double(i);

gamma1 = 0.3;
gamma2 = 3.0;

Image1 = 255 * (i / 255).^gamma1;
Image2 = 255 * (i/ 255).^gamma2;

i= uint8(i);
Image1 = uint8(Image1);
Image2 = uint8(Image2);

orgHist = imhist(i);
hist01 = imhist(Image1);
histo2 = imhist(Image2);

orgHist= uint8(orgHist);
hist01 = uint8(hist01);
histo2 = uint8(histo2);

equalizedImage = histeq(i);
equalizedTransImage1 = histeq(Image1);
equalizedTransImage2 = histeq(Image2);

figure;
subplot(3, 3, 1);
imshow(i);
title('Grayscale Image');

subplot(3, 3, 2);
bar(orgHist);
title('Histogram (Original)');

subplot(3, 3, 3);
imshow(equalizedImage);
title('Equalized Image (Original)');

subplot(3, 3, 4);
imshow(Image1);
title('Transformed Image (\gamma = 0.3)');

subplot(3, 3, 5);
bar(hist01);
title('Histogram (Transformed, \gamma = 0.3)');

subplot(3, 3, 6);
imshow(equalizedTransImage1);
title('Equalized Image (Transformed, \gamma = 0.3)');

subplot(3, 3, 7);
imshow(Image2);
title('Transformed Image (\gamma = 3.0)');

subplot(3, 3, 8);
bar(histo2);
title('Histogram (Transformed, \gamma = 3.0)');

subplot(3, 3, 9);
imshow(equalizedTransImage2);
title('Equalized Image (Transformed, \gamma = 3.0)');
%%
%Part 2
%Step 1

a = 0.45;
T = maketform('affine', [1 0 0; a 1 0; 0 0 1] )
A = imread('C:\Users\Ansugan\Downloads\Soccer_ball_football_general_view.jpg');
h1 = figure; imshow(A); title('Original Image');

orange = [255 127 0]';
R = makeresampler({'cubic','nearest'},'fill');
B = imtransform(A,T,R,'FillValues',orange); 
h2 = figure; imshow(B);
title('Sheared Image');

%Step 2

[U,V] = meshgrid(0:64:320,0:64:256);
[X,Y] = tformfwd(T,U,V);
gray = 0.65 * [1 1 1];

figure(h1);
hold on;
line(U, V, 'Color',gray);
line(U',V','Color',gray);

figure(h2);
hold on;
line(X, Y, 'Color',gray);
line(X',Y','Color',gray);

%Step 3

R = makeresampler({'cubic','nearest'},'fill');

Bf = imtransform(A,T,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);

figure, imshow(Bf);
title('Pad Method = ''fill''');

R = makeresampler({'cubic','nearest'},'replicate');
Br = imtransform(A,T,R,'XData',[-49 500],'YData', [-49 400]);

figure, imshow(Br);
title('Pad Method = ''replicate''');

R = makeresampler({'cubic','nearest'}, 'bound');
Bb = imtransform(A,T,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bb);
title('Pad Method = ''bound''');


Thalf = maketform('affine',[1 0; a 1; 0 0]/2);

R = makeresampler({'cubic','nearest'},'circular');
Bc = imtransform(A,Thalf,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bc);
title('Pad Method = ''circular''');

R = makeresampler({'cubic','nearest'},'symmetric');
Bs = imtransform(A,Thalf,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bs);
title('Pad Method = ''symmetric''');
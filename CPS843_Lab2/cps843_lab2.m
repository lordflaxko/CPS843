% Problem 1
I = imread('C:\Users\Ansugan\Downloads\benito-gaztelugatxe.jpg');
I = rgb2gray(I);
figure; imshow(I); title('Original Image');
% Roberts Edge
E1 = edge(I, 'roberts');
figure; imshow(E1); title('Roberts');
% Sobel Edge
E2 = edge(I, 'sobel');
figure; imshow(E2); title('Sobel');
% Prewitt Edge
E3 = edge(I, 'prewitt');
figure; imshow(E3); title('Prewitt');


%% 
% Problem 3
I = imread('C:\Users\Ansugan\Downloads\benito-gaztelugatxe.jpg');
I = rgb2gray(I);
h = fspecial('gaussian', 5, 2.5);
blurred = imfilter(I, h);
diff = I - blurred;
k = 1;
highboost_k_1 = I + k * diff;
k = 5;
highboost_k_5 = I + k * diff;

figure; imshow(highboost_k_1); title('k = 1');
figure; imshow(highboost_k_5); title('k = 5');

%%
% Problem 4
I = imread('C:\Users\Ansugan\Downloads\benito-gaztelugatxe.jpg');
I = rgb2gray(I);

blurred_noise = imnoise(I, 'gaussian');
figure; imshow(blurred_noise); title('Noisy Image');

average_filter = filter2(fspecial('average', 5), blurred_noise)/255;
figure; imshow(average_filter); title('Average Filter');

gaussian_filter = imgaussfilt(blurred_noise, 2.5);
figure; imshow(gaussian_filter); title('Gaussian Filter');

%%
%Part 2

% Enhance Low Light Image using Dehazing Algorithm
A = imread('C:\Users\Ansugan\Downloads\Alleyway-in-Amiens-Photo-with-Chiaroscuro.jpg');
B = imread('C:\Users\Ansugan\Downloads\low-light-photography-570x379,jpg.jpg');

figure; imshow(A); title('Image 1');
figure; imshow(B); title('Image 2');

A_INV = imcomplement(A);
B_INV = imcomplement(B);

A_DEHAZED = imcomplement(imreducehaze(A_INV));
B_DEHAZED = imcomplement(imreducehaze(B_INV));

figure; imshow(A_DEHAZED); title('Dehazing Algorithm 1');
figure; imshow(B_DEHAZED); title('Dehazing Algorithm 2');

A_DEHAZED_ENHANCED = imcomplement(imreducehaze(A_INV, 'Method', 'approx', 'ContrastEnhancement', 'boost'));
B_DEHAZED_ENHANCED = imcomplement(imreducehaze(B_INV, 'Method', 'approx', 'ContrastEnhancement', 'boost'));

figure; imshow(A_DEHAZED_ENHANCED); title('Dehazing Enhanced 1');
figure; imshow(B_DEHAZED_ENHANCED); title('Dehazing Enhanced 2');

A_DEHAZED_NO_CONTRAST_ENHANCEMENT = imcomplement(imreducehaze(A_INV, 'ContrastEnhancement', 'none'));
B_DEHAZED_NO_CONTRAST_ENHANCEMENT = imcomplement(imreducehaze(B_INV, 'ContrastEnhancement', 'none'));

figure; imshow(A_DEHAZED_NO_CONTRAST_ENHANCEMENT); title('Dehazing Algorithm No Contrast 1');
figure; imshow(B_DEHAZED_NO_CONTRAST_ENHANCEMENT); title('Dehazing Algorithm No Contrast 2');

A_LAB = rgb2lab(A);
B_LAB = rgb2lab(B);
A_LAB_INV = imcomplement(A_LAB(:,:,1) ./ 100);
B_LAB_INV = imcomplement(B_LAB(:,:,1) ./ 100);

A_LAB_ENH = imcomplement(imreducehaze(A_LAB_INV, 'ContrastEnhancement', 'none'));
B_LAB_ENH = imcomplement(imreducehaze(B_LAB_INV, 'ContrastEnhancement', 'none'));

A_LAB_ENH(:,:,1)   = A_LAB_ENH .* 100;
A_LAB_ENH(:,:,2:3) = A_LAB(:,:,2:3) * 2;
B_LAB_ENH(:,:,1)   = B_LAB_ENH .* 100;
B_LAB_ENH(:,:,2:3) = B_LAB(:,:,2:3) * 2;

AEnh = lab2rgb(A_LAB_ENH);
BEnh = lab2rgb(B_LAB_ENH);

figure; imshow(AEnh); title('Dehazing 1');
figure; imshow(BEnh); title('Dehazing 2');

% Improve Results Using Denoising
A_GUIDED_FILTER = imguidedfilter(A_DEHAZED);
B_GUIDED_FILTER = imguidedfilter(B_DEHAZED);

figure; imshow(A_GUIDED_FILTER); title('Guided Filter 1');
figure; imshow(B_GUIDED_FILTER); title('Guided Filter 2');

% Estimate Illumination Map
[A_ENH_INV, A_ILLUM_INV] = imreducehaze(A_INV, 'Method', 'approxdcp', 'ContrastEnhancement', 'none');
[B_ENH_INV, B_ILLUM_INV] = imreducehaze(B_INV, 'Method', 'approxdcp', 'ContrastEnhancement', 'none');
A_ILLUM = imcomplement(A_ILLUM_INV);
B_ILLUM = imcomplement(B_ILLUM_INV);

figure; imshow(A_ILLUM); colormap(hot); title('Illumination Map 1');
figure; imshow(B_ILLUM); colormap(hot); title('Illumination Map 2');
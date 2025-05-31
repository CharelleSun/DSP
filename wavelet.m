% Read image and convert to grey scale
[A, ~] = imread('dct1.png');
I = im2gray(A);
I = im2double(I);

% Display original and noisy images
figure(1);
subplot(1,2,1); imshow(I); title('Original Image');

% Generate noisy image and ensure it's in double format
noisyImage = imnoise(I, 'gaussian', 0, 0.052);
subplot(1,2,2); imshow(noisyImage); title('Noisy Image');

% Wavelet decomposition
[c, s] = wavedec2(noisyImage, 2, 'sym4');

% Perform denoising using fixed threshold
% You can adjust the threshold as needed
threshold = 0.3;
[denoisedImage, ~, ~, ~, ~] = wdencmp('gbl', c, s, 'sym4', 2, threshold, 's', 1);

% Display denoised image
figure(2);
subplot(1,3,1); imshow(I); title('Original Image');
subplot(1,3,2); imshow(noisyImage); title('Noisy Image');
subplot(1,3,3); imshow(denoisedImage); title('Denoised Image (Wavelet)');

% Calculate PSNR, MSE and SSIM
psnr_noisy = psnr(I, noisyImage);
psnr_denoised = psnr(I, denoisedImage);

mse_noisy = mean((I - noisyImage).^2, 'all');
mse_denoised = mean((I - denoisedImage).^2, 'all');

ssim_noisy = ssim(I, noisyImage);
ssim_denoised = ssim(I, denoisedImage);

% Output results
fprintf('Noisy Image - PSNR: %.2f dB, MSE: %.4f, SSIM: %.4f\n', psnr_noisy, mse_noisy, ssim_noisy);
fprintf('Denoised Image - PSNR: %.2f dB, MSE: %.4f, SSIM: %.4f\n', psnr_denoised, mse_denoised, ssim_denoised);
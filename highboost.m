function [outputImage] = highboost(inputImage, filterSize, A)

margen = (filterSize-1) / 2;

% Mascara
mask = (-1 .* ones(filterSize,filterSize));
mask(margen + 1, margen + 1) = A + ((filterSize ^ 2) - 1);

% LLamada a convolución
boostFun = @(matrix, filter) sum(sum(matrix .* filter));
outputImage = convolution(inputImage, mask, boostFun, 'image');

end


function [ outputImage ] = convolution( inputImage, filter, fun, paddingType)

[x y] = size(inputImage);
filterSize = size(filter);

% Se ajusta el tipo de relleno

if strcmp(paddingType,'image')
    outputImage = inputImage;
elseif strcmp(paddingType,'zeros')
    outputImage = zeros(x,y);
end
offset = (filterSize-1) / 2;

% Aplicar la convolución a la imagen

for i = 1 + offset : x - offset
    for j = 1 + offset : y - offset
       tmp = inputImage(i-offset : i + offset,j - offset : j + offset);
       result = fun(tmp,filter);
       outputImage(i,j) = result;
    end
end
end


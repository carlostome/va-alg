function [outputImage] = medianFilter(inputImage, filterSize)

  % Aqui la mascara no la vamos a usar pero necesitamos que 
  % tenga el tamaño adecuado
  mask = zeros(filterSize,filterSize);
  medianFun = @(matrix,filter) median(matrix(:));
  
  % Aplicamos la convolucion
  outputImage = convolution(inputImage, mask, medianFun, 'image');
end


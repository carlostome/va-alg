function [outputImage] = gauss(inputImage, sigma, sizeMask)

  mask = zeros(sizeMask,sizeMask);

  r = round(sizeMask / 2);

  for i = 1 : sizeMask
    for j = 1 : sizeMask
      mask(i,j) = (1/(2*pi*sigma^2))*exp(-((i - r)^2 + (j-r)^2)/(2*sigma^2));    
    end
  end

  gaussFun = @(matrix, filter) sum(sum(filter .* matrix)) / sum(sum(filter));
  outputImage = convolution(inputImage, mask, gaussFun, 'image');

end


function [outputImage] = histStrech(inputImage, minValue, maxValue)
  Gmin = min(min(inputImage));
  Gmax = max(max(inputImage));

  [x,y] = size(inputImage);

  normImage = arrayfun(@(p) minValue + ((p - Gmin) * (maxValue - minValue) / (Gmax - Gmin)), inputImage);

  outputImage = reshape(normImage, x, y);

end
  

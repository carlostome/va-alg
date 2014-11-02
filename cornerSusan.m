function [ outputImage ] = cornerSusan(inputImage, r, t, p)
  [x y] = size(inputImage);
 
  outputImage = repmat(255,x,y);
  
  [cx cy] = meshgrid(1 : (2 * r) + 1);
  mask = (cx - (r+1)) .^2 + (cy - (r + 1)) .^2 <= r^2;
  
  offset = r;
  g = round(numel(mask(mask)) * p);
  for i = 1 + offset : x - offset
    for j = 1 + offset : y - offset
        tmp = inputImage(i - offset : i + offset, j - offset : j + offset);
        pixel_centro = tmp(r,r);
        circle = tmp(mask);
        pixel_dentro = circle(abs(circle - pixel_centro) <= t);
        n = numel(pixel_dentro);
        if (n < g);
            outputImage(i,j) = g - n;
        end
            
    end
  end
end


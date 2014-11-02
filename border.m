function [ angle magnitud ] = border(inputImage, type)

  if type == 'sobel'
    mask_x = [-1 0 1 ; -1 0 1 ; -1 0 1];
    mask_y = [-1 -1 -1 ; 0 0 0 ; 1 1 1];
  elseif type == 'prewit'
    mask_x = [-1 0 1 ; -2 0 2 ; -1 0 1];
    mask_y = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
  end

  [x y] = size(inputImage);

  angle = zeros(x,y);
  magnitud = zeros(x,y);
  
  for i = 2 : x-1
    for j = 2 : y-1
      tmp = double(inputImage(i-1 : i+1, j-1 : j+1));
      tmp_x = sum(sum(tmp .* mask_x));
      tmp_y = sum(sum(tmp .* mask_y));
      magnitud(i-1,j-1) = sqrt(tmp_x^2 + tmp_y^2);
      angulo = atand(tmp_y / (tmp_x+eps));

      if angulo < -67.5
        ang = 90;
      elseif angulo < -22.5
        ang = -45;
      elseif angulo < 22.5
        ang = 0;
      elseif angulo < 67.5
        ang = 45;
      elseif ang < 90
        ang = 90;
      angle(i-1,j-1) = ang;
    end
  end
end


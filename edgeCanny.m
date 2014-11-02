function [ outputImage ] = edgeCanny( inputImage, sigma, tLow, tHigh )

[x y] = size(inputImage);

%% Aplicamos un filtro gaussiano

gaussFilter = gauss(inputImage, sigma, 5);

%% Llamamos a bordes de primera derivada.
[angle magnitud] = border(gaussFilter,'sobel');

%% Calculamos la supresión no máxima.

tmp_img = zeros(x,y); 

  for i = 2 : x-1
    for j = 2 : y-1 
      dir = angle(i,j);
      if dir  == 90 
        v1 = [i-1 j];
        v2 = [i+1 j];
      elseif dir == -45 
        v1 = [i-1 j-1];
        v2 = [i+1 j+1];
      elseif dir == 0
        v1 = [i j-1];
        v2 = [i j+1];
      elseif dir == 45
        v1 = [i-1 j+1];
        v2 = [i+1 j-1];
      end

      Em = magnitud(i,j);

      Em_v1 = magnitud(v1(1),v1(2));
      Em_v2 = magnitud(v2(1),v2(2));

      if Em < Em_v1 || Em < Em_v2
        tmp_img(i,j) = 0;
      else 
        tmp_img(i,j) = Em;
      end
    end
  end

  check_lim = @(v) (v(1)>0 && v(1) <=x && v(2)>0 && v(2)<=y)

  outputImage = zeros(x,y);
  visited = zeros(x,y);
  for k = 1 : x
    for l = 1 : y
      if not(visited(k,l)) && tmp_img(k,l)>tHigh
        cola = [k;l];
        while not(isempty(cola))
          v = cola(:,1);
          i = v(1);
          j = v(2);
          cola = cola(:,2:end);
          if not(visited(i,j))
            visited(i,j) = 1;
            outputImage(i,j) = 255;
            dir = angle(i,j);
            if dir == 90
              v1 = [i ; j+1];
              v2 = [i ; j-1];
            elseif dir == -45 
              v1 = [i-1 ; j+1];
              v2 = [i+1 ; j-1];
            elseif dir == 0
              v1 = [i+1 ; j];
              v2 = [i-1 ; j];
            elseif dir == 45
              v1 = [i-1 ; j-1];
              v2 = [i+1 ; j+1];
            end
            if check_lim(v1)
              if tmp_img(v1(1),v1(2)) >tLow
                cola = [cola v1];
              end
            end

            if check_lim(v2)
              if tmp_img(v2(1),v2(2)) >tLow
                cola = [cola v2];
              end
            end
          end
        end
      end
    end
  end 
end


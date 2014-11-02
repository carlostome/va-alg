function [outputImage] = zoomIn(inputImage, mode, zoom_x, zoom_y)

  neighbor = strcmp(mode,'neighbor');
  bilineal = strcmp(mode,'bilineal');

  img = inputImage;
  [x,y] = size(img);

  % Ampliamos la matriz una fila/columna por cada lado 
  % para evitar problemas de redondeo en caso de zoom no
  % entero.
  image_tmp = [img(:,1) img img(:,y)];
  image = [image_tmp(1,:) ; image_tmp ; image_tmp(x,:)];

  new_size_x = round(zoom_x * x);
  new_size_y = round(zoom_y * y);
  
  % Hacemos la imagen de salida con el nuevo tamaño
  outputImage = uint8(zeros(new_size_x,new_size_y));
  
  for i = 1 : new_size_x;
      new_x = i/zoom_x + 1;
      fix_new_x = fix(new_x);
      x_distance = new_x - fix_new_x;
    for j = 1 : new_size_y;
      new_y = j/zoom_y + 1;
      fix_new_y = fix(new_y);
      y_distance = new_y - fix_new_y;
      % Si tenemos un punto exacto
      if (x_distance == 0 && y_distance == 0)
        outputImage(i,j) = image(new_x,new_y);
      % Si no miramos el tipo de interpolacion
      % Interpolacion por vecino más cercano
      elseif (neighbor)
        outputImage(i,j) = image(fix_new_x, fix_new_y);
      % Interpolacion bilineal
      elseif (bilineal)
        up_left  = image(fix_new_x,fix_new_y);
        up_right = image(fix_new_x,fix_new_y + 1);
        int_up = up_left * (1-y_distance) + up_right * y_distance;
        down_left = image(fix_new_x + 1,fix_new_y);
        down_right = image(fix_new_x + 1,fix_new_y + 1);
        int_down = down_left * (1-y_distance) + down_right * y_distance;
        int = int_up * (1-x_distance) + int_down * x_distance;
        outputImage(i,j) = int;
      end
    end
  end
end

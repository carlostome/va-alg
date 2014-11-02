function [outputImage] = dilate(inputImage, strElType, strElSize)

  image = not(inputImage);
  
  margen = fix((strElSize-1) / 2);

  if strcmp(strElType, 'square')
    mask = ones(strElSize,strElSize);
  elseif strcmp(strElType, 'cross')
    fila = ones(1,strElSize);
    columna = ones(strElSize,1);
    mask = zeros(strElSize,strElSize);
    mask(margen + 1,:) = fila;
    mask(:,margen + 1) = columna;
  end

  mask = logical(mask);

  dilateFun = @(matrix,filter) any(matrix(filter));
  
  % Aplicamos la convolucion
  outputImage = not(convolution(image,mask,dilateFun,'zeros'));
  
end


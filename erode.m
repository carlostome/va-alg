function [outputImage] = erode(inputImage, strElType, strElSize)

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
   
  erodeFun = @(matrix,filter) all(matrix(filter));
  
  % Aplicamos la convolucion
  outputImage = not(convolution(image,mask,erodeFun,'zeros'));
end


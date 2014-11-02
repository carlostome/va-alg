function [outputImage] = closing(inputImage, strElType, strElSize)
  outputImage = erode(dilate(inputImage, strElType, strElSize), strElType,strElSize);
end


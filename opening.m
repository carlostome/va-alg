function [outputImage] = opening(inputImage, strElType, strElSize)
  outputImage = dilate(erode(inputImage, strElType, strElSize), strElType,strElSize);
end


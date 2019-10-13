

detector = vision.ForegroundDetector('NumTrainingFrames',20,'InitialVariance',70*10);

reader = vision.VideoFileReader('cad4.mp4','VideoOutputDataType','uint8');

blob =vision.BlobAnalysis('MinimumBlobArea',300);

player = vision.DeployableVideoPlayer;

while ~isDone(reader)
  frame = step(reader);
  
  fgMask = step(detector,frame);
  [~,~,bbox] = step(blob,fgMask);
  
  J = insertShape(frame,'rectangle',bbox);
    
  step(player,J);
end

release(detector);
release(reader);
release(blob);
release(player);
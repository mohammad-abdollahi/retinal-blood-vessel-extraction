function [sen, spec, acc] = Scores(result,groundTruth)

TP=0;FP=0;TN=0;FN=0;
for i=1:584
  for j=1:565
      if(groundTruth(i,j)==1 && result(i,j)==1)
          TP=TP+1;
      elseif(groundTruth(i,j)==0 && result(i,j)==1)
          FP=FP+1;
      elseif(groundTruth(i,j)==0 && result(i,j)==0)
          TN=TN+1;
      else
          FN=FN+1;
      end
  end
end

sen = TP/(TP+FN);
spec = TN/(TN+FP);
acc = TP/(TP+FP);

end
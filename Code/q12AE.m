clear q1
load  DataTrn xe ye
load  DataTst xv yv

Run =10;

%i=0;
%for L=8:+10:160 
 %   i=i+1;
% tic
for j = 1:Run
    %rng('default');
    hiddenSize = 32;
    % Training AE
    autoenc1 = trainAutoencoder(xe',hiddenSize,...
    'L2WeightRegularization',7.5700e-04,...
    'SparsityRegularization',0.9033,...%0.97
    'SparsityProportion',0.4191,'MaxEpoch',100,'ShowProgressWindow',false);
    
    features1=encode(autoenc1,xe');
    hiddenSize = round(hiddenSize/2);
    
   
  
    autoenc2 = trainAutoencoder(features1,hiddenSize,...
    'L2WeightRegularization',7.5700e-04,...
    'SparsityRegularization',0.9033,...%0.97
    'SparsityProportion',0.4191,'MaxEpoch',100,'ShowProgressWindow',false);

    features2 = encode(autoenc2,features1);
   
    
    
    
    softnet = trainSoftmaxLayer(features2,ye','LossFunction','mse','MaxEpoch',200,'ShowProgressWindow',false);
    deepnet = stack(autoenc1,autoenc2,softnet);
    
    [deepnet,tr]= train(deepnet,xe',ye');
               

            %Testeamos el entrenamiento
        fault_type = sim(deepnet,xe');

        [c,cm,ind,per] = confusion(ye',fault_type);
        accuracy=1-c;

        Erun(j)= accuracy;
   % mseError1 = mse(ye' - fault_type);
    %Erun(j)= mseError1;
    
    DNRun{j} = deepnet;
    
    %{
    if mseError1==0
       break;
    end
    %}
end
%[~,k]=min(abs(Erun));
[~,k]=max(abs(Erun));
error1= Erun(k);
deepnet=DNRun{k};
%end
fprintf('\n  ACC: %f ',error1)
%toc;

save redFinal deepnet Erun

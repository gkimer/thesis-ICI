clear q1
load  DataTrn xe ye
load  DataTst xv yv

Run =15;

%i=0;
%for L=8:+10:160 
 %   i=i+1;
% tic
for j = 1:Run
    %rng('default');
    hiddenSize = 34;
    % Training AE
    autoenc1 = trainAutoencoder(xe',hiddenSize,...
    'L2WeightRegularization',0.0096,...
    'SparsityRegularization',0.9485,...%0.97
    'SparsityProportion',0.4245,'MaxEpoch',100,'ShowProgressWindow',false);
    
    features1=encode(autoenc1,xe');
    hiddenSize = round(hiddenSize/2);
    
   
   %{ 
    autoenc2 = trainAutoencoder(features1,hiddenSize,...
    'L2WeightRegularization',0.000804517763336771,...
    'SparsityRegularization',0.9824,...%0.97
    'SparsityProportion',0.4807,'MaxEpoch',100,'ShowProgressWindow',false);

    features2 = encode(autoenc2,features1);
    %}
    
    
    
   % softnet = trainSoftmaxLayer(features2,ye','LossFunction','mse','MaxEpoch',200,'ShowProgressWindow',false);
    %deepnet = stack(autoenc1,autoenc2,softnet);
    softnet = trainSoftmaxLayer(features1,ye','LossFunction','mse','MaxEpoch',200,'ShowProgressWindow',false);
    deepnet = stack(autoenc1,softnet);
    [deepnet,tr]= train(deepnet,xe',ye');
               
    %Testeamos el entrenamiento

    
    %Accuracy
    %[c,cm,ind,per] = confusion(ye',fault_type);
    %accuracy=1-c;
    %Erun(j)= accuracy;
    
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
fprintf('\n  mse: %f ',error1)
%toc;

save redFinal deepnet Erun

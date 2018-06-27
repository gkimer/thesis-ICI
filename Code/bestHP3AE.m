clear
load  DataTrn xe ye
load  DataTst xv yv

Run =5;
tic
i=0;

CANT=50;
rng('shuffle');
%R= [0.05 0.5]; %sparsityproportion
R=[0.9 0.99]; %sparsityregularizer
%R = [0.0005 0.001];%weightregularizer

HP = rand(1,CANT,'single')*range(R)+min(R);

%HP= 40:+2:80;   %hiddennodes




HP=sort(HP);
for L=1:size(HP,2)
    i=i+1;
    for j = 1:Run

        hiddenSize = 40;
        % Training AE
        autoenc1 = trainAutoencoder(xe',hiddenSize,...
        'L2WeightRegularization',6.5346e-04,...
        'SparsityRegularization',HP(L),...
        'SparsityProportion', 0.3578,'MaxEpoch',100,'ShowProgressWindow',false);

        features1=encode(autoenc1,xe');
        hiddenSize = round(hiddenSize/2);

        autoenc2 = trainAutoencoder(features1,hiddenSize,...
        'L2WeightRegularization',6.5346e-04,...
        'SparsityRegularization',HP(L),...
        'SparsityProportion', 0.3578,'MaxEpoch',100,'ShowProgressWindow',false);

        features2 = encode(autoenc2,features1);
        hiddenSize = round(hiddenSize/2);

        autoenc3 = trainAutoencoder(features2,hiddenSize,...
        'L2WeightRegularization',6.5346e-04,...
        'SparsityRegularization',HP(L),...
        'SparsityProportion', 0.3578,'MaxEpoch',100,'ShowProgressWindow',false);

        features3 = encode(autoenc3,features2);

        softnet = trainSoftmaxLayer(features3,ye','LossFunction','mse','MaxEpoch',200,'ShowProgressWindow',false);
        
        deepnet = stack(autoenc1,autoenc2,autoenc3,softnet);
        deepnet = train(deepnet,xe',ye');

        %Testeamos el entrenamiento
        fault_type = sim(deepnet,xe');

        [c,cm,ind,per] = confusion(ye',fault_type);
        accuracy=1-c;

        ARun(j)= accuracy;
        DNRun{j} = deepnet;
    end
    [~,k]=max(abs(ARun));
    AccIter(i)= ARun(k);
    deepnetIter{i}=DNRun{k};
end
    [~,k]=max(abs(AccIter));
    AccuracyFinal= AccIter(k);
    deepnetFinal=deepnetIter{k};
    fprintf('\n  ACCURACY: %f ',AccuracyFinal)

toc
save Bestsr3AEdataset5 deepnetFinal AccuracyFinal AccIter HP k
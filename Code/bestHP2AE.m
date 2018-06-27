clear
load  DataTrn xe ye
load  DataTst xv yv

Run =5;
tic
i=0;

CANT=50;
rng('shuffle');
R= [0.05 0.5]; %sparsityproportion
%R=[0.9 0.99]; %sparsityregularizer
%R = [0.0005 0.001];%weightregularizer

HP = rand(1,CANT,'single')*range(R)+min(R);

%HP= 20:+2:50;   %hiddennodes




HP=sort(HP);
for L=1:size(HP,2)
    i=i+1;
    for j = 1:Run

        hiddenSize = 32 ;
        % Training AE
        autoenc1 = trainAutoencoder(xe',hiddenSize,...
        'L2WeightRegularization',7.5700e-04,...
        'SparsityRegularization',0.9033,...
        'SparsityProportion',HP(L),'MaxEpoch',100,'ShowProgressWindow',false);

        features1=encode(autoenc1,xe');
        hiddenSize = round(hiddenSize/2);

        autoenc2 = trainAutoencoder(features1,hiddenSize,...
        'L2WeightRegularization',7.5700e-04,...
        'SparsityRegularization',0.9033,...
        'SparsityProportion',HP(L),'MaxEpoch',100,'ShowProgressWindow',false);

        features2 = encode(autoenc2,features1);

        softnet = trainSoftmaxLayer(features2,ye','LossFunction','mse','MaxEpoch',200,'ShowProgressWindow',false);
        
        deepnet = stack(autoenc1,autoenc2,softnet);
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
save Bestsp2AEdataset5ssdasda deepnetFinal AccuracyFinal AccIter HP k
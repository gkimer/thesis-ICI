function [bAE,iError] = bestAE2(xe,maxNodes)
   %0.51 tira como el mejor sparsity proportion
   load('DataTrn.mat')
    mseError=inf;
    %k=1;
    %iError=(1:496);
    iError=(1:maxNodes);
    
    autoenc1 = trainAutoencoder(xe',153,...
            'L2WeightRegularization',0.004,...
            'SparsityRegularization',4,...
            'SparsityProportion',0.4920,'ShowProgressWindow',false,'MaxEpoch',200);
    features1=encode(autoenc1,xe');
    %for i=0.005:0.001:maxNodes  
    for i=11:maxNodes

        autoenc2 = trainAutoencoder(features1,i,...
        'L2WeightRegularization',0.002,...
        'SparsityRegularization',4,...
        'SparsityProportion',0.051,'MaxEpoch',200,'ShowProgressWindow',false);

        features2 = encode(autoenc2,features1);

        softnet = trainSoftmaxLayer(features2,ye','LossFunction','mse','MaxEpoch',400,'ShowProgressWindow',false);
        deepnet = stack(autoenc1,autoenc2,softnet);
        deepnet = train(deepnet,xe',ye');

        %Testeamos el entrenamiento
        fault_type = sim(deepnet,xe');
        mseError1 = mse(ye' - fault_type);
        
            
        if(mseError>mseError1)
            mseError=mseError1;
            bAE=deepnet;
        end
        iError(i)=mseError1;
        %iError(k)=mseError1;
        %k=k+1;
    end
end
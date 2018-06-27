function [bAE,iError] = bestAE(xe,maxNodes)
   %0.51 tira como el mejor sparsity proportion
    mseError=inf;
    k=1;
    %iError=(1:496);
    %iError=(1:maxNodes);
    %for i=0.0005:+0.0005:0.01
    %for i=1:maxNodes
    for L=0.05:+0.05:0.5 
        autoenc1 = trainAutoencoder(xe',29,...
            'L2WeightRegularization',0.004,...
            'SparsityRegularization',4,...
            'SparsityProportion',L,'ShowProgressWindow',false,'MaxEpoch',100,'UseGPU',true);
        XReconstructed = predict(autoenc1,xe');
        mseError2 = mse(xe'-XReconstructed);
        if(mseError>mseError2)
            mseError=mseError2;
            bAE=autoenc1;
        end
        %iError(i)=mseError2;
        iError(k)=mseError2;
        k=k+1;
    end
    [~,k]=min(iError);
    menorError=iError(k);
end
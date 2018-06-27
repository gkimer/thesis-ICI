function X = caracteristicas(signal)
    X=[];
    minImf=inf;
    for i=1:size(signal,1)
        IMF = emd(signal(i,:));%;,'FIXE_H',10);
        %Encontrar la minima cantidad de IMF
        size(IMF,1);
        if minImf > size(IMF,1)
            minImf=size(IMF,1);
           % emd_visu(signal(i,:),1:length(signal(i,:)),IMF);
        end
        for j=1:minImf
            
            e_imf(i,j) = entropy(IMF(j,:));%/log2(size(signal,2)); %la normalizacion debe ser por N pero N debe ser el numero de simbolos distintos para que quede entre 0 y 1
            r_imf(i,j) = rms(IMF(j,:));
            k_imf(i,j) = kurtosis(IMF(j,:));
        end
        %entropiaSenal(i)=wentropy(signal(i,:),'shannon')/log(size(signal,2));
        %rmsSenal(i)=rms(signal(i,:));
        %kSenal(i)=kurtosis(signal(i,:));
    end
    %guardamos todas las caracteristicas en X
    for i=1:minImf
        X=[X r_imf(:,i) e_imf(:,i) k_imf(:,i)];
    end
   % X=[entropiaSenal' X];
    %normalizacion
    for i=1:size(X,2)
     X(:,i) = X(:,i)/max(abs(X(:,i)));
    end
    
    
    
    
    
end
function [signal,Y] = carga(path,tipo)
    %N=2048;   
    %1vuelta 400,66 app puntos de la se�al 1797RPM
    %416ptos para 1730RPM
    N=800;
    %MV=121200; %tama�o minimo de la se�al
    MV=120000;

    signal=[];

    %Inicio importacion se�al 
    cd(path);
    files = ls('*.mat'); 
    cellFiles = cellstr(files);

    for i=1:length(cellFiles)
        load(cellFiles{i,1});
    end

    variables=who('*DE_time');
    for i=1:length(variables)
        aux=eval(variables{i,1});
        signal =vertcat( vec2mat(aux(1:MV),N),signal);
    end

    %Target del tipo de fallo tipo
    
    Y = zeros(size(signal,1),10);
    Y(:,tipo)=1;
    %Y = zeros(size(signal,1),1);
    %Y(:)=tipo;
    %Fin importacion se�al
    cd ..
    cd ..
    cd ..
    cd ..
    cd ..


end


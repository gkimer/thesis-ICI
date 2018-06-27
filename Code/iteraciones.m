clear

direct=['C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 1\Motor-load-0-motor-speed-1797';'C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 2\Motor-load-1-motor-speed-1772';'C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 3\Motor-load-2-motor-speed-1750';'C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 4\Motor-load-3-motor-speed-1730';'C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 5\Motor-all-loads-motor-speed-a'];
trials=40;
for ii=5:5
   
    ACC=zeros(1,trials);
    tiempoTRARun=zeros(1,trials);
    tiempoTESRun=zeros(1,trials);
    tiempoRun=zeros(1,trials);
    fscores=cell(1,trials);
    
    
    %ETL(direct(ii,:))
    for l=1:trials
        tic
        reorden
        q1
        tiempoTRARun(l)=toc;
        tic
        q2
        ACC(l)=accuracy;
        fscores{l}=fscore;
        tiempoTESRun(l)=toc;
    end
    save(strcat('Prueba1AEnuevoeeeeeemd',num2str(ii)),'ACC','fscores','tiempoTESRun','tiempoTRARun')
   
end

function [caractAll,targetAll]=ETL(filepath)
%function ETL(filepath)

clear ETL
%filepath='C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 1\Motor-load-0-motor-speed-1797';
%filepath='C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 2\Motor-load-1-motor-speed-1772';
%filepath='C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 3\Motor-load-2-motor-speed-1750';
%filepath='C:\Users\GERD\Desktop\Codigos\COde\Datasets\Dataset 4\Motor-load-3-motor-speed-1730';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 5\Motor-load-0-motor-speed-1797';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 6\Motor-load-1-motor-speed-1772';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 7\Motor-load-2-motor-speed-1750';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 8\Motor-load-3-motor-speed-1730';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 9\Motor-load-0-motor-speed-1797';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 10\Motor-load-1-motor-speed-1772';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 11\Motor-load-2-motor-speed-1750';
%filepath='C:\Users\GERD\Desktop\COde\Datasets\Dataset 12\Motor-load-3-motor-speed-1730';



[signal1, target1]=carga(strcat(filepath,'\normal\normal'),1);
[caract1]=caracteristicas(signal1);
%señales de la bola con diferentes daños 
[signal2, target2]=carga(strcat(filepath,'\7\ball'),2);
[caract2]=caracteristicas(signal2);
[signal3, target3]=carga(strcat(filepath,'\14\ball'),3);
[caract3]=caracteristicas(signal3);
[signal4, target4]=carga(strcat(filepath,'\21\ball'),4);
[caract4]=caracteristicas(signal4);
%señales de la dañointerno con diferentes daños 
[signal5, target5]=carga(strcat(filepath,'\7\inner'),5);
[caract5]=caracteristicas(signal5);
[signal6, target6]=carga(strcat(filepath,'\14\inner'),6);
[caract6]=caracteristicas(signal6);
[signal7, target7]=carga(strcat(filepath,'\21\inner'),7);
[caract7]=caracteristicas(signal7);
%señales de la dañoexterno con diferentes daños 
[signal8, target8]=carga(strcat(filepath,'\7\outer'),8);
[caract8]=caracteristicas(signal8);
[signal9, target9]=carga(strcat(filepath,'\14\outer'),9);
[caract9]=caracteristicas(signal9);
[signal10, target10]=carga(strcat(filepath,'\21\outer'),10);
[caract10]=caracteristicas(signal10);


%Ver la minima cantidad de IMF y unirlas en una matriz de caracteristicas
minDim=min([size(caract1,2),size(caract2,2),size(caract3,2),size(caract4,2),size(caract5,2),size(caract6,2),size(caract7,2),size(caract8,2),size(caract9,2),size(caract10,2)]);

%caract1(:,1:minDim);caract2(:,1:minDim);caract3(:,1:minDim);caract4(:,1:minDim);caract5(:,1:minDim);caract6(:,1:minDim);caract7(:,1:minDim);caract8(:,1:minDim);caract9(:,1:minDim);caract10(:,1:minDim);

caractAll=[caract1(:,1:minDim);caract2(:,1:minDim);caract3(:,1:minDim);caract4(:,1:minDim);caract5(:,1:minDim);caract6(:,1:minDim);caract7(:,1:minDim);caract8(:,1:minDim);caract9(:,1:minDim);caract10(:,1:minDim)];

targetAll=[target1;target2;target3;target4;target5;target6;target7;target8;target9;target10];


%save(strcat('carTag',num2str(number)),'caractAll','targetAll');
save('carTag','caractAll','targetAll');
end

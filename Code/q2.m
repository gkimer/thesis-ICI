clear q2
load DataTst
load redFinal

fault_type = sim(deepnet,xv');
%fault_type = deepnet(xv');
% Aplicación de los datos de test en la red

er = yv' - fault_type;

% obtencion F-score
[c,cm,ind,per] = confusion(yv',fault_type);

precision = per(:,3);%true positive rate

Rden =  sum(cm,2);%En la suma de la columna obtenemos vp+fn
Rnom = diag(cm);%en la diagonal se encuentran los valores vp
sensibilidad= Rnom./Rden;


fscore = 2*(precision.*sensibilidad)./(sensibilidad+precision);
%{
% Confusion Matrix
figure(3)
plotconfusion(yv',fault_type)
title('Confusion matrix')
axis tight
grid on
%}
display(fscore)
display(sensibilidad)
display(precision)
accuracy=1-c;
display(accuracy)



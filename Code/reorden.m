clear reorden
load carTag_eemd06
porcentaje=0.7;
XR=zeros(size(caractAll));
YR=zeros(size(targetAll));
%Reordenar las muestras y targets
orden = randperm(size(caractAll,1));

for i=1:size(caractAll,1)
    XR(orden(i),:) = caractAll(i,:);
    YR(orden (i),:) = targetAll(i,:);
end
%normalizacion
%for i=1:size(caractAll,2)
 %XN(:,i) = XR(:,i)/max(abs(XR(:,i)));
%end
%XR=XN;
%Data para el Training
L=floor(porcentaje*size(caractAll,1));

xe=XR(1:L,:);
ye=YR(1:L,:);

%Data para el testing
xv=XR(L+1:end,:);
yv=YR(L+1:end,:);


%Guardamos los datos


save  DataTrn xe ye
save  DataTst xv yv

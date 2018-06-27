figure
%subplot(size(IMF,1),1,i) 
for i=1:size(IMF,1)
    subplot(size(IMF,1),1,i)
    plot(IMF(i,:)','DisplayName','IMF')
end
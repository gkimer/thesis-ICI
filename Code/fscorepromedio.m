
matrix=[];
for i=1:20
	matrix= [matrix;fscores{i}' ];
end
sfemd1ae=mean(matrix(1:20,:))*100;
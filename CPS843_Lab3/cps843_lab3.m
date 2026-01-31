data=[ 1900 75.995;
       1910 91.972;
       1920 105.711;
       1930 123.203;
       1940 131.669;
       1950 150.697;
       1960 179.323;
       1970 203.212;
       1980 226.505;
       1990 249.633;
       2000 281.422;
       2010 308.748;];
   
g=[data(:,1)];
tMeasured=[data(:,2)];
a=polyfit(g, tMeasured, 2);

gModel=min(g):0.01:max(g);
tModelled=polyval(a, gModel);

fittedDates = [2020];
fittedY = polyval(a, fittedDates);
disp(fittedY);

figure
plot(gModel,tModelled,'r-','LineWidth',2);
hold on
plot(g,tMeasured,'kx','MarkerSize',10)
legend('Fitted Poly','Input Data','Location','NorthWest');

%%

% Part 2

%load('object3d.mat');

figure; pcshow(ptCloud);
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)');
title('Original Point Cloud');

max_dist = 0.01;

roi = [-inf,0.5,0.2,0.4,0.1,inf];
sampleIndices = findPointsInROI(ptCloud,roi);


[model,inlierIndices] = pcfitsphere(ptCloud,max_dist,'SampleIndices',sampleIndices);
globe = select(ptCloud,inlierIndices);
hold on;
plot(model);

figure;
pcshow(globe);
title('Globe Point Cloud');
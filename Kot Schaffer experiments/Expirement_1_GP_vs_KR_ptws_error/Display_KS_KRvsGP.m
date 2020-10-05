fig1 = figure(1);
clf(fig1);
hold on
plot(Qtt(:,1),Qtt(:,2),'b*');
plot(KRPtt(:,1),KRPtt(:,2),'r*');
plot(GPPtt(:,1),GPPtt(:,2),'g*');

fig2 = figure(2);
clf(fig2);
hold on
plot(GAbsErrors,'g');
plot(KAbsErrors,'r');

fig3 = figure(3);
clf(fig3);
hold on
plot3(Qtt(:,1),Qtt(:,2),KAbsErrors(:,1),'r*');
plot3(Qtt(:,1),Qtt(:,2),GAbsErrors(:,1),'g*');
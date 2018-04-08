x=linspace(0,1,50);
plot(x(2:end),th1(2:end),'r',x(2:end),th5(2:end),'b',x(2:end),th20(2:end),...
    'g',x(2:end),t1ext(2:end),'r-.',x(2:end),t5ext(2:end),'b-.',x(2:end),t20ext(2:end),'g-.');
xlabel('plate distance');
ylabel('theta temperature');
legend('k=1','k=5','k=20','k=1 exact', 'k=5 exact', 'k=20 exact');
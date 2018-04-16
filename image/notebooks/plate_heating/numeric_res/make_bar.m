function iters = make_bar(k, avg)
assert(k==1 || k==5 || k==20);
if nargin < 2
    avg = false;
end

studies = ["kFDSN%d.mat" "kFNSD%d.mat" "kFDSR%d.mat" "kFNSR%d.mat" "kFPSP%d.mat"];
studies_avg = ["kFDSN_avg%d.mat" "kFNSD_avg%d.mat" "kFDSR_avg%d.mat" "kFNSR_avg%d.mat" "kFPSP_avg%d.mat"];

NN = zeros(5,1,'int32');
AVGS = zeros(5,1);
for i=1:5
    if ~avg
        fn = sprintf(studies(i), k);
    else
        fn = sprintf(studies_avg(i), k);
    end
    load(fn, 'N', 'avg_pc_its');
    NN(i) = N;
    AVGS(i) = avg_pc_its;
end

label = categorical({'FDSN' 'FNSD' 'FDSR' 'FNSR' 'FPSP'});
label_avg = categorical({'FDSN\_avg' 'FNSD\_avg' 'FDSR\_avg' 'FNSR\_avg' 'FPSP\_avg'});

colors = ['b' 'y' 'r' 'g' 'm'];

avg_title = sprintf('Average Iterations for k=%d', k);
if avg
    avg_title = sprintf('Average Iterations for k=%d with Averaging', k);
end
figure(1);
for i=1:5
    if ~avg
        ll = label(i);
    else
        ll = label_avg(i);
    end
    bar1(i) = bar(ll, AVGS(i));
    set(bar1(i), 'FaceColor', colors(i));
    bar_top = sprintf('%.3f', AVGS(i));
    text(ll, AVGS(i)+0.2, bar_top);
    hold on;
end
title(avg_title, 'Interpreter', 'latex');
ylabel('average correction iterations', 'Interpreter', 'latex');
ylim([0 max(AVGS)+2]);

figure(2);
for i=1:5
    if ~avg
        ll = label(i);
    else
        ll = label_avg(i);
    end
    bar2(i) = bar(ll, NN(i));
    set(bar2(i), 'FaceColor', colors(i));
    bar_top = sprintf('%d', NN(i));
    text(ll, double(NN(i))+25.0, bar_top);
    hold on;
end
NN_title = sprintf('Total number of coupling steps for k=%d', k);
if avg
    NN_title = sprintf('Total number of coupling steps for k=%d with Averaging', k);
end
max_count = max(NN);
title(NN_title, 'Interpreter', 'latex');
ylabel('total coupling steps', 'Interpreter', 'latex');
ylim([0 max(NN)+50]);

iters = zeros(max_count, 5);

logfile = ["../FDSN%d.log" "../FNSD%d.log" "../FDSR%d.log" "../FNSR%d.log" "../FPSP%d.log"];
logfile_avg = ["../FDSNavg%d.log" "../FNSD_avg%d.log" "../FDSR_avg%d.log" "../FNSR_avg%d.log" "../FPSP_avg%d.log"];

for i = 1:5
    if ~avg
        fn = sprintf(logfile(i), k);
    else
        fn = sprintf(logfile_avg(i), k);
    end
    iters(1:NN(i), i) = parse_log(fn, NN(i));
end

figure(3);
bar3 = bar(iters(1:10,:));
for i=1:5
    set(bar3(i), 'FaceColor', colors(i));
end
title_10 = sprintf('First 10 coupling steps correction iterations for k=%d', k);
if avg
    title_10 = sprintf('First 10 coupling steps correction iterations for k=%d with Averaging', k);
end
title(title_10, 'Interpreter', 'latex');
xlabel('coupling steps', 'Interpreter', 'latex');
ylabel('correction iterations', 'Interpreter', 'latex');
if ~avg
    legend('FDSN','FNSD', 'FDSR', 'FNSR', 'FPSP', 'Location', 'northeast');
else
    legend('FDSN\_avg','FNSD\_avg', 'FDSR\_avg', 'FNSR\_avg', 'FPSP\_avg', 'Location', 'northeast');
end

avg_100 = zeros(5,1);
avg_10 = zeros(5,1);
for i=1:5
    avg_100(i) = sum(iters(1:100,i))*0.01;
    avg_10(i) = sum(iters(1:10,i))*0.1;
end

figure(4);
for i=1:5
    if ~avg
        ll = label(i);
    else
        ll = label_avg(i);
    end
    bar4(i) = bar(ll, avg_10(i));
    set(bar4(i), 'FaceColor', colors(i));
    bar_top = sprintf('%.3f', avg_10(i));
    text(ll, avg_10(i)+0.2, bar_top);
    hold on;
end
title_10_avg = sprintf('First 10 coupling steps average correction iterations for k=%d', k);
if avg
    title_10_avg = sprintf('First 10 coupling steps average correction iterations for k=%d with Averaging', k);
end
title(title_10_avg, 'Interpreter', 'latex');
ylabel('correction iterations', 'Interpreter', 'latex');
ylim([0 max(avg_10)+2.5]);

figure(5);
for i=1:5
    if ~avg
        ll = label(i);
    else
        ll = label_avg(i);
    end
    bar5(i) = bar(ll, avg_100(i));
    set(bar5(i), 'FaceColor', colors(i));
    bar_top = sprintf('%.3f', avg_100(i));
    text(ll, avg_100(i)+0.2, bar_top);
    hold on;
end
title_100_avg = sprintf('First 100 coupling steps average correction iterations for k=%d', k);
if avg
    title_100_avg = sprintf('First 100 coupling steps average correction iterations for k=%d with Averaging', k);
end
title(title_100_avg, 'Interpreter', 'latex');
ylabel('correction iterations', 'Interpreter', 'latex');
ylim([0 max(avg_10)+2.5]);
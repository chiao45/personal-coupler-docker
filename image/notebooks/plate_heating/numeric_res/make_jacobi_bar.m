function make_jacobi_bar()
k = int32([1 5 20]);
jmat = ["kFPSPJ1.mat" "kFPSPJ5.mat" "kFPSPJ20.mat"];
njmat = ["kFPSP1.mat" "kFPSP5.mat" "kFPSP20.mat"];

AVGS = zeros(3,2);
for i=1:3
    load(jmat(i), 'avg_pc_its');
    AVGS(i,1)=avg_pc_its;
    load(njmat(i), 'avg_pc_its');
    AVGS(i,2)=avg_pc_its;
end

label = categorical({'1' '1'; '5' '5'; '20' '20'});

figure(1);
bar(label,AVGS);
title('Average Correction Cost of Jacobi FPSP vs. Gauss-Seidel FPSP', 'Interpreter', 'latex');
xlabel('$$k=\frac{\kappa_s}{\kappa_f}$$', 'Interpreter', 'latex');
ylabel('iterations', 'Interpreter', 'latex');
legend('FPSP-J', 'FPSP-GS', 'Location', 'northeast');

AVGS100 = zeros(3,2);

jlogs = ["../FPSPJ1.log" "../FPSPJ5.log" "../FPSPJ20.log"];
njlogs = ["../FPSP1.log" "../FPSP5.log" "../FPSP20.log"];

iters = zeros(500,1);

for i=1:3
    iters(:) = parse_log(jlogs(i), 500);
    AVGS(i,1) = sum(iters(1:10))*0.1;
    AVGS100(i,1) = sum(iters(1:100))*0.01;
    iters(:) = parse_log(njlogs(i), 500);
    AVGS(i,2) = sum(iters(1:10))*0.1;
    AVGS100(i,2)=sum(iters(1:100))*0.01;
end

figure(2);
bar(label, AVGS);
title('Average Correction Cost of Jacobi FPSP vs. Gauss-Seidel FPSP for First 10 Steps', 'Interpreter', 'latex');
xlabel('$$k=\frac{\kappa_s}{\kappa_f}$$', 'Interpreter', 'latex');
ylabel('iterations', 'Interpreter', 'latex');
legend('FPSP-J', 'FPSP-GS', 'Location', 'northeast');

figure(3);
bar(label, AVGS100);
title('Average Correction Cost of Jacobi FPSP vs. Gauss-Seidel FPSP for First 100 Steps', 'Interpreter', 'latex');
xlabel('$$k=\frac{\kappa_s}{\kappa_f}$$', 'Interpreter', 'latex');
ylabel('iterations', 'Interpreter', 'latex');
legend('FPSP-J', 'FPSP-GS', 'Location', 'northeast');

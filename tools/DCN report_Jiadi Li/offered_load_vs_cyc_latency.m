clear
clc
% 

packet_size=20;
injection_rate=[0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.01];
offered_load= injection_rate * packet_size;

%simulation results.
average_cyc_delay_dor_m=[65.5995,65.0477,68.7835,71.1768,73.0843,74.734,75.3401,78.3956,82.3129, 86.1775];
average_cyc_delay_dor_t=[63.7147,63.6184,65.3501,67.3304,67.0462,69.3935,70.6339,72.0942,73.7559,75.7471 ];
average_cyc_delay_romm_m=[64.5185,68.1431,69.3655,71.7154,73.3628,75.2783,79.8101,82.4407,84.3305,90.3535 ];
average_cyc_delay_val_m=[103.59,107.192,111.245,116.321,121.798,136.856,149.083,169.714,207.624,314.263];
average_cyc_delay_miniadapt_m=[66.2407,66.3927,71.2497,73.0061, 76.4463,78.6048,84.7678,86.7904,94.2925,97.0227];
average_cyc_delay_miniadapt_t=[63.9306,64.3196,67.6409,69.9848,70.2829,74.6027, 76.7594,80.7171,84.1109, 89.9289 ];


grid on
plot(offered_load,average_cyc_delay_dor_m,'r-*','LineWidth',3);
hold on
plot(offered_load,average_cyc_delay_dor_t,'y-X','LineWidth',3);
hold on
plot(offered_load,average_cyc_delay_romm_m,'g-X','LineWidth',3);
hold on
plot(offered_load,average_cyc_delay_val_m,'b-*','LineWidth',3);
hold on
plot(offered_load,average_cyc_delay_miniadapt_m,'k-*','LineWidth',3);
hold on
plot(offered_load,average_cyc_delay_miniadapt_t,'k-X','LineWidth',3);
hold on



xlabel('offered load')
ylabel('average cycle delay')
title('offered load versus average cycle delay(uniform)')
legend('dimension-order routing(mesh)','dimension-order routing(torus)','ROMM routing(mesh)','VAL(mesh)','minimal adapting(mesh)','minimal adapting(torus)')


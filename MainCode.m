close all;
clc;
clear;

filesOne = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\PitotProbeToPressureTransducer');
filesTwo = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\VenturiTubeToPressureTransducer');

s303_1_File = strcat(filesOne(11).folder,'\',filesOne(11).name);
s303_2_File = strcat(filesTwo(11).folder,'\',filesTwo(11).name);

s303_1_Data = load(s303_1_File);
s303_2_Data = load(s303_2_File);

areaRatio = 1 / 9.5;
R = 8.3145; %J/molK

pitotVelocity = @(deltaP,Tatm,Patm) sqrt(2 .* deltaP .* ((R .* Tatm) ./ Patm));
venturiVelocity = @(deltaP,Tatm,Patm) sqrt((2 .* deltaP .* R .* Tatm) ./ (Patm .* (1 - areaRatio^2)));

pitotWater = zeros([500,5]);
pitotTransducer = zeros([500,5]);
venturiWater = zeros([500,5]);
venturiTransducer = zeros([500,5]);

for i=1:500
    
    threeVolt = 500;
    fiveVolt = 1000;
    sevenVolt = 1500;
    nineVolt = 2000;
    
    %Pitot-Static Probe to Pressure Transducer s303_1
    pitotTransducer(i,1) = pitotVelocity(s303_1_Data(i,3),s303_1_Data(i,2),s303_1_Data(i,1));
    pitotTransducer(i,2) = pitotVelocity(s303_1_Data(i+threeVolt,3),s303_1_Data(i+threeVolt,2),s303_1_Data(i+threeVolt,1));
    pitotTransducer(i,3) = pitotVelocity(s303_1_Data(i+fiveVolt,3),s303_1_Data(i+fiveVolt,2),s303_1_Data(i+fiveVolt,1));
    pitotTransducer(i,4) = pitotVelocity(s303_1_Data(i+sevenVolt,3),s303_1_Data(i+sevenVolt,2),s303_1_Data(i+sevenVolt,1));
    pitotTransducer(i,5) = pitotVelocity(s303_1_Data(i+nineVolt,3),s303_1_Data(i+nineVolt,2),s303_1_Data(i+nineVolt,1));
    %Venturi Tube to Water Manometer s303_1
    venturiWater(i,1) = venturiVelocity(s303_1_Data(i,4),s303_1_Data(i,2),s303_1_Data(i,1));
    venturiWater(i,2) = venturiVelocity(s303_1_Data(i+threeVolt,4),s303_1_Data(i+threeVolt,2),s303_1_Data(i+threeVolt,1));
    venturiWater(i,3) = venturiVelocity(s303_1_Data(i+fiveVolt,4),s303_1_Data(i+fiveVolt,2),s303_1_Data(i+fiveVolt,1));
    venturiWater(i,4) = venturiVelocity(s303_1_Data(i+sevenVolt,4),s303_1_Data(i+sevenVolt,2),s303_1_Data(i+sevenVolt,1));
    venturiWater(i,5) = venturiVelocity(s303_1_Data(i+nineVolt,4),s303_1_Data(i+nineVolt,2),s303_1_Data(i+nineVolt,1));
    %Pitot-Static Probe to Water Manometer s303_2
    pitotWater(i,1) = pitotVelocity(s303_2_Data(i,3),s303_2_Data(i,2),s303_2_Data(i,1));
    pitotWater(i,2) = pitotVelocity(s303_2_Data(i+threeVolt,3),s303_2_Data(i+threeVolt,2),s303_2_Data(i+threeVolt,1));
    pitotWater(i,3) = pitotVelocity(s303_2_Data(i+fiveVolt,3),s303_2_Data(i+fiveVolt,2),s303_2_Data(i+fiveVolt,1));
    pitotWater(i,4) = pitotVelocity(s303_2_Data(i+sevenVolt,3),s303_2_Data(i+sevenVolt,2),s303_2_Data(i+sevenVolt,1));
    pitotWater(i,5) = pitotVelocity(s303_2_Data(i+nineVolt,3),s303_2_Data(i+nineVolt,2),s303_2_Data(i+nineVolt,1));
    %Venturi Tube to Pressure Transducer s303_2
    venturiTransducer(i,1) = venturiVelocity(s303_2_Data(i,4),s303_2_Data(i,2),s303_2_Data(i,1));
    venturiTransducer(i,2) = venturiVelocity(s303_2_Data(i+threeVolt,4),s303_2_Data(i+threeVolt,2),s303_2_Data(i+threeVolt,1));
    venturiTransducer(i,3) = venturiVelocity(s303_2_Data(i+fiveVolt,4),s303_2_Data(i+fiveVolt,2),s303_2_Data(i+fiveVolt,1));
    venturiTransducer(i,4) = venturiVelocity(s303_2_Data(i+sevenVolt,4),s303_2_Data(i+sevenVolt,2),s303_2_Data(i+sevenVolt,1));
    venturiTransducer(i,5) = venturiVelocity(s303_2_Data(i+nineVolt,4),s303_2_Data(i+nineVolt,2),s303_2_Data(i+nineVolt,1));
    
end
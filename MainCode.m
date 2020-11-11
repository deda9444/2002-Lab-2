close all;
clc;
clear;

filesOne = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\PitotProbeToPressureTransducer');
filesTwo = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\VenturiTubeToPressureTransducer');
filesThree = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData');

s303_1_File = strcat(filesOne(11).folder,'\',filesOne(11).name);
s303_2_File = strcat(filesTwo(11).folder,'\',filesTwo(11).name);
s303_3_File = strcat(filesOne(12).folder,'\',filesOne(12).name);
s303_4_File = strcat(filesTwo(12).folder,'\',filesTwo(12).name);
s303_5_File = strcat(filesOne(13).folder,'\',filesOne(13).name);
s303_6_File = strcat(filesTwo(13).folder,'\',filesTwo(13).name);
s303_7_File = strcat(filesOne(14).folder,'\',filesOne(14).name);
s303_8_File = strcat(filesTwo(14).folder,'\',filesTwo(14).name);

water_Data_File = strcat(filesThree(6).folder,'\',filesThree(6).name);

s303_1_Data = load(s303_1_File); %Pitot to Transducer
s303_2_Data = load(s303_2_File); %Venturi to Transducer
s303_3_Data = load(s303_3_File); %Pitot to Transducer
s303_4_Data = load(s303_4_File); %Venturi to Transducer
s303_5_Data = load(s303_5_File); %Pitot to Transducer
s303_6_Data = load(s303_6_File); %Venturi to Transducer
s303_7_Data = load(s303_7_File); %Pitot to Transducer
s303_8_Data = load(s303_8_File); %Venturi to Transducer

water_Data = readtable(water_Data_File);

areaRatio = 1 / 9.5;
R = 8.3145; %J/molK

pitotVelocity = @(deltaP,Tatm,Patm) sqrt(2 .* deltaP .* ((R .* Tatm) ./ Patm));
venturiVelocity = @(deltaP,Tatm,Patm) sqrt((2 .* deltaP .* R .* Tatm) ./ (Patm .* (1 - areaRatio^2)));

pitotWater = zeros([500,20]);
pitotTransducer = zeros([500,20]);
venturiWater = zeros([500,20]);
venturiTransducer = zeros([500,20]);

for i=1:500
    
    for j=0:4
        
        pitotTransducer(i,s303_7_Data((i+j*500),7)*2) = pitotVelocity(s303_7_Data((i+j*500),3),s303_7_Data((i+j*500),2),s303_7_Data((i+j*500),1));
        pitotTransducer(i,s303_1_Data((i+j*500),7)*2) = pitotVelocity(s303_1_Data((i+j*500),3),s303_1_Data((i+j*500),2),s303_1_Data((i+j*500),1));
        pitotTransducer(i,s303_5_Data((i+j*500),7)*2) = pitotVelocity(s303_5_Data((i+j*500),3),s303_5_Data((i+j*500),2),s303_5_Data((i+j*500),1));
        pitotTransducer(i,s303_3_Data((i+j*500),7)*2) = pitotVelocity(s303_3_Data((i+j*500),3),s303_3_Data((i+j*500),2),s303_3_Data((i+j*500),1));
        
        venturiTransducer(i,s303_8_Data((i+j*500),7)*2) = pitotVelocity(s303_8_Data((i+j*500),3),s303_8_Data((i+j*500),2),s303_8_Data((i+j*500),1));
        venturiTransducer(i,s303_2_Data((i+j*500),7)*2) = pitotVelocity(s303_2_Data((i+j*500),3),s303_2_Data((i+j*500),2),s303_2_Data((i+j*500),1));
        venturiTransducer(i,s303_6_Data((i+j*500),7)*2) = pitotVelocity(s303_6_Data((i+j*500),3),s303_6_Data((i+j*500),2),s303_6_Data((i+j*500),1));
        venturiTransducer(i,s303_4_Data((i+j*500),7)*2) = pitotVelocity(s303_4_Data((i+j*500),3),s303_4_Data((i+j*500),2),s303_4_Data((i+j*500),1));
        
    end
    
end

    %pitotWater = pitotVelocity(water,s303,s303)

    %S303_1 Venturi equation water
    %s303_2 Pitot equation water
    %S303_3 Venturi equation water
    %s303_4 Pitot equation water
    %S303_5 Venturi equation water
    %s303_6 Pitot equation water
    %S303_7 Venturi equation water
    %s303_8 Pitot equation water
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
rho_water = 997; %kg/m^3
g = 9.81; %m/s^2

pitotVelocity = @(deltaP,Tatm,Patm) sqrt(2 .* deltaP .* ((R .* Tatm) ./ Patm));
venturiVelocity = @(deltaP,Tatm,Patm) sqrt((2 .* deltaP .* R .* Tatm) ./ (Patm .* (1 - areaRatio^2)));

pitotWater = zeros([1,20]);
pitotTransducer = zeros([500,20]);
venturiWater = zeros([1,20]);
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
    
    %Row: 22 - Venturi to Manometer 0.5 2.5 4.5 6.5 8.5
    %Row: 6 - Venturi to Manometer 1 3 5 7 9
    %Row: 25 - Venturi to Manometer 303-6 1.5 3.5 5.5 7.5 9.5
    %Row: 3 - Venturi to Manometer 2 4 6 8 10
    
    %Row: 26 - Pitot to Manometer 0.5 2.5 4.5 6.5 8.5    
    %Row: 1 - Pitot to Manometer 1 3 5 7 9    
    %Row: 16 - Pitot to Manometer 1.5 3.5 5.5 7.5 9.5
    %Row: 4 - Pitot to Manometer 2 4 6 8 10
    
waterPressureVenturi = zeros([1,20]);
waterPressurePitot = zeros([1,20]);

iterate = 1;
    
for j=5:2:13
    
    waterPressureVenturi(1,iterate) = rho_water * g * water_Data{22,j}; %0.5 Volt start
    waterPressureVenturi(1,iterate+1) = rho_water * g * water_Data{6,j}; %1 Volt start
    waterPressureVenturi(1,iterate+2) = rho_water * g * water_Data{25,j}; %1.5 Volt start
    waterPressureVenturi(1,iterate+3) = rho_water * g * water_Data{3,j}; %2 Volt start
    
    waterPressurePitot(1,iterate) = rho_water * g * water_Data{26,j}; %0.5 Volt start
    waterPressurePitot(1,iterate+1) = rho_water * g * water_Data{1,j}; %1 Volt start
    waterPressurePitot(1,iterate+2) = rho_water * g * water_Data{16,j}; %1.5 Volt start
    waterPressurePitot(1,iterate+3) = rho_water * g * water_Data{4,j}; %2 Volt start
    
    iterate = iterate + 4;
    
end

%Using s303_7
atmosphericPressure = mean(s303_7_Data(:,1));
atmosphericTemperature = mean(s303_7_Data(:,2));

for i = 1:20
    
    pitotWater(i) = pitotVelocity(waterPressurePitot(i),atmosphericTemperature,atmosphericPressure);
    venturiWater(i) = venturiVelocity(waterPressureVenturi(i),atmosphericTemperature,atmosphericPressure);
    
end

%% Errororor

deltaRoomTemp = 0.25; %Degrees celsius
deltaManometer = 0.1; %Inches - needs to be converted
deltaTransducer = 1.5; %Percent - needs to be converted

deltaAtmosphericPressure = 0.0005; %Based off of the data

partialDifferentialPressurePitot = @(x) sqrt((x * (R + atmosphericTemperature)) / atmosphericPressure) / (sqrt(2) * x);
partialRoomTempPitot = @(x) x / (sqrt(2) * atmosphericPressure * sqrt((x * (R + atmosphericTemperature)) / atmosphericPressure));
partialAtmosphericPressurePitot = @(x) - (x * (R + atmosphericTemperature)) / (sqrt(2) * atmosphericPressure^2 * sqrt((x * (R + atmosphericTemperature))/atmosphericPressure));

partialDifferentialPressureVenturi = @(x) (R * atmosphericTemperature) / (sqrt(2) * (1 - areaRatio^2) * atmosphericPressure * sqrt((R * atmosphericPressure * x)/((1-areaRatio^2)*atmosphericPressure)));
partialRoomTempVenturi = @(x) (R * x) / (sqrt(2) * (1 - areaRatio^2) * atmosphericPressure * sqrt((R * atmosphericTemperature * x)/((1-areaRatio^2)*atmosphericPressure)));
partialAtmosphericPressureVenturi = @(x) (R * x * atmosphericTemperature) / (sqrt(2) * (1 - areaRatio^2) * atmosphericPressure^2 * sqrt((R * atmosphericTemperature * x)/((1-areaRatio^2)*atmosphericPressure)));

%%

deltaAirspeedPitotTransducer = zeros([500,20]);
deltaAirspeedVenturiTransducer = zeros([500,20]);

for i=1:500
    
    for j=0:4

        deltaAirspeedPitotTransducer(i,s303_7_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressurePitot(s303_7_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressurePitot(s303_7_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempPitot(s303_1_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedPitotTransducer(i,s303_1_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressurePitot(s303_1_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressurePitot(s303_1_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempPitot(s303_1_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedPitotTransducer(i,s303_5_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressurePitot(s303_5_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressurePitot(s303_5_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempPitot(s303_5_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedPitotTransducer(i,s303_3_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressurePitot(s303_3_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressurePitot(s303_3_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempPitot(s303_3_Data((i+j*500),3))*deltaRoomTemp));
        
        deltaAirspeedVenturiTransducer(i,s303_8_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressureVenturi(s303_8_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressureVenturi(s303_8_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempVenturi(s303_8_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedVenturiTransducer(i,s303_2_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressureVenturi(s303_2_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressureVenturi(s303_2_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempVenturi(s303_2_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedVenturiTransducer(i,s303_6_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressureVenturi(s303_6_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressureVenturi(s303_6_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempVenturi(s303_6_Data((i+j*500),3))*deltaRoomTemp));
        deltaAirspeedVenturiTransducer(i,s303_4_Data((i+j*500),7)*2) = sqrt(...
            (partialDifferentialPressureVenturi(s303_4_Data((i+j*500),3))*deltaTransducer)+...
            (partialAtmosphericPressureVenturi(s303_4_Data((i+j*500),3))*deltaAtmosphericPressure)+...
            (partialRoomTempVenturi(s303_4_Data((i+j*500),3))*deltaRoomTemp));

    end
    
end

%%

deltaAirspeedPitotManometer = zeros([1,20]);
deltaAirspeedVenturiManometer = zeros([1,20]);

for i = 1:20
    deltaAirspeedPitotManometer(i) = sqrt(...
        (partialDifferentialPressurePitot(waterPressurePitot(i))*deltaTransducer)+...
        (partialAtmosphericPressurePitot(waterPressurePitot(i))*deltaAtmosphericPressure)+...
        (partialRoomTempPitot(waterPressurePitot(i))*deltaRoomTemp));
    deltaAirspeedVenturiManometer(i) = sqrt(...
        (partialDifferentialPressureVenturi(waterPressurePitot(i))*deltaTransducer)+...
        (partialAtmosphericPressureVenturi(waterPressurePitot(i))*deltaAtmosphericPressure)+...
        (partialRoomTempVenturi(waterPressurePitot(i))*deltaRoomTemp));
end

%%

voltagesManometer = (0.5:0.5:10);
scatter(voltagesManometer,pitotWater)
title('pitotWater');
figure;
scatter(voltagesManometer,venturiWater)
title('venturiWater');

%%

voltagesTransducer = ones(2500,1);

for i = 1:2500
    
    

end
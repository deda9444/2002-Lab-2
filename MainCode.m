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
deltaManometer = 0.1; %Inches - needs to be converted ---------------------
deltaTransducer = 1.5; %Percent - needs to be converted -------------------

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

transducerGraphingData = zeros(10000,3);
%Column 1 is voltages
%Column 2 is pitot
%Column 3 is venturi

indexCounter = 1;

for i = 1:20
    
    for j = 1:500
        
        transducerGraphingData(indexCounter,1) = i / 2;
        transducerGraphingData(indexCounter,2) = pitotTransducer(j,i);
        transducerGraphingData(indexCounter,3) = venturiTransducer(j,i);
        indexCounter = indexCounter + 1;
        
    end

end

%% Graphing Pressure Transducer Data

figure
scatter(transducerGraphingData(:,1),transducerGraphingData(:,2))
title('pitotTransducer');
figure;
scatter(transducerGraphingData(:,1),transducerGraphingData(:,3))
title('venturiTransducer');

%% Part 6

boundaryfilesOne = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 1');
boundaryfilesTwo = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 2');
boundaryfilesThree = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 3');
boundaryfilesFour = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 4');
boundaryfilesFive = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 5');
boundaryfilesSix = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 6');
boundaryfilesSeven = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 7');
boundaryfilesEight = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 8');
boundaryfilesNine = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 9');
boundaryfilesTen = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 10');
boundaryfilesEleven = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\BoundaryLayerData\Port 11');

port_1_File = strcat(boundaryfilesOne(4).folder,'\',boundaryfilesOne(4).name);
port_2_File = strcat(boundaryfilesTwo(3).folder,'\',boundaryfilesTwo(3).name);
port_3_File = strcat(boundaryfilesThree(3).folder,'\',boundaryfilesThree(3).name);
port_4_File = strcat(boundaryfilesFour(3).folder,'\',boundaryfilesFour(3).name);
port_5_File = strcat(boundaryfilesFive(3).folder,'\',boundaryfilesFive(3).name);
port_6_File = strcat(boundaryfilesSix(3).folder,'\',boundaryfilesSix(3).name);
port_7_File = strcat(boundaryfilesSeven(3).folder,'\',boundaryfilesSeven(3).name);
port_8_File = strcat(boundaryfilesEight(3).folder,'\',boundaryfilesEight(3).name);
port_9_File = strcat(boundaryfilesNine(3).folder,'\',boundaryfilesNine(3).name);
port_10_File = strcat(boundaryfilesTen(3).folder,'\',boundaryfilesTen(3).name);
port_11_File = strcat(boundaryfilesEleven(3).folder,'\',boundaryfilesEleven(3).name);

port_1_Data = load(port_1_File);
port_2_Data = load(port_2_File);
port_3_Data = load(port_3_File);
port_4_Data = load(port_4_File);
port_5_Data = load(port_5_File);
port_6_Data = load(port_6_File);
port_7_Data = load(port_7_File);
port_8_Data = load(port_8_File);
port_9_Data = load(port_9_File);
port_10_Data = load(port_10_File);
port_11_Data = load(port_11_File);

boundaryVelocity1 = zeros(6000,1);
boundaryVelocity2 = zeros(6000,1);
boundaryVelocity3 = zeros(6000,1);
boundaryVelocity4 = zeros(6000,1);
boundaryVelocity5 = zeros(6000,1);
boundaryVelocity6 = zeros(6000,1);
boundaryVelocity7 = zeros(6000,1);
boundaryVelocity8 = zeros(6000,1);
boundaryVelocity9 = zeros(6000,1);
boundaryVelocity10 = zeros(6000,1);
boundaryVelocity11 = zeros(6000,1);

for i = 1:6000 %Yeag
    
    %deltaP,Tatm,Patm
    boundaryVelocity1(i) = pitotVelocity(port_1_Data(i,4),port_1_Data(i,2),port_1_Data(i,1));
    boundaryVelocity2(i) = pitotVelocity(port_2_Data(i,4),port_2_Data(i,2),port_2_Data(i,1));
    boundaryVelocity3(i) = pitotVelocity(port_3_Data(i,4),port_3_Data(i,2),port_3_Data(i,1));
    boundaryVelocity4(i) = pitotVelocity(port_4_Data(i,4),port_4_Data(i,2),port_4_Data(i,1));
    boundaryVelocity5(i) = pitotVelocity(port_5_Data(i,4),port_5_Data(i,2),port_5_Data(i,1));
    boundaryVelocity6(i) = pitotVelocity(port_6_Data(i,4),port_6_Data(i,2),port_6_Data(i,1));
    boundaryVelocity7(i) = pitotVelocity(port_7_Data(i,4),port_7_Data(i,2),port_7_Data(i,1));
    boundaryVelocity8(i) = pitotVelocity(port_8_Data(i,4),port_8_Data(i,2),port_8_Data(i,1));
    boundaryVelocity9(i) = pitotVelocity(port_9_Data(i,4),port_9_Data(i,2),port_9_Data(i,1));
    boundaryVelocity10(i) = pitotVelocity(port_10_Data(i,4),port_10_Data(i,2),port_10_Data(i,1));
    boundaryVelocity11(i) = pitotVelocity(port_11_Data(i,4),port_11_Data(i,2),port_11_Data(i,1));
    
end

figure
scatter(port_1_Data(:,6),boundaryVelocity1);
title('Velocity at Port vs Probe Height');
xlabel('Probe Height');
ylabel('Velocity at Port Location');

hold on

scatter(port_2_Data(:,6),boundaryVelocity2);
scatter(port_3_Data(:,6),boundaryVelocity3);
scatter(port_4_Data(:,6),boundaryVelocity4);
scatter(port_5_Data(:,6),boundaryVelocity5);
scatter(port_6_Data(:,6),boundaryVelocity6);
scatter(port_7_Data(:,6),boundaryVelocity7);
scatter(port_8_Data(:,6),boundaryVelocity8);
scatter(port_9_Data(:,6),boundaryVelocity9);
scatter(port_10_Data(:,6),boundaryVelocity10);
scatter(port_11_Data(:,6),boundaryVelocity11);

hold off

%--------------------------------------------------------------------------
freestreamVelocity1 = 0.95 * mean(boundaryVelocity1(5501:end));
freestreamVelocity2 = 0.95 * mean(boundaryVelocity2(5501:end));
freestreamVelocity3 = 0.95 * mean(boundaryVelocity3(5501:end));
freestreamVelocity4 = 0.95 * mean(boundaryVelocity4(5501:end));
freestreamVelocity5 = 0.95 * mean(boundaryVelocity5(5501:end));
freestreamVelocity6 = 0.95 * mean(boundaryVelocity6(5501:end));
freestreamVelocity7 = 0.95 * mean(boundaryVelocity7(5501:end));
freestreamVelocity8 = 0.95 * mean(boundaryVelocity8(5501:end));
freestreamVelocity9 = 0.95 * mean(boundaryVelocity9(5501:end));
freestreamVelocity10 = 0.95 * mean(boundaryVelocity10(5501:end));
freestreamVelocity11 = 0.95 * mean(boundaryVelocity11(5501:end));
%--------------------------------------------------------------------------

counter1 = 1;
counter2 = 1;
counter3 = 1;
counter4 = 1;
counter5 = 1;
counter6 = 1;
counter7 = 1;
counter8 = 1;
counter9 = 1;
counter10 = 1;
counter11 = 1;

port1Positions = 0;
port2Positions = 0;
port3Positions = 0;
port4Positions = 0;
port5Positions = 0;
port6Positions = 0;
port7Positions = 0;
port8Positions = 0;
port9Positions = 0;
port10Positions = 0;
port11Positions = 0;

for i = 1:length(boundaryVelocity1)
     
    if(abs(boundaryVelocity1(i) - freestreamVelocity1) <= 0.1)        
         port1Positions(counter1) = port_1_Data(i,6);  
         counter1 = counter1 + 1;
    end
    
    if(abs(boundaryVelocity2(i) - freestreamVelocity2) <= 0.1)        
         port2Positions(counter2) = port_2_Data(i,6);
         counter2 = counter2 + 1;
    end
    
    if(abs(boundaryVelocity3(i) - freestreamVelocity3) <= 0.1)        
         port3Positions(counter3) = port_3_Data(i,6);
         counter3 = counter3 + 1;
    end
    
    if(abs(boundaryVelocity4(i) - freestreamVelocity4) <= 0.1)        
         port4Positions(counter4) = port_4_Data(i,6);
         counter4 = counter4 + 1;
    end
    
    if(abs(boundaryVelocity5(i) - freestreamVelocity5) <= 0.1)        
         port5Positions(counter5) = port_5_Data(i,6);
         counter5 = counter5 + 1;
    end
    
    if(abs(boundaryVelocity6(i) - freestreamVelocity6) <= 0.1)        
         port6Positions(counter6) = port_6_Data(i,6);
         counter6 = counter6 + 1;
    end
    
    if(abs(boundaryVelocity7(i) - freestreamVelocity7) <= 0.1)        
         port7Positions(counter7) = port_7_Data(i,6);
         counter7 = counter7 + 1;
    end
    
    if(abs(boundaryVelocity8(i) - freestreamVelocity8) <= 0.1)        
         port8Positions(counter8) = port_8_Data(i,6);
         counter8 = counter8 + 1;
    end
    
    if(abs(boundaryVelocity9(i) - freestreamVelocity9) <= 0.1)        
         port9Positions(counter9) = port_9_Data(i,6);
         counter9 = counter9 + 1;
    end
    
    if(abs(boundaryVelocity10(i) - freestreamVelocity10) <= 0.1)        
         port10Positions(counter10) = port_10_Data(i,6); 
         counter10 = counter10 + 1;
    end
    
    if(abs(boundaryVelocity11(i) - freestreamVelocity11) <= 0.1)        
         port11Positions(counter11) = port_11_Data(i,6);
         counter11 = counter11 + 1;
    end
     
end

portEdge1 = mean(port1Positions);
portEdge2 = mean(port2Positions);
portEdge3 = mean(port3Positions);
portEdge4 = mean(port4Positions);
portEdge5 = mean(port5Positions);
portEdge6 = mean(port6Positions);
portEdge7 = mean(port7Positions);
portEdge8 = mean(port8Positions);
portEdge9 = mean(port9Positions);
portEdge10 = mean(port10Positions);
portEdge11 = mean(port11Positions);

portArray = [1,2,3,4,5,6,7,8,9,10,11];
portEdges = [portEdge1,portEdge2,portEdge3,portEdge4,portEdge5,portEdge6,portEdge7,portEdge8,portEdge9,portEdge10,portEdge11];

figure

scatter(portArray,portEdges);
xlabel('Port Number')
ylabel('Boundary Layer Thickness')
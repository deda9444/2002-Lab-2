close all;
clc;
clear;

filesOne = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\PitotProbeToPressureTransducer');
filesTwo = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\VenturiTubeToPressureTransducer');

pitotFile = strcat(filesOne(1).folder,'\',filesOne(1).name);
venturiFile = strcat(filesTwo(1).folder,'\',filesTwo(1).name);

pitotVelocity = load(pitotFile);
venturiVelocity = load(venturiFile);



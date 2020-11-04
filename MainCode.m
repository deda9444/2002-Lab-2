close all;
clc;
clear;

filesOne = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\PitotProbeToPressureTransducer');
filesTwo = dir('Aero Lab Windtunnel Calibration\Aero Lab 1 - 2019 Group Data\VelocityVoltageData\VenturiTubeToPressureTransducer');

pitotFile = strcat(filesOne(11).folder,'\',filesOne(11).name);
venturiFile = strcat(filesTwo(11).folder,'\',filesTwo(11).name); %S303_2

pitotVelocityData = load(pitotFile);
venturiVelocityData = load(venturiFile);



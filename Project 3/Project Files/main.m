% Gursahej & Emmanuel
clc
clear

profile on
%% walk

myFolder_walk = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/walk';
lambda_walk = 40;
walk = computeAlgos(myFolder_walk, lambda_walk);

%% Getin
myFolder_getin = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/getin';
lambda_getin = 20;
getin = computeAlgos(myFolder_getin, lambda_getin);

%% Getout
myFolder_getout = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/getout';
lambda_getout = 20;
getout = computeAlgos(myFolder_getout, lambda_getout);

%% trees
myFolder_trees = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/trees';
lambda_trees = 40;
trees = computeAlgos(myFolder_trees, lambda_trees);

%% movecam
myFolder_movecam = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/movecam';
lambda_movecam = 35;
movecam = computeAlgos(myFolder_movecam, lambda_movecam);

%% arenaA
myFolder_arenaA = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/ArenaA';
lambda_arenaA = 35;
arenaA = computeAlgos(myFolder_arenaA, lambda_arenaA);

%% arenaW
myFolder_arenaW = '/Users/gursahejsingh/Desktop/PSU/Fall 2018 PSu/CMPEN 454/Project 3/DataSets/ArenaW';
lambda_arenaW = 35;
arenaW = computeAlgos(myFolder_arenaW, lambda_arenaW);

profile viewer

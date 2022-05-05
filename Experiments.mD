## Experiments specification

- Experimento 1: 1 processo e batch size de 16
- Experimento 2: 2 processo e batch size de 16
- Experimento 3: 4 processo e batch size de 16
- Experimento 4: 8 processo e batch size de 16

## Execute experiment

To execute an experiment, for example the experiment 2, simply call the equivalent shell script, for the script 2 
'''
sh exp2.sh
'''

All scripts accept 2 parameters
- n : the number of times the experiment will be executed
- r : The name of the file to export the results.
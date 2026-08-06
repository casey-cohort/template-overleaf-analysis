#!/usr/bin/env bash

for script in analysis/*.R; do 
    echo "$script"
    Rscript "$script"; 
done

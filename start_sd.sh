#!/bin/bash

PS3='Select the server(s) you want to run: '
options=("All" "All EU" "ALL NA" "EU #1" "EU #2" "EU #3" "EU #4" "EU #5" "NA #1" "NA #2" "NA #3" "NA #4" "NA #5" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "All")
            ./server -fservers/sauerduels/eu1.cfg -seu1stats.log -d && ./server -fservers/sauerduels/eu2.cfg -seu2stats.log -d && ./server -fservers/sauerduels/eu3.cfg -seu3stats.log -d && ./server -fservers/sauerduels/eu4.cfg -seu4stats.log -d && ./server -fservers/sauerduels/eu5.cfg -seu5stats.log -d && ./server -fservers/sauerduels/na1.cfg -sna1stats.log -d && ./server -fservers/sauerduels/na2.cfg -sna2stats.log -d && ./server -fservers/sauerduels/na3.cfg -sna3stats.log -d && ./server -fservers/sauerduels/na4.cfg -sna4stats.log -d && ./server -fservers/sauerduels/na5.cfg -sna5stats.log -d
            ;;
        "All EU")
            ./server -fservers/sauerduels/eu1.cfg -seu1stats.log -d && ./server -fservers/sauerduels/eu2.cfg -seu2stats.log -d && ./server -fservers/sauerduels/eu3.cfg -seu3stats.log -d && ./server -fservers/sauerduels/eu4.cfg -seu4stats.log -d && ./server -fservers/sauerduels/eu5.cfg -seu5stats.log -d
            ;;
        "All NA")
            ./server -fservers/sauerduels/na1.cfg -sna1stats.log -d && ./server -fservers/sauerduels/na2.cfg -sna2stats.log -d && ./server -fservers/sauerduels/na3.cfg -sna3stats.log -d && ./server -fservers/sauerduels/na4.cfg -sna4stats.log -d && ./server -fservers/sauerduels/na5.cfg -sna5stats.log -d
            ;;
        "EU #1")
            ./server -fservers/sauerduels/eu1.cfg -seu1stats.log -d
            ;;
        "EU #2")
            ./server -fservers/sauerduels/eu2.cfg -seu2stats.log -d
            ;;
        "EU #3")
            ./server -fservers/sauerduels/eu3.cfg -seu3stats.log -d
            ;;
        "EU #4")
            ./server -fservers/sauerduels/eu4.cfg -seu4stats.log -d
            ;;
        "EU #5")
            ./server -fservers/sauerduels/eu5.cfg -seu5stats.log -d
            ;;
        "NA #1")
            ./server -fservers/sauerduels/na1.cfg -sna1stats.log -d
            ;;
        "NA #2")
            ./server -fservers/sauerduels/na2.cfg -sna2stats.log -d
            ;;
        "NA #3")
            ./server -fservers/sauerduels/na3.cfg -sna3stats.log -d
            ;;
        "NA #4")
            ./server -fservers/sauerduels/na4.cfg -sna4stats.log -d
            ;;
        "NA #5")
            ./server -fservers/sauerduels/na5.cfg -sna5stats.log -d
            ;;
        "Quit")
            break
            ;;
        *) echo Invalid option;;
    esac
done

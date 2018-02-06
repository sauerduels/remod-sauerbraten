#!/bin/bash

PS3='Select the server you want to run: '
options=("Primary #1" "Primary #2" "Primary #3" "Primary #4" "Primary US #1" "Backup #1" "Backup #2" "Backup #3" "Backup #4" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Primary #1")
            ./server -fservers/primary1.cfg -sp1stats.log -d
            ;;
        "Primary #2")
            ./server -fservers/primary2.cfg -sp2stats.log -d
            ;;
        "Primary #3")
            ./server -fservers/primary3.cfg -sp3stats.log -d
            ;;
        "Primary #4")
            ./server -fservers/primary4.cfg -sp4stats.log -d
            ;;
        "Primary US #1")
            ./server -fservers/primaryus1.cfg -spus1stats.log -d
            ;;
        "Backup #1")
            ./server -fservers/backup1.cfg -sb1stats.log -d
            ;;
        "Backup #2")
            ./server -fservers/backup2.cfg -sb2stats.log -d
            ;;
        "Backup #3")
            ./server -fservers/backup3.cfg -sb3stats.log -d
            ;;
        "Backup #4")
            ./server -fservers/backup4.cfg -sb4stats.log -d
            ;;
        "Quit")
            break
            ;;
        *) echo Invalid option;;
    esac
done

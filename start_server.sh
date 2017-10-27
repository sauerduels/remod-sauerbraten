#!/bin/bash

PS3='Select the server you want to run: '
options=("Primary #1" "Primary #2" "Primary #3" "Primary #4" "Backup #1" "Backup #2" "Backup #3" "Backup #4" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Primary #1")
            ./server -fcfg/primary1.cfg -d
            ;;
        "Primary #2")
            ./server -fcfg/primary2.cfg -d
            ;;
        "Primary #3")
            ./server -fcfg/primary3.cfg -d
            ;;
        "Primary #4")
            ./server -fcfg/primary4.cfg -d
            ;;
        "Backup #1")
            ./server -fcfg/backup1.cfg -d
            ;;
        "Backup #2")
            ./server -fcfg/backup2.cfg -d
            ;;
        "Backup #3")
            ./server -fcfg/backup3.cfg -d
            ;;
        "Backup #4")
            ./server -fcfg/backup4.cfg -d
            ;;
        "Quit")
            break
            ;;
        *) echo Invalid option;;
    esac
done

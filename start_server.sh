#!/bin/bash

PS3='Select the server you want to run: '
options=("Server #1" "Server #2" "Server #3" "Server #4" "Server #5" "Server #6" "Server US #1" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Server #1")
            ./server -fservers/server1.cfg -ss1stats.log -d
            ;;
        "Server #2")
            ./server -fservers/server2.cfg -ss2stats.log -d
            ;;
        "Server #3")
            ./server -fservers/server3.cfg -ss3stats.log -d
            ;;
        "Server #4")
            ./server -fservers/server4.cfg -ss4stats.log -d
            ;;
        "Server #5")
            ./server -fservers/server5.cfg -ss5stats.log -d
            ;;
        "Server #6")
            ./server -fservers/server6.cfg -ss6stats.log -d
            ;;
        "Server US #1")
            ./server -fservers/serverus1.cfg -ssus1stats.log -d
            ;;
        "Quit")
            break
            ;;
        *) echo Invalid option;;
    esac
done

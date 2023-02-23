
#!/bin/bash
#sync files over ssh with rsync
#hurr durr inefficient programming time

zenity-pw-entry() {
    zenity --password --username
}

zenity-entry() {
    zenity --entry --title="Zenity Entry Prompt" --text="$1"
}

zenity-info() {
    zenity --info --title="Zenity Info Prompt" --text="$1"
}

zenity-file-chooser() {
    zenity --file-selection --title="Zenity File Selection" --text="$1"
}

selection=$(zenity-file-chooser "Which file do you want to transfer?")
if [ ! -z "$selection" ];then
    ip=$(zenity-entry "Enter your target IP address")
    if [ ! -z "$ip" ];then
        login=$(zenity-pw-entry)
            if [ ! -z "$login" ];then
                user=$(echo $login | cut -d'|' -f1)
                pass=$(echo $login | cut -d'|' -f2)
                echo "sshpass -p $pass rsync $selection $user@$ip:~/Downloads/"
                for each in $selection
                    do
                    sshpass -p $pass rsync $each $user@$ip:~/Downloads/
                    done
            else
                zenity-info "No input. Goodbye!"
            fi
    else
        zenity-info "No input. Goodbye!"
    fi
else
    zenity-info "No input. Goodbye!"
fi 

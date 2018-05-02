clear #Clear terminal screen

LOGO=" __  __               _____      _
|  \/  |             / ____|    | |
| \  / | __ _  ___  | (___   ___| |_ _   _ _ __
| |\/| |/ _\` |/ __|  \___ \ / _ \ __| | | | '_ \\
| |  | | (_| | (__   ____) |  __/ |_| |_| | |_) |
|_|  |_|\__,_|\___| |_____/ \___|\__|\__,_| .__/
                                          | |
                                          |_|"

echo "$LOGO" # Print logo
echo -e "\n   Front end web development setup for macOS \n" # Print title

PS3='
Number to execute: '

options=("Install" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install")
            . api/install.sh
            ;;
        "Quit")
            break
            ;;
        *) echo Invalid option!;;
    esac
done

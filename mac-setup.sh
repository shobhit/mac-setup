clear

LOGO="\033[1;36m __  __               _____      _
|  \/  |             / ____|    | |
| \  / | __ _  ___  | (___   ___| |_ _   _ _ __
| |\/| |/ _\` |/ __|  \___ \ / _ \ __| | | | '_ \\
| |  | | (_| | (__   ____) |  __/ |_| |_| | |_) |
|_|  |_|\__,_|\___| |_____/ \___|\__|\__,_| .__/
                                          | |
                                          |_|\033[0m"

echo -e "$LOGO"

echo -e "\033[1;36m\n   Front end web development setup for macOS\n"
echo -e "------------------------------------------------\033[0m"
echo -e "      <https://github.com/appalaszynski>"
echo -e "  <https://github.com/appalaszynski/mac-setup>"
echo -e "\033[1;36m------------------------------------------------\033[0m\n"

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

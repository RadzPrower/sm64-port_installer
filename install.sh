# Script for cloning and building SM64 PC port from official repository
# Script written by RadzPrower

# Portions of this are inspired by the build.sh script contributed to by the following:
# gunvalk, serosis, derailius, Filipianosol, coltonrawr, fgfds

# Some variable setup

# Directory paths
MAIN=./sm64-port/
MAIN_GIT="${MAIN}".git/
BUILD=./build/us_pc/

# Text formatting
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Package dependencies list
DEPENDENCIES=("git" "make" "python3" "mingw-w64-x86_64-gcc")

# Get number of processors of the system
NPROC=$(nproc)

# Main script
#-------------

# Pull dependencies (if necessary) prior to build
echo -e "\nChecking for necessary dependencies...\n"
for i in ${DEPENDENCIES}; do
    if [[ ! $(pacman -Q $i 2> /dev/null) ]]; then
        pacman -S $i
    else
        echo -e "\n",$i," was found"
    fi
done

# Clone official PC port repo
if [ -d "$MAIN_GIT" ]; then
    cd "$MAIN"
    echo -e "\n${YELLOW}${BOLD}WARNING:${RESET}${YELLOW} In the current configuration of the official build, saves are stored "
    echo -e "within the same directory as the executable. Therefore, you may want to backup "
    echo -e "your save (${CYAN}sm64_save_file.bin${YELLOW}) and configuration (${CYAN}sm64config.txt${YELLOW}) before "
    echo -e "continuing.${RESET}"
    echo -e "\nPress any key to continue"
    read -n1 -s
    git stash push
    git stash drop
    git pull https://github.com/sm64-port/sm64-port.git
    cd -
else
    if [ -d "$MAIN" ]; then
        echo -e "\n\nBacking up existing ${CYAN}"$MAIN"${RESET} directory to ${CYAN}sm64-port.old${RESET}..."
        mv $MAIN sm64-port.old/
        git clone https://github.com/sm64-port/sm64-port.git sm64-port
    else
        git clone https://github.com/sm64-port/sm64-port.git sm64-port
    fi
fi

# Present message regarding the need for baserom and where to place it if not found
cd "$MAIN"
while [ ! -f "./baserom.us.z64" ]
do
    echo -e "\n${YELLOW}Existing baserom NOT found.${RESET}"
    echo -e "\nPlease take your ROM, name it \"baserom.us.z64\", and then place it within the"
    echo -e  "following folder:${CYAN}"
    pwd -LPW
    echo -e "${RESET}\n${BOLD}${YELLOW}NOTE${RESET}${YELLOW}: If your file explorer settings ${RED}DO NOT${YELLOW} show file extensions, simply rename the file to \"baserom.us\" as the file extension is already included.${RESET}"
    echo -e "\nOnce you have placed the ROM in the above directory, press any key to continue."
    for (( i=1; i<=12; i++ ))
    do
        echo -e ""
    done
    read -n1 -s
done
echo -e "\n\nExisting baserom found\n"

# Prompt the user for the number of jobs they would like to utilize
# A default value of number of processors minus 2 is provided, but any value can be input (0 )
echo -e "\nThe default number of jobs for your system is ${CYAN}"$(($NPROC - 2))"${RESET}."
echo -e "The current number of cores in your system is ${CYAN}"$NPROC"${RESET}."
echo -e "\nFor optimal results, simply use the default value provide. If you would like to continue utilizing your system with minimal impact, lower the value."
echo -e "${BOLD}${YELLOW}NOTE${RESET}${YELLOW}: Entering no value at all will remove the job cap entirely."
echo -e "This is not advised as it can overwhelm your system and may ultimately cause the"
echo -e "build to compile slower or fail altogether. It may well even cause damage to "
echo -e "your system."
echo -e "${RED}${BOLD}!Remove the limit at your own risk!${RESET}\n"
read -p "How many jobs would you like to allocate to the compiling process? ${CYAN}" -i $(($NPROC - 2)) -e JOBS
echo -e "${RESET}"

# If less than 1 was input, convert to 1
if [[ "$JOBS" != "" ]] && (($JOBS < 1)); then
    JOBS="1"
fi

# Compile build with the input number of jobs
make -j$JOBS

# Open the build directory for the user
cd "$BUILD"
start .

# Final message
echo -e "The executable has been compiled and a window opened."
echo -e "The executable is named ${CYAN}sm64.us.f3dex2e.exe${RESET}."
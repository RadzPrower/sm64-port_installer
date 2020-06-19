# sm64-port_installer
This is a MSYS2 installer script for the Windows port of Super Mario 64. It contains none of their code nor official Nintendo assets. It simply assists to easily obtain dependencies, official repo updates, and ultimately compile the build into a working executable.

# Preparations
1. Install and update MSYS2. Download and directions can be found at https://www.msys2.org/.
2. Download the latest release from [here](https://github.com/ajohns6/sm64-port_installer/releases). Place in in the directory where you want to install the SM64 port. **NOTE**: Assuming you want to minimize terminal interface but still maintain a log for troubleshooting, I recommend placing it in `C:\msys64\home\*your user name*\` for easier execution later.
3. Legally obtain a copy of the Super Mario 64 (US) ROM and rename it to `baserom.us.z64` and place it alongside the install.sh file.
  **NOTE**: If you are using a file explorer and have extensions hidden, simply name the ROM `baserom.us` and ensure the file type is z64.
  
# Optional Steps
If you want to simply double-click the file and have it run, follow these steps: 
1. Right-click on the file
2. Select "Open with"
3. Select "Choose another app"
4. Once there, navigate to the location of the mingw64.exe file (this is typically `C:\msys64` though yours may differ).

Be warned, this method does NOT maintain a history after execution and will make troubleshooting problems difficult.

While this makes the process even simpler, I would not recommend it until you have completed multiple successful builds. I would also not recommend using it on a development clone as well as you will not see build errors. This is only recommended for players only. That said, should you begin encountering errors, you can still utilize the script via following the instructions below in order to maintain a history for noting and sharing errors for troubleshooting.

# Installation
If you followed the optional steps to simply double-click to run, simply follow the prompts and eventually the build process will start. This will take some time, but once it finishes, a window will open to the location of the newly compiled executable. Double-click and enjoy!

Assuming you did not configure for double-clicking, follow these steps:
1. Open MSYS2 MinGW 64-bit from the start menu.
2. Execute the `install.sh` script.
    * If you placed it in the recommended directory mentioned above, this simply means entering `./install/sh`.
    * If you placed the file in a different location, you will need to either utilize `cd` in order to change your directory to that location, or you will need to execute directly from that location. Examples are provided below:
  
  These examples assume an `install.sh` location of `D:\Games\Super Mario 64 PC Port`. Note that quotation marks around the directory are only required if the path contains spaces as in this example.

This is an example of directory change and then execution.

```cd "D:\Games\Super Mario 64 PC Port"`
./install.sh```

This is an example of the direct execution.

`"D:\Games\Super Mario 64 PC Port\install.sh"`

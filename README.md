# NetSwitch

NetSwitch is a simple Windows batch script tool designed to easily switch between different network configurations on your computer. It provides two scripts: one for switching to a HOME network setup (using DHCP) and another for switching to a LAB network setup (using a static IP configuration). This tool is particularly useful for users who frequently switch between home and lab environments, such as developers, IT professionals, or students working in network-restricted lab settings.

## Features

- **HOME Network Setup**: Automatically configures your Ethernet interface to use DHCP for IP address and DNS, ideal for home or dynamic network environments.
- **LAB Network Setup**: Sets a static IP address (10.2.11.80), subnet mask (255.255.252.0), gateway (10.2.8.1), and DNS (8.8.8.8) for lab environments.
- **Simple Execution**: Run the appropriate batch file with administrator privileges to switch configurations instantly.
- **Feedback**: Provides on-screen feedback confirming the network switch.

## Prerequisites

- **Operating System**: Windows 10/11.
- **Permissions**: Administrator privileges are required to modify network settings.
- **Network Interface**: Assumes an Ethernet interface named "Ethernet". If your interface has a different name, you may need to modify the scripts accordingly.

## Installation

1. **Download the Scripts**:
   - Clone or download the repository containing `netswitchhome.bat` and `netswitchlab.bat`.

2. **Place in Desired Location**:
   - Save the batch files in a convenient location, such as your Desktop or a dedicated folder (e.g., `C:\NetSwitch`).

3. **Run as Administrator**:
   - Ensure you run the scripts with administrator privileges, as network configuration changes require elevated permissions.

No additional software installation is required, as the scripts use built-in Windows `netsh` commands.

## Usage

### Switching to HOME Network
1. Right-click on `netswitchhome.bat` and select "Run as administrator".
2. The script will display: "Switching to HOME network (DHCP)...".
3. It configures the Ethernet interface to use DHCP for IP and DNS.
4. Upon completion, it shows: "HOME network enabled successfully."
5. Press any key to close the window.

### Switching to LAB Network
1. Right-click on `netswitchlab.bat` and select "Run as administrator".
2. The script will display: "Switching to LAB network...".
3. It sets the Ethernet interface to static IP: 10.2.11.80, subnet: 255.255.252.0, gateway: 10.2.8.1, DNS: 8.8.8.8.
4. Upon completion, it shows: "LAB network configured successfully."
5. Press any key to close the window.

### Troubleshooting
- **Interface Name Mismatch**: If your network interface is not named "Ethernet", open the batch file in Notepad and change `set eth=Ethernet` to match your interface name (e.g., `set eth="Local Area Connection"`).
- **Permission Denied**: Ensure you are running the script as an administrator. Right-click the file and select "Run as administrator".
- **Network Issues**: After running, verify the network settings by opening Command Prompt and typing `ipconfig`. If issues persist, restart your computer or check network adapter settings.
- **Firewall/Antivirus**: Some security software may block network changes. Temporarily disable if necessary, but re-enable afterward.

## Files Description

- **`netswitchhome.bat`**: Batch script to switch to HOME network configuration (DHCP).
- **`netswitchlab.bat`**: Batch script to switch to LAB network configuration (static IP).

## Customization

To customize the LAB network settings:
1. Open `netswitchlab.bat` in a text editor.
2. Modify the static IP, subnet, gateway, or DNS values in the `netsh` commands.
3. Save the file and run as administrator.

Example customization:
```
netsh interface ip set address name="%eth%" static YOUR_IP YOUR_SUBNET YOUR_GATEWAY
netsh interface ip set dns name="%eth%" static YOUR_DNS
```


## Disclaimer

Modifying network settings can disrupt connectivity. Ensure you have a backup of your current network configuration before use.

# 🌐 NetSwitch
**Automated Network Configuration Utility for Windows and Linux**

[NetSwitch](#netswitch) is a lightweight utility that streamlines the process of switching between **Dynamic (Home)** and **Static (Lab)** network environments. Designed for developers, network engineers, and students, it eliminates repetitive network configuration commands and makes transitions between network types quick and predictable on both Windows and Linux.

---

## 📋 Overview

In complex network environments, switching between DHCP (Dynamic Host Configuration Protocol) and Static IP configurations can be tedious. NetSwitch abstracts this complexity into two simple, user-friendly scripts.

| Feature | HOME Network | LAB Network |
| :--- | :--- | :--- |
| **Protocol** | DHCP (Automatic) | Static IP |
| **IP Address** | Assigned by Router | `10.2.11.80` |
| **Subnet Mask** | Auto-assigned | `255.255.252.0` |
| **Gateway** | Auto-assigned | `10.2.8.1` |
| **DNS** | Auto-assigned | `8.8.8.8` (Google DNS) |
| **Use Case** | Home, Office, Public Wi-Fi | Testing, Labs, Corporate Networks |

---

## 🏗️ Architecture

NetSwitch operates as a lightweight batch automation tool. It uses the Windows `netsh` API to modify network stack settings. The following diagram illustrates the execution flow:

```mermaid
graph TD
    User[User Double-Clicks Script] -->|Triggers| AdminCheck{Admin Privileges?}
    AdminCheck -->|No| RunError[❌ Access Denied]
    AdminCheck -->|Yes| ScriptLogic{Which Script?}
    
    ScriptLogic -->|netswitchhome.bat| DHCP_Set[netsh: Set IP to DHCP]
    ScriptLogic -->|netswitchlab.bat| Static_Set[netsh: Set IP to Static<br/>10.2.11.80]
    
    DHCP_Set --> Confirm[✅ HOME Enabled]
    Static_Set --> DNS_Set[netsh: Set DNS to 8.8.8.8]
    DNS_Set --> Confirm
    
    Confirm --> Feedback[Feedback Window<br/>Press Enter to Exit]
    RunError --> Help[Read Troubleshooting Section]
```

---

## 🚀 Quick Start

### Prerequisites
- **Windows**: Windows 10/11 with Administrator rights
- **Linux**: A NetworkManager-based system with `nmcli` installed and `sudo` access
- **Network**: Standard Ethernet adapter

### Installation
1. Download or clone this repository.
2. Use the Windows batch files on Windows:
   - `netswitchhome.bat`
   - `netswitchlab.bat`
3. Use the Linux shell scripts on Linux:
   - `netswitchhome.sh`
   - `netswitchlab.sh`
4. Place them in a preferred folder.

---

## 🛠️ How to Use

### 1️⃣ Switch to HOME Network (DHCP)
*Best for: Home, Office, or dynamic environments.*

1. Right-click `netswitchhome.bat`.
2. Select **"Run as administrator"**.
3. The script will configure the interface to request an IP from your local router.
4. **Success**: You will see `HOME network enabled successfully.`

### 2️⃣ Switch to LAB Network (Static)
*Best for: Lab environments requiring fixed IP addresses.*

1. Right-click `netswitchlab.bat`.
2. Select **"Run as administrator"**.
3. The script applies the static configuration:
   - **IP**: `10.2.11.80`
   - **Mask**: `255.255.252.0`
   - **Gateway**: `10.2.8.1`
   - **DNS**: `8.8.8.8`
4. **Success**: You will see `LAB network configured successfully.`

> 💡 **Tip**: Always verify your settings after running by opening Command Prompt and typing `ipconfig`.

### 3️⃣ Linux Usage
*Best for: Linux systems using NetworkManager.*

Run the scripts with `sudo`:

```bash
sudo ./netswitchhome.sh
sudo ./netswitchlab.sh
```

The Linux scripts try to detect the active Ethernet interface and its NetworkManager connection automatically.

If your setup needs a specific interface or connection name, you can override them:

```bash
sudo INTERFACE_NAME=enp3s0 ./netswitchhome.sh
sudo INTERFACE_NAME=enp3s0 CONNECTION_NAME="Wired connection 1" ./netswitchlab.sh
```

You can also override the lab network values:

```bash
sudo IP_ADDRESS=10.2.11.80/22 GATEWAY=10.2.8.1 DNS_SERVER=8.8.8.8 ./netswitchlab.sh
```

---


### Editing Interface Name
Both scripts look for a variable named `%eth%`. If your adapter is named `Wi-Fi` or `Local Area Connection`, modify this line in the script:

```batch
:: Default (Ethernet)
set eth=Ethernet

:: Example for Wi-Fi
set eth="Wi-Fi"
```

### Modifying LAB Settings
To change the Lab IP address or Gateway, edit `netswitchlab.bat`:

```batch
:: Modify your static IP line
netsh interface ip set address name="%eth%" static 192.168.1.50 255.255.255.0 192.168.1.1

:: Modify DNS line
netsh interface ip set dns name="%eth%" static 1.1.1.1
```

For Linux, you can either edit `netswitchlab.sh` or pass values at runtime:

```bash
sudo IP_ADDRESS=192.168.1.50/24 GATEWAY=192.168.1.1 DNS_SERVER=1.1.1.1 ./netswitchlab.sh
```

---

## ⚠️ Troubleshooting

| Issue | Possible Cause | Solution |
| :--- | :--- | :--- |
| **Access Denied** | Running without Admin rights | Right-click and select "Run as administrator". |
| **Wrong Network** | Interface name mismatch | Edit `%eth=` in the batch file to match your adapter name. |
| **No Internet** | Firewall/Antivirus block | Temporarily disable security software or add an exception for `netsh`. |
| **Settings Not Saving** | Network service reset | Restart the computer or the specific network adapter service. |

---

## 📜 License & Disclaimer

This tool is provided "as is" for educational and personal use.
- **Network Modification Warning**: Changing network configurations can temporarily disrupt connectivity. Always ensure you understand the IP subnet being applied to avoid network conflicts.
- **Data Backup**: If in doubt, perform a network backup (`ipconfig /all`) before making changes.

---

*Developed with 🧠 for efficient network management.*
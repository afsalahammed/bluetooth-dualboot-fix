# bluetooth-dualboot-fix

A bash utility to fix Bluetooth device pairing in Linux/Windows dual-boot setups.

---

## The Problem

When you dual-boot Linux and Windows, Bluetooth devices tend to unpair themselves every time you switch operating systems. This happens because both operating systems generate and store their own pairing keys — but the Bluetooth device can only remember one key at a time. Whichever OS paired last becomes the only one the device trusts.

This script solves that by extracting the Bluetooth pairing keys that Windows stored and applying them to Linux — so both systems agree on the same key without re-pairing.

---

## How It Works

1. Reads the Bluetooth pairing keys from the offline Windows registry using `reged` (part of `chntpw`)
2. Exports them to a `.reg` file
3. Guides you to manually apply the correct key to Linux's Bluetooth config

---

## Prerequisites

- A Linux system dual-booting with Windows
- The Windows partition must be **mounted** before running the script
- `chntpw` package (provides the `reged` tool)

To install `chntpw` on Debian/Ubuntu based systems:
```bash
sudo apt install chntpw
```

---

## Usage

1. Boot into Linux
2. Mount your Windows partition (if not auto-mounted)
3. Clone this repository:
   ```bash
   git clone https://github.com/[your-username]/bluetooth-dualboot-fix.git
   cd bluetooth-dualboot-fix
   ```
4. Make the script executable:
   ```bash
   chmod +x bt_fix.sh
   ```
5. Edit the script and set the correct Windows mount point and output path:
   ```bash
   # Windows mount point — e.g. /run/media/youruser/PARTITION_LABEL
   # Output file — e.g. /home/youruser/bt_keys.reg
   ```
6. Run the script:
   ```bash
   sudo ./bt_fix.sh
   ```
7. Follow the on-screen instructions to apply the key

---

## Applying the Key Manually

After the script runs, you will need to:

1. Open the exported `.reg` file and find the key corresponding to your device's MAC address
2. Navigate to the Linux Bluetooth config:
   ```
   /var/lib/bluetooth/[adapter MAC]/[device MAC]/info
   ```
3. Replace the value under `[LinkKey]` with the key from the `.reg` file
4. Remove any commas from the key (Windows format uses `xx,xx,xx`, Linux needs `xxxx`)
5. Save the file and restart the Bluetooth service:
   ```bash
   sudo systemctl restart bluetooth
   ```

---

## Security Note

The exported `.reg` file contains your Bluetooth pairing keys. Delete it after you have applied the key:

```bash
rm /home/[user]/bt_keys.reg
```

---

## Dependencies

| Tool | Package | Purpose |
|------|---------|---------|
| `reged` | `chntpw` | Read Windows registry offline |

---

## Contributing

Pull requests are welcome. If you run into issues or have ideas for improvement, feel free to open an issue.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

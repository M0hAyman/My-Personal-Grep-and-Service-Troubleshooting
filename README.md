# 🛠️ mygrep.sh - Mini Grep Implementation

A lightweight Bash script that mimics basic `grep` functionality with extra features.

## ✨ Features

- Case-insensitive string search inside a text file
- Print matching lines
- Options:
  - `-n` → Show line numbers
  - `-v` → Invert match (print non-matching lines)
  - Combined options like `-vn` or `-nv`
  - `--help` → Display usage instructions

## 🧩 Usage

```
./mygrep.sh [options] search_string filename
```

### Options

| Option   | Description                           |
|:---------|:--------------------------------------|
| `-n`     | Show line numbers with matches        |
| `-v`     | Invert match (show non-matching lines) |
| `--help` | Display usage information             |

## 📋 Examples

```
./mygrep.sh hello testfile.txt
```
Search for "hello" (case-insensitive).

```
./mygrep.sh -n hello testfile.txt
```
Search for "hello" with line numbers.

```
./mygrep.sh -vn hello testfile.txt
```
Invert match and show line numbers.

```
./mygrep.sh -v testfile.txt
```
⚠️ Shows an error because the search string is missing.

## 📂 Project Structure

```
/mygrep/
├── mygrep.sh
├── testfile.txt
└── screenshots/
    ├── mygrep_hello.png
    ├── mygrep_n_hello.png
    ├── mygrep_vn_hello.png
    └── mygrep_v_error.png
```

## 🛡️ Error Handling

- Checks if the search string and filename are provided
- Verifies that the file exists
- Displays meaningful error messages when input is invalid

## 🏆 Bonus Features

- Supports combined flags like `-vn`
- Highlights matches using `grep --color=always`
- `--help` shows a user-friendly guide

## 🧠 Reflection

- **Argument Handling:** Manual parsing ensures combined options work properly.
- **Potential Improvements:** Better flag management would be needed to support regex searches or more options like `-c` (count) or `-l` (list filenames).
- **Challenges:** Correctly handling missing arguments after parsing options was the hardest part.

## ✅ Status

- Fully functional
- Successfully tested with `testfile.txt`


---

# 🌐 DNS & Service Reachability Troubleshooting

When `internal.example.com` became unreachable, here’s the troubleshooting and recovery process.

## 1️⃣ Verify DNS Resolution

Compare system resolver and external DNS:

```
# Using system's DNS
dig internal.example.com

# Using Google's DNS
dig @8.8.8.8 internal.example.com
```

Check `/etc/resolv.conf` for correct DNS servers:

```
cat /etc/resolv.conf
```

## 2️⃣ Diagnose Service Reachability

Ping and check service on port 80/443:

```
ping internal.example.com
telnet internal.example.com 80
curl -v http://internal.example.com
ss -tuln | grep :80
```

## 3️⃣ Possible Causes

- Incorrect DNS server settings
- Broken DNS entries (missing A record)
- Firewall blocking access to DNS or HTTP(S)
- Web server running but not bound correctly
- Wrong `/etc/hosts` configuration

## 4️⃣ Proposed Fixes

| Issue | How to Confirm | Command to Fix |
|:------|:---------------|:---------------|
| Wrong `/etc/resolv.conf` | View file | Edit `/etc/resolv.conf` or use `nmcli` |
| Missing DNS entry | Use `dig` and `nslookup` | Update internal DNS server |
| Web server misconfigured | `curl`, `ss`, `netstat` | Restart web server, fix config |
| Firewall blocking | `iptables -L` or `ufw status` | Adjust firewall rules |

Example fix for temporary `/etc/hosts` bypass:

```
echo "192.168.1.100 internal.example.com" | sudo tee -a /etc/hosts
```

Make DNS persistent via `systemd-resolved`:

```
sudo systemctl enable systemd-resolved
sudo systemctl start systemd-resolved
```

Or via NetworkManager:

```
nmcli dev show | grep DNS
nmcli con mod <your-connection> ipv4.dns "8.8.8.8"
nmcli con up <your-connection>
```

---

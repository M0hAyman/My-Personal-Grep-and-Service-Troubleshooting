# 🛠️ mygrep.sh - Mini Grep Implementation

A lightweight Bash script that mimics the basic functionality of the `grep` command with some additional features.

---

## ✨ Features

- Case-insensitive string search inside a text file
- Print matching lines
- Options:
  - `-n` → Show line numbers
  - `-v` → Invert match (print non-matching lines)
  - Options can be combined (`-vn`, `-nv`)
  - `--help` → Show usage instructions

---

## 🧩 Usage

```bash
./mygrep.sh [options] search_string filename

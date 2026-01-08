# Linux Security Audit Toolkit

## Overview

Linux Security Audit Toolkit is a modular Bash-based security auditing tool designed to perform baseline security checks on Linux systems.

This project focuses on simplicity, clarity, and audit reliability. It was developed as a learning-oriented DevOps / DevSecOps project and provides actionable insights into common system security risks.

---

## Features

- Modular audit architecture (one script per audit category)
- Detection of privileged users (UID 0 accounts)
- Open network ports enumeration
- Running system services detection
- Severity-based logging (INFO / OK / WARNING / CRITICAL)
- Centralized audit report generation
- Dependency and privilege checks before execution

---

## Project Structure

```bash
.
├── security_audit.sh
├── audits/
│   ├── users_uid0.sh
│   ├── ports_open.sh
│   ├── services_running.sh
│   └── tools.sh
├── reports/
│   └── audit_YYYY-MM-DD.txt
└── README.md
'''
---

## Prerequisites

- Linux operating system with systemd
- Bash shell
- Root privileges

### Required commands

- ss
- awk
- systemctl

All dependencies are automatically checked before execution.

---

## Usage

### Run full audit (default behavior)

sudo ./security_audit.sh

### Run specific audits

sudo ./security_audit.sh --users  
sudo ./security_audit.sh --ports  
sudo ./security_audit.sh --services  

### Display help

./security_audit.sh --help

---

## Output

- Audit reports are generated in the reports/ directory
- Reports are timestamped (audit_YYYY-MM-DD.txt)
- Logs are displayed in the terminal and written to the report file
- Each audit section includes a severity level:
  - OK: No issue detected
  - WARNING: Potential security concern
  - CRITICAL: High-risk configuration detected

---

## Example Findings

- Detection of multiple UID 0 accounts indicating possible privilege escalation
- Enumeration of exposed network ports
- Identification of active system services

---

## Design Principles

- Clear and readable Bash scripts
- Modular architecture for easy extension
- Explicit checks for privileges and dependencies
- Focus on audit transparency rather than silent failures

---

## Limitations

- Provides baseline security checks only
- Not a replacement for professional security auditing tools
- Tested primarily on Debian and Ubuntu-based systems

---

## Future Improvements

- SSH hardening checks
- Firewall configuration validation
- JSON output format for CI/CD integration
- Exit codes based on audit severity
- Additional system hardening audits

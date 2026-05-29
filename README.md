Markdown
# Production-Ready Python Data Engineering Template 🚀

This repository serves as a highly automated boilerplate for building scalable, maintainable, and production-grade Data Engineering projects using **Python**. 

It eliminates environment configuration friction by automating folder structures, package management, local formatting gates, and **CI/CD integration pipelines** right out of the box.

## 🛠️ Built-In Tech Stack & Architecture

- **Language & Paradigms:** Python 3.11+ leveraging Object-Oriented Programming (OOP) and explicit Type Hinting.
- **Testing Framework:** `pytest` configured for structured test suites and Test-Driven Development (TDD).
- **Code Quality & Linting:** `ruff` — an ultra-fast Python linter and formatter used to enforce Clean Code, PEP 8 compliance, and catch anti-patterns early.
- **CI/CD Platform:** GitHub Actions running automated style checks and test execution suites on every push or pull request.

## 📋 Prerequisites & Local Machine Setup

## 📋 Prerequisites & Local Machine Setup

Before executing the automation script (`create_project.sh`), ensure your local environment meets the following engineering prerequisites. 

### 1. Core Version Control System (`git`)
The script initializes local version tracking using native Git commands before syncing with the cloud.
- **Mac:** Installed by default with Xcode Command Line Tools (`xcode-select --install`).
- **Linux:** `sudo apt install git`
- **Windows:** Download and install from [git-scm.com](https://git-scm.com/).

### 2. GitHub CLI (`gh`) & Repository Scopes
The script utilizes the official GitHub CLI to automatically spin up a public repository on your account.
1. **Installation:**
   - **Mac:** `brew install gh`
          To install it in Mac it will be needed to give access to some directories. The installation program will show which directiories will need to change the permission with the respective chmod command
   - **Linux:** `sudo apt install gh`
   - **Windows:** `winget install GitHub.GitHubCLI`
2. **Authentication & Scopes (Crucial for first-time users):**
   Run the login command in your terminal:
   ```bash
   gh auth login
   ```
### 3. Python 3 Environment
The script requires Python 3.11+ and `pip` installed globally on your machine.
- **Mac (Homebrew):** `brew install python`
- **Linux (Ubuntu/Debian):** `sudo apt update && sudo apt install python3 python3-venv python3-pip`

### 4. VS Code Command Line Interface (`code`)
To allow the script to open the project workspace automatically, ensure the `code` command is installed in your system path:
1. Open **VS Code**.
2. Open the Command Palette (`Ctrl+Shift+P` on Windows/Linux, `Cmd+Shift+P` on Mac).
3. Type and select: `Shell Command: Install 'code' command in PATH`.
4. Restart your terminal.
   
## 📁 Repository Structure

```bash
├── .github/workflows/
│   └── ci.yml        # CI/CD Pipeline (Ruff Linting + Pytest Execution)
├── .vscode/
│   └── settings.json # Pre-configured VS Code Test Runner and Path settings
├── src/
│   ├── __init__.py   # Root module initialization
│   ├── app.py        # Core domain logic, object models, and transformations
│   └── main.py       # Application orchestrator / Entry point
└── tests/
    ├── __init__.py
    ├── test_app.py   # Unit tests targeting app logic
    └── test_main.py  # Integration tests targeting pipeline execution
```

## 🚀 Getting Started in 60 Seconds
You can instantiate this entire environment dynamically.

1. Run the Automation Setup Script
Execute the custom shell script to spin up the architecture, isolate your virtual environment, pull dependencies, and format the initial codebase:
```bash

chmod +x create_project.sh
./create_project.sh my-new-data-pipeline
cd my-new-data-pipeline
```
2. Activate Environment & Validate
 ```bash  

# Activate the isolated virtual environment
source .venv/bin/activate

# Execute the test suite locally
python -m pytest

# Run the core application entry point
python src/main.py
```

## 🤖 Automated Quality Gates (CI/CD)
Every time code is pushed to this repository, a GitHub Actions workflow triggers to ensure no broken code or poor style definitions enter the main trunk.

 1) Linting Check (ruff check): Flags unused variables, complex logical nesting, or risky syntax architectures.

 2) Formatting Enforcement (ruff format): Validates precise indentation, line-breaks, and quote uniformity.

 3) Automated Testing (pytest): Runs the full testing harness inside a clean Ubuntu runner.

Maintained by Arthur Cristofoletti

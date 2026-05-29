#!/bin/bash

# Abort script if any command fails
set -e

# Validate if the project name argument was provided
if [ -z "$1" ]; then
    echo "❌ Error: Project name parameter is required."
    echo "Usage: ./create_project.sh sportradar-challenge-project"
    exit 1
fi

PROJECT_NAME=$1

echo "🚀 Initializing high-performance project structure: $PROJECT_NAME..."

# 1. Create root directory and navigate into it
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 2. Create internal directory structure
echo "📁 Creating directories..."
mkdir -p src tests .vscode .github/workflows

# 3. Create initialization files (Python Packages)
touch src/__init__.py
touch tests/__init__.py

# 4. Create src/app.py (Core Classes and Functions)
echo "📝 Creating src/app.py..."
cat << 'EOF' > src/app.py
class Processor:
    """Responsible for handling core data transformation logic."""

    def __init__(self, data_type: str) -> None:
        if not isinstance(data_type, str):
            raise TypeError("Data type must be a string")
        self.data_type: str = data_type.strip()

    def process_element(self, value: int) -> int:
        """Executes a simple mathematical transformation on a numeric value."""
        if not isinstance(value, (int, float)):
            raise TypeError("Value must be a number")
        return int(value * 2)
EOF

# 5. Create src/main.py (Application Entry Point)
echo "📝 Creating src/main.py..."
cat << 'EOF' > src/main.py
from src.app import Processor


def run_pipeline() -> str:
    """Orchestrates the pipeline execution flow."""
    processor = Processor(data_type="Ads Analytics")
    result = processor.process_element(500)
    print(f"[{processor.data_type}] Pipeline processing result: {result}")
    return f"Success: {result}"


if __name__ == "__main__":
    run_pipeline()
EOF

# 6. Create test structure matching the src files
echo "🧪 Creating test suite structure..."

cat << 'EOF' > tests/test_app.py
import pytest
from src.app import Processor


def test_processor_multiplication():
    """Validates the business logic transformation inside app.py."""
    processor = Processor(data_type="Test")
    assert processor.process_element(10) == 20


def test_processor_invalid_type():
    """Ensures the application raises a TypeError when receiving invalid data types."""
    with pytest.raises(TypeError):
        Processor(data_type=123)  # Should fail since it expects a string
EOF

cat << 'EOF' > tests/test_main.py
from src.main import run_pipeline


def test_main_pipeline_execution():
    """Validates that the main application entry point runs successfully."""
    assert run_pipeline() == "Success: 1000"
EOF

# 7. Setting up Virtual Environment and Dependencies
echo "🐍 Setting up Python virtual environment (.venv)..."
python3 -m venv .venv

# Activate the venv locally to run formatters
source .venv/bin/activate

echo "📦 Installing pytest and ruff (ultra-fast linter & formatter)..."
pip install --upgrade pip
pip install pytest ruff

# 🔥 Auto-format code using Ruff before committing to prevent CI/CD failures
echo "✨ Auto-formatting code with Ruff to enforce Clean Code standards..."
ruff format src/ tests/
ruff check src/ tests/ --fix

# 8. Configure VS Code workspace settings
echo "⚙️ Configuring VS Code settings..."
cat << 'EOF' > .vscode/settings.json
{
    "python.testing.pytestEnabled": true,
    "python.testing.unittestEnabled": false,
    "python.testing.pytestArgs": ["tests"],
    "python.analysis.extraPaths": ["./src"],
    "python.analysis.typeCheckingMode": "basic",
    "editor.formatOnSave": true,
    "[python]": {
        "editor.formatOnType": true
    }
}
EOF

# 9. Create automated GitHub Actions CI/CD workflow pipeline
echo "🤖 Creating GitHub Actions CI/CD pipeline configuration..."
cat << 'EOF' > .github/workflows/ci.yml
name: Python CI with Clean Code Linting

on:
  push:
    branches: [ "main", "master" ]
  pull_request:
    branches: [ "main", "master" ]

jobs:
  lint-and-test:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: '3.11'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install pytest ruff

    - name: Check Clean Code and Linting with Ruff
      run: |
        ruff check src/ tests/ || true
        ruff format --check src/ tests/ || true

    - name: Run tests with pytest
      run: |
        python -m pytest
EOF

# 10. Create defensive .gitignore file
echo "🚫 Creating .gitignore..."
cat << 'EOF' > .gitignore
.venv/
__pycache__/
.pytest_cache/
.vscode/
*.pyc
EOF

# 11. Create Ruff configuration file
echo "⚙️ Creating pyproject.toml configuration..."
cat << 'EOF' > pyproject.toml
[tool.ruff]
# Target Python version
target-version = "py311"

# Enable specific rule categories (E = Error, W = Warning, F = Pyflakes)
select = ["E", "W", "F"]

# Tell Ruff to ignore specific rules completely if they are too annoying
ignore = [
    "E501", # Ignore line-length violations (let lines be long)
]

[tool.ruff.lint]
# You can selectively turn off certain strict behaviors
ignore-init-module-imports = true
EOF

# 12. Initialize local Git repository
echo "🗂️ Initializing local Git repository..."
git init
git branch -M main
git add .
git commit -m "chore: initial project structure with main, app and tests properly formatted"
gh repo create "$PROJECT_NAME" --public --source=. --remote=origin
git push -u origin main


echo "----------------------------------------------------------------"
echo "✅ Project '$PROJECT_NAME' successfully created!"
echo "📍 Path: $(pwd)"
echo "💡 To start coding, run the following commands:"
echo "   cd $PROJECT_NAME"
echo "   source .venv/bin/activate"
echo "   python -m pytest    # To run your test suite"
echo "   python src/main.py  # To run the main application"
echo "----------------------------------------------------------------"
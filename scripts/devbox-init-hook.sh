#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$DIR/.."
echo "script [$0] started"
#!

# Detect if the system is Ubuntu/Debian based or Red Hat / AMZN based, using the package manager available.
# Install common dependencies
if command -v apt-get &> /dev/null; then
    echo "Detected apt-get package manager. Installing common dependencies..."
    # sudo apt-get update -y  # Skipped: slow on ephemeral containers, packages pre-installed in CodeBuild image
    
    # Setup HashiCorp repository
    if [ ! -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
        echo "Setting up HashiCorp repository..."
        wget -q -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg 2>/dev/null || true
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
        sudo apt-get update -y >/dev/null 2>&1
    else
        echo "HashiCorp repository already configured"
    fi
    
    # Install core dependencies if not already present
    if ! command -v terraform &> /dev/null; then
        echo "Installing terraform..."
        sudo apt-get install -y terraform
    else
        echo "terraform already installed"
    fi
    
    # System packages (git, curl, unzip, wget, zip) are pre-installed in CodeBuild base image
    echo "Skipping system packages (pre-installed in CodeBuild image)"
elif command -v yum &> /dev/null; then
    echo "Detected yum package manager. Installing common dependencies..."
    # sudo yum update -y  # Skipped: slow (~133MB download) on ephemeral containers, packages pre-installed in CodeBuild image
    
    # Setup HashiCorp repository for yum
    if [ ! -f /etc/yum.repos.d/hashicorp.repo ]; then
        echo "Setting up HashiCorp repository..."
        sudo yum install -y yum-utils
        # Detect if Amazon Linux or RHEL/CentOS
        if grep -q "Amazon Linux" /etc/os-release 2>/dev/null; then
            sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
        else
            sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
        fi
    else
        echo "HashiCorp repository already configured"
    fi
    
    # Install core dependencies if not already present
    if ! command -v terraform &> /dev/null; then
        echo "Installing terraform..."
        sudo yum install -y terraform
    else
        echo "terraform already installed"
    fi
    
    # System packages (git, curl, unzip, wget, zip) are pre-installed in CodeBuild base image
    echo "Skipping system packages (pre-installed in CodeBuild image)"
else
    echo "No supported package manager found (apt-get or yum)"
fi

# SAM CLI - pre-installed in CodeBuild base image and custom gitops-codebuild-image
# Only install if missing (e.g. running outside CodeBuild)
if ! command -v sam &> /dev/null; then
    echo "AWS SAM CLI not found, installing..."
    SAM_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
    wget -q $SAM_URL -O "/tmp/aws-sam-cli-linux-x86_64.zip"
    unzip -q /tmp/aws-sam-cli-linux-x86_64.zip -d /tmp/sam-installation
    sudo -n bash -c "cd /tmp/sam-installation && ./install -i /usr/local/aws-cli -b /usr/local/bin" 2>/dev/null || sudo /tmp/sam-installation/install
    rm -rf /tmp/sam-installation /tmp/aws-sam-cli-linux-x86_64.zip
else
    echo "SAM CLI already installed: $(sam --version)"
fi

# Node.js - pre-installed in CodeBuild base image and custom gitops-codebuild-image
# Only install if missing (e.g. running outside CodeBuild)
if ! command -v node &> /dev/null; then
    echo "Node.js not found, installing..."
    NVM_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh"
    curl -s -o- $NVM_URL | bash >/dev/null 2>&1
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts >/dev/null 2>&1
    ln -sf "$(which node)" "$HOME/.local/bin/node"
else
    echo "Node.js already installed: $(node --version)"
fi


# Check dependencies versions
echo "Checking installed tools..."
command -v aws &>/dev/null && aws --version || echo "aws CLI not found"
command -v cdk &>/dev/null && cdk --version || echo "AWS CDK not found"
command -v flutter &>/dev/null && flutter --version || echo "flutter not found"


#!
popd
echo "script [$0] completed"

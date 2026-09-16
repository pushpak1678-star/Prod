# Azure Multi-Environment Web Application Infrastructure (VM-Based Terraform)

Yeh project **Azure Cloud** par **Frontend (Linux VM)**, **Backend (Linux VM)**, **Virtual Network (VNet/Subnets/NSGs)**, **Azure SQL Database**, aur **Azure Key Vault** deploy karne ke liye ek enterprise-grade, modular Terraform architecture hai.

---

## 🌟 Key Features Included

1. **Modular Architecture**:
   - `modules/networking`: VNet, Frontend Subnet, Backend Subnet, Public IP, Network Security Groups (NSGs).
   - `modules/key_vault`: Key Vault + Secrets for VM Admin Password & SQL Admin Password.
   - `modules/sql_database`: Azure SQL Server + Database + Firewall Rules.
   - `modules/virtual_machines`: Frontend Linux VM (Public Subnet) & Backend Linux VM (Private Subnet).
2. **3 Environments**:
   - `environments/test` (`Standard_B1s` VMs, Basic SQL)
   - `environments/pre-prod` (`Standard_B2s` VMs, S0 SQL)
   - `environments/production` (`Standard_D2s_v5` VMs, General Purpose SQL)
3. **Azure Key Vault & Secrets**: Passwords randomly generate hote hain aur Azure Key Vault me store hote hain.
4. **Data Block Usage (`data`)**:
   - `data "azurerm_client_config" "current"` for client identity details.
   - `data "azurerm_key_vault_secret" "sql_password_data"` & `data "azurerm_key_vault_secret" "vm_password_data"` to securely fetch secrets from Key Vault.
5. **Explicit Dependencies (`depends_on`)**: VNet, Subnets, NICs, Key Vault Secrets, SQL Server, aur VMs ke beech provisioning sequence ensure karne ke liye `depends_on` blocks use kiye gaye hain.
6. **Remote State Backend**: Azure Blob Storage par remote state file lock & save karne ke liye `backend "azurerm"` block configured hai.

---

## 📁 Project Directory Structure

```
c:/antigravity/
├── modules/
│   ├── networking/          # VNet, Subnets, NSGs, Public IP
│   ├── key_vault/           # Key Vault + Secrets (SQL & VM passwords)
│   ├── sql_database/        # Azure SQL Server + SQL Database + Firewall Rule
│   └── virtual_machines/    # Frontend Linux VM & Backend Linux VM
├── environments/
│   ├── test/                # Test environment config
│   ├── pre-prod/            # Pre-production environment config
│   └── production/          # Production environment config
└── README.md
```

---

## 🚀 Deployment Guide

### Step 1: Azure CLI Login
Terminal me log in karein:
```bash
az login
```
Apni target subscription select karein:
```bash
az account set --subscription "YOUR_SUBSCRIPTION_ID_OR_NAME"
```

---

### Step 2: Create Remote Backend Storage (One Time Setup)
```bash
# Create Resource Group for Terraform State
az group create --name rg-tfstate-common --location eastus

# Create Storage Account
az storage account create --name sttfstatecommon1234 --resource-group rg-tfstate-common --sku Standard_LRS --encryption-services blob

# Create Container for Terraform State
az storage container create --name tfstate --account-name sttfstatecommon1234
```

---

### Step 3: Deploy Environment (e.g. `test`)

Navigate to target environment folder:
```bash
cd environments/test
```

Initialize Terraform:
```bash
terraform init
```

Validate Configuration:
```bash
terraform validate
```

Generate Execution Plan:
```bash
terraform plan
```

Apply Infrastructure:
```bash
terraform apply -auto-approve
```

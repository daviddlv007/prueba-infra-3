# Prueba Infra 2 - Infrastructure as Code

Terraform configuration following DevOps best practices for 2025.

## Structure

infra/terraform/
├── modules/ # Reusable modules
├── environments/ # Environment-specific configurations
├── scripts/ # Automation scripts
└── Makefile # Common commands


## Getting Started

1. **Setup Backend**:
   ```bash
   cd infra/terraform
   make setup-backend

Initialize Terraform:

    make init

Plan and Apply:


    make plan
    make apply

Environments
dev: Development environment

staging: Staging environment

prod: Production environment


CI/CD
GitHub Actions workflows:

terraform-ci.yml: Validation and planning on PRs

terraform-cd.yml: Deployment to production

terraform-drift.yml: Drift detection

Secrets
Configure the following secrets in GitHub:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_KEY_NAME (for EC2 key pair)


text

## 🛠️ Implementación Paso a Paso

1. **Preparación inicial**:
   ```bash
   mkdir -p prueba-infra-2/{.github/workflows,infra/terraform/{modules/{network,compute,backend},environments/{dev,staging,prod},scripts}}
   cd prueba-infra-2
Crear los archivos según la estructura anterior

Configurar AWS CLI:

bash
aws configure
Configurar backend:

bash
cd infra/terraform
chmod +x scripts/setup-backend.sh
./scripts/setup-backend.sh
Inicializar y probar:

bash
make init
make plan
Configurar secrets en GitHub:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_KEY_NAME

Hacer commit y push para activar los workflows

✅ Mejores Prácticas Implementadas
Módulos reutilizables para network, compute y backend

Múltiples ambientes con configuraciones separadas

Estado remoto con S3 y bloqueo con DynamoDB

CI/CD automatizado con GitHub Actions

Detector de drift para identificar cambios manuales

Seguridad:

Encriptación en reposo y tránsito

Credenciales en secrets, no en código

Bloques de acceso público

Versionado de Terraform y providers

Automatización con scripts y Makefile

Validación con pre-commit hooks

Documentación completa
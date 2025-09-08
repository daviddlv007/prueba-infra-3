# Infraestructura como Código - Proyecto prueba-infra-3

Este proyecto implementa infraestructura en AWS utilizando Terraform y GitHub Actions para automatización completa.

## Estructura del Proyecto
├── .github/workflows/ # Pipelines de CI/CD
├── infra/terraform/ # Código de Terraform
│ ├── environments/ # Configuración por entorno
│ └── modules/ # Módulos reutilizables

text

## Módulos Implementados

1. **s3-backend**: Creación de bucket S3 para estado de Terraform
2. **network**: VPC, subredes, tablas de rutas y grupos de seguridad
3. **compute**: Instancias EC2 y direcciones IP elásticas

## Flujos de Trabajo

1. **terraform-backend.yml**: Crea el bucket S3 para almacenar el estado de Terraform
2. **terraform-deploy.yml**: Implementa la infraestructura completa
3. **terraform-destroy.yml**: Destruye la infraestructura
4. **terraform-drift.yml**: Detección de deriva de configuración

## Configuración Requerida

1. Secrets de GitHub:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. Key Pair en AWS:
   - Nombre: `dev-key`
   - Región: `us-east-1`

## Uso

Los workflows se ejecutan automáticamente al hacer push a la rama main o manualmente desde la pestaña Actions de GitHub.

### Comandos Locales (opcionales)

```bash
cd infra/terraform

# Inicializar Terraform
make init

# Validar configuración
make validate

# Plan de ejecución
make plan

# Aplicar cambios
make apply

# Destruir infraestructura
make destroy
Recursos Creados
1 VPC con 2 subredes públicas

1 instancia EC2 t2.micro

1 dirección IP elástica

1 bucket S3 para estado de Terraform

1 tabla DynamoDB para bloqueo de estado

Todos los recursos están dentro del nivel gratuito de AWS.

text

## Instrucciones de Implementación

1. **Configura los secrets de GitHub**:
   - Ve a Settings > Secrets and variables > Actions en tu repositorio
   - Agrega `AWS_ACCESS_KEY_ID` y `AWS_SECRET_ACCESS_KEY` con las credenciales de AWS

2. **Asegúrate de tener la clave SSH en AWS**:
   - Crea o verifica que existe la clave "dev-key" en la región us-east-1

3. **Realiza el primer commit**:
   - La estructura de carpetas y archivos se creará automáticamente
   - El workflow de backend se ejecutará primero para crear el bucket S3

4. **Ejecuta el despliegue**:
   - El workflow de despliegue se ejecutará automáticamente después del backend
   - O ejecútalo manualmente desde la pestaña Actions

Esta implementación cumple con todos tus requisitos:
- ✅ 100% Automático mediante GitHub Actions
- ✅ Idempotente gracias a Terraform
- ✅ Escalable mediante módulos reutilizables
- ✅ Modular con separación clara de responsabilidades
- ✅ Replicable para múltiples entornos
- ✅ Dentro de la capa gratuita de AWS
- ✅ Sin scripts manuales (solo GitHub Actions)
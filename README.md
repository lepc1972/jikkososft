# jikkosoft

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-blue.svg)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2%2FS3%2FRDS-orange.svg)](https://aws.amazon.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)



# ATENCION
## Los directorios ssh y seguridad_nube tienen su propio readme



# Terraform IAC

# Terraform AWS Infrastructure

Este proyecto utiliza Terraform para desplegar una infraestructura en AWS que incluye:

- VPC con subredes públicas y privadas.
- Gateway de Internet y tablas de rutas.
- Un balanceador de carga (ALB) con grupos de destino.
- Un Auto Scaling Group con EC2 Launch Template.
- Un registro DNS en Route 53.

## **Requisitos**

- [Terraform](https://www.terraform.io/) instalado.
- Una cuenta de AWS y credenciales configuradas.
- Permisos adecuados para crear recursos en AWS.
- Una AMI válida para instancias EC2.

---

## **Variables**

Las variables definidas en el archivo `variables.tf`:

| **Variable**         | **Descripción**                                     | **Tipo**      | **Ejemplo**          |
|-----------------------|-----------------------------------------------------|---------------|----------------------|
| `region`             | Región de AWS donde se desplegarán los recursos.    | string        | `"us-east-1"`        |
| `aws_vpc`            | CIDR block para la VPC.                             | string        | `"10.0.0.0/16"`      |
| `aws_subnet_public`  | Lista de CIDR blocks para las subredes públicas.     | list(string)  | `["10.0.1.0/24"]`    |
| `aws_subnet_private` | Lista de CIDR blocks para las subredes privadas.     | list(string)  | `["10.0.2.0/24"]`    |
| `instance_type`      | Tipo de instancia EC2.                              | string        | `"t2.micro"`         |
| `ami`                | ID de la AMI para instancias EC2.                   | string        | `"ami-12345678"`     |
| `zone_id`            | ID de la zona de Route 53.                          | string        | `"Z1D633PJN98FT9"`   |
| `desired_capacity`   | Capacidad deseada para el Auto Scaling Group.        | number        | `2`                  |
| `max_size`           | Tamaño máximo del Auto Scaling Group.               | number        | `3`                  |
| `min_size`           | Tamaño mínimo del Auto Scaling Group.               | number        | `1`                  |
| `port`               | Puerto para el balanceador de carga.                | number        | `80`                 |

---

## **Cómo usar**

1. **Configura las credenciales de AWS**  
   Asegúrate de tener configuradas tus credenciales de AWS para que Terraform pueda autenticar.

   ```bash
   aws configure
   ```
2. **clona el repositorio**
   ```bash
   git clone <repositorio>
   cd <directorio>
   ```
3. **inicia terraform**
   ```bash
   terraform init
   ```
4. **crea un archivo terraform.tfvars**
   ```bash
   region           = "us-east-1"
   aws_vpc          = "10.0.0.0/16"
   aws_subnet_public = ["10.0.1.0/24", "10.0.2.0/24"]
   aws_subnet_private = ["10.0.3.0/24"]
   instance_type    = "t2.micro"
   ami              = "ami-12345678"
   zone_id          = "Z1D633PJN98FT9"
   desired_capacity = 2
   max_size         = 3
   min_size         = 1
   port             = 80
  ```
5. **aplica los cambios**

```bash
terraform apply
```

**Recursos creados**
--------------------

### VPC y Subredes

*   Una VPC con soporte DNS y hostnames.
    
*   Subredes públicas y privadas asociadas a diferentes zonas de disponibilidad.
    

### Gateway de Internet y Tablas de Rutas

*   Gateway de Internet para tráfico público.
    
*   Tabla de rutas configurada para enrutar tráfico externo.
    

### Balanceador de Carga

*   Application Load Balancer (ALB) configurado con un grupo de destino.
    

### Auto Scaling Group

*   Grupo de escalado automático con un Launch Template que utiliza la AMI y el tipo de instancia configurados.
    

### Route 53

*   Un registro A para el balanceador de carga.


# Docker

1. ## Se crea una estructura docker para construir una app

# My App with Docker

Este repositorio contiene una aplicación Dockerizada con soporte para pruebas automatizadas. La estructura del proyecto está diseñada para facilitar el desarrollo, pruebas y despliegue.

Requisitos

Antes de comenzar, asegúrate de tener instalados los siguientes componentes:

    Docker
    Docker Compose
    Python 3.x (opcional para desarrollo local)


```
└── 📁docker
    └── 📁my-app
        └── 📁app
            └── app.py
            └── requirements.txt
        └── docker-compose.yaml
        └── Dockerfile
        └── 📁tests
            └── __init__.py
            └── test_app.py
```

Uso
1. Construir y ejecutar los contenedores

Utiliza Docker Compose para construir y levantar los servicios definidos en docker-compose.yaml.

```bash
docker-compose up --build
```

Se genera una imagen la cual se sube a Dockerhub

lepc72/jukkisoft-app ,esta se puede bajar y probar su funcionamiento

2. Acceder a la aplicación

La aplicación estará disponible en el puerto 5000 por defecto. Accede a ella desde tu navegador o herramientas como curl:

```bash
http://localhost:5000
```

3. Detener los contenedores

Para detener y eliminar los contenedores:

```bash
docker-compose down
```
Licencia

Este proyecto está licenciado bajo la MIT License.


# .github ci-cd

# CI/CD Pipeline for My Application

Este repositorio utiliza un pipeline CI/CD configurado en **GitHub Actions** para automatizar el proceso de integración y despliegue continuo. El pipeline incluye pasos para la verificación del código, pruebas automatizadas y la construcción de imágenes Docker.

---

## **Características del Pipeline**

1. **Disparadores del Pipeline:**
   - Se ejecuta automáticamente en:
     - **Push** a la rama `main`.
     - **Pull Request** hacia la rama `main`.

2. **Servicios Incluidos:**
   - Base de datos **PostgreSQL** (v14) configurada como servicio para pruebas.

3. **Etapas del Pipeline:**
   - **Checkout del código**: Obtiene el código fuente del repositorio.
   - **Configuración de Python**: Establece el entorno Python 3.10.
   - **Instalación de dependencias**: Instala las dependencias definidas en `requirements.txt`.
   - **Análisis estático del código**: Verifica la calidad del código usando `flake8`.
   - **Pruebas automatizadas**: Ejecuta pruebas unitarias con `pytest`.
   - **Construcción de la imagen Docker**: Construye una imagen Docker para la aplicación.

---

## **Estructura del Pipeline**

### **Archivo del Pipeline**
El pipeline está definido en `.github/workflows/ci-cd.yml`.

### **Etapas y Configuración**

#### **1. Disparadores**
El pipeline se ejecuta automáticamente en las siguientes condiciones:
```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
```

Cómo Usar el Pipeline

    Configuración Inicial
        Asegúrate de que el repositorio tenga un archivo requirements.txt y que las pruebas estén configuradas correctamente en la carpeta tests.

    Push a la Rama Main Realiza un push a la rama main para disparar automáticamente el pipeline.

    Revisión de Resultados
        Navega a la pestaña Actions en GitHub para revisar la ejecución del pipeline.
        Asegúrate de que todas las etapas sean exitosas antes de proceder al despliegue.



Notas

    Variables de Entorno: El pipeline usa DATABASE_URL para configurar la conexión a PostgreSQL durante las pruebas.

    Linter: Asegúrate de que el código cumple con los estándares de flake8.

    Pruebas: Todas las pruebas deben ubicarse en docker/my-app/tests.

Licencia

Este proyecto está licenciado bajo la MIT License.




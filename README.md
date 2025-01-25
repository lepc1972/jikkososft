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







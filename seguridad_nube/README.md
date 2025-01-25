## crear grupo seguridad personalizado

```bash

# Crear un grupo de seguridad
aws ec2 create-security-group --group-name mi-grupo-seguridad --description "SG personalizado"

# Agregar reglas de ingreso (por ejemplo, permitir HTTP desde una IP específica)
aws ec2 authorize-security-group-ingress \
    --group-name mi-grupo-seguridad \
    --protocol tcp \
    --port 80 \
    --cidr 192.168.1.0/24

# Agregar reglas de egreso (por ejemplo, permitir todo el tráfico saliente)
aws ec2 authorize-security-group-egress \
    --group-name mi-grupo-seguridad \
    --protocol -1 \
    --port -1 \
    --cidr 0.0.0.0/0

```
### Buenas practicas

### usa reglas estrictas y específicas (por IP y puerto).
### Deniega todo el tráfico por defecto y habilita solo lo necesario.

## IAM Roles con Permisos Mínimos Necesarios

```bash
# Crear una política con acceso mínimo a S3
aws iam create-policy \
    --policy-name AccesoMinimoS3 \
    --policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::mi-bucket/*"
            }
        ]
    }'

# asociar politica a un rol 

aws iam create-role \
    --role-name mi-rol \
    --assume-role-policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }'

aws iam attach-role-policy \
    --role-name mi-rol \
    --policy-arn arn:aws:iam::123456789012:policy/AccesoMinimoS3

```
### buenas practicas

### Utiliza IAM Access Analyzer para identificar permisos excesivos.
### Aplica políticas de rotación de claves de acceso y elimina credenciales no utilizadas.


## Encriptación de Datos en Reposo y en Tránsito

### En reposo: Configura la encriptación en servicios como S3, RDS, o EBS.

```bash
# Habilitar encriptación en un bucket S3

## 

aws s3api put-bucket-encryption \
    --bucket mi-bucket \
    --server-side-encryption-configuration '{
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }
        ]
    }'

```

### En tránsito: Habilita HTTPS/SSL para las conexiones.



## Escaneo de Vulnerabilidades
### usar amazon inspector

```bash
aws inspector create-assessment-template \
    --assessment-template-name "PlantillaVulnerabilidad" \
    --duration-in-seconds 3600 \
    --rules-package-arns arn:aws:inspector:us-west-2:123456789012:rulespackage/0-ABCXYZ
```
### usar servicios de terceros
### Aqua Security, Qualys, o Nessus para análisis de vulnerabilidades en contenedores y aplicaciones.

# Resumen de buenas practicas

### Restringe el tráfico con Grupos de Seguridad personalizados
### Define políticas IAM con privilegios mínimos
### Habilita encriptación para proteger datos sensibles.
### Escanea regularmente la infraestructura en busca de vulnerabilidades.


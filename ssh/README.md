# Automatización de Provisionamiento y Configuración de Servidor Linux

## Objetivo
Configurar un servidor Linux (Ubuntu/CentOS) con:
- Hardening de SSH
- Instalación de paquetes esenciales
- Configuración de servicios (Nginx, MySQL, etc.)

---

## 1. SSH Hardening

### Configuración del archivo `sshd_config`:
```bash
sudo nano /etc/ssh/sshd_config
Port 2222                          # Cambiar puerto predeterminado
PermitRootLogin no                 # Deshabilitar acceso root
PasswordAuthentication no         # Usar solo autenticación por clave
AllowUsers usuario_admin           # Usuario permitido
MaxAuthTries 3                     # Límite de intentos de autenticación
ClientAliveInterval 300            # Desconexión por inactividad
Protocol 2                         # Forzar SSHv2
```


### post-configuracion:
```bash
sudo systemctl restart sshd
sudo ufw allow 2222/tcp           # Habilitar nuevo puerto en firewall
```
### Instalacion paquetes eseciales:
```bash
Para ubuntu/Debian
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  nginx \
  mysql-server \
  fail2ban \
  htop \
  curl \
  git \
  ufw \
  tree \
  unattended-upgrades
```

```bash
Para Centos/Rhel:
sudo yum update -y
sudo yum install -y \
  epel-release \
  nginx \
  mariadb-server \
  fail2ban \
  htop \
  curl \
  git \
  firewalld \
  tree
```
### Configuracion servicios:

```bash
nginx
# Habilitar y iniciar servicio
sudo systemctl enable nginx
sudo systemctl start nginx

# Configuración básica
sudo nano /etc/nginx/sites-available/default

# Configuracion recomendada

server {
    listen 80;
    server_name dominio.com;
    root /var/www/html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # Security Headers
    add_header X-Content-Type-Options "nosniff";
    add_header X-Frame-Options "SAMEORIGIN";
}

```
```bash
mysql/mariadb

# Ejecutar configuración segura
sudo mysql_secure_installation

# Crear usuario y base de datos
sudo mysql -u root -p
CREATE DATABASE app_db;
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password_seguro';
GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;
```
### Hardening adicional

```bash
ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 2222               # Puerto SSH personalizado
sudo ufw allow 80/tcp             # HTTP
sudo ufw allow 443/tcp            # HTTPS
sudo ufw enable
```
```bash
fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
[sshd]
enabled = true
port = 2222                       # Puerto SSH personalizado
maxretry = 3                      # Intentos fallidos permitidos
bantime = 1h 
sudo systemctl restart fail2ban
```
### Habilitar servicios
```bash
# Habilitar e iniciar servicios (persistencia en reinicios)
sudo systemctl enable --now mysql nginx fail2ban

# Verificar estado
sudo systemctl status mysql nginx fail2ban

centos

# Habilitar e iniciar servicios
sudo systemctl enable --now mariadb nginx fail2ban

# Verificar estado
sudo systemctl status mariadb nginx fail2ban
```

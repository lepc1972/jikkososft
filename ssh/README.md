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

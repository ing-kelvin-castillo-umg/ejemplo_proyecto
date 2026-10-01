# 🚀 Guía de Configuración CI/CD - Ferretería Express (Monorepo)

Este repositorio cuenta con flujos de trabajo automatizados en **GitHub Actions**:
1. **Validación de PR a `develop` (`pr-ci.yml`)**: Compilación/Tests, Análisis con SonarQube y Agente de IA.
2. **Despliegue a VPS (`deploy-vps.yml`)**: Despliegue automático vía SSH con reconstrucción selectiva en Docker Compose al hacer merge a `develop`.

---

## 🛡️ 1. Configuración de SonarQube / SonarCloud (Gratuito y Público)

Para no saturar la memoria RAM de tu servidor VPS, la mejor alternativa es **SonarCloud** (la versión SaaS oficial en la nube de SonarQube):
* **Es 100% gratuito** para repositorios públicos en GitHub.
* No requiere instalar servidores ni configurar bases de datos en tu máquina o VPS.

### Pasos para activarlo:
1. Ve a [https://sonarcloud.io](https://sonarcloud.io) e inicia sesión con tu cuenta de GitHub.
2. Haz clic en el botón **"+"** (arriba a la derecha) -> **Analyze new project**.
3. Selecciona tu repositorio: `ing-kelvin-castillo-umg/ejemplo_proyecto`.
4. Ve a tu perfil en SonarCloud -> **My Account** -> **Security** y genera un token (ej. `github-actions-token`).
5. En tu repositorio de GitHub ve a **Settings** -> **Secrets and variables** -> **Actions** -> **New repository secret**:
   * Nombre: `SONAR_TOKEN`
   * Valor: *Pega el token generado en SonarCloud*.
   * (Opcional) Si en el futuro usas un servidor propio de SonarQube, creas el secret `SONAR_HOST_URL` con la URL de tu servidor (ej. `http://mi-vps-ip:9000`). Si no se define, por defecto usa `https://sonarcloud.io`.

> **¿Qué pasa si no lo configuro aún?**  
> El Step 2 del pipeline detectará automáticamente que `SONAR_TOKEN` no está definido, emitirá un aviso informativo y **no romperá el flujo**. Además, cuenta con `continue-on-error: true` para hacer bypass si solo hay observaciones menores.

---

## 🤖 2. Configuración del Agente de IA para Code Review

El Step 3 está diseñado para revisar el Pull Request de forma inteligente:
1. Puedes generar una API Key gratuita o de bajo costo en:
   * **Google AI Studio (Gemini)**: [https://aistudio.google.com/](https://aistudio.google.com/)
   * **OpenAI Platform**: [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. En GitHub ve a **Settings** -> **Secrets and variables** -> **Actions** -> **New repository secret**:
   * Nombre: `AI_API_KEY`
   * Valor: *Tu API Key de Gemini u OpenAI*.

> **¿Qué pasa si no ingreso el API Key?**  
> El workflow incluye la condición de salida segura: si `AI_API_KEY` está vacío, muestra un mensaje informativo en los logs del pipeline y **se omite de forma transparente con éxito (código 0)**. Puedes agregarlo en cualquier momento a futuro.

---

## 🖥️ 3. Configuración del Despliegue en el VPS

Cuando se apruebe un PR hacia `develop`, el workflow se conecta por SSH a tu servidor y actualiza solo el servicio que cambió.

Configura los siguientes secrets en GitHub:

| Secret | Descripción | Ejemplo |
| :--- | :--- | :--- |
| `VPS_HOST` | Dirección IP pública o dominio de tu VPS | `143.198.xxx.xxx` |
| `VPS_USER` | Usuario con permisos sudo / docker | `ubuntu` o `root` |
| `VPS_SSH_KEY` | Clave privada SSH (contenido completo de `~/.ssh/id_rsa` o `~/.ssh/id_ed25519`) | `-----BEGIN OPENSSH PRIVATE KEY...` |
| `VPS_PORT` | (Opcional) Puerto SSH si no es el estándar 22 | `22` |

### Preparación única en tu VPS:
Asegúrate de que en el VPS esté instalado Docker y Docker Compose:
```bash
# En el VPS:
sudo apt update && sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
```

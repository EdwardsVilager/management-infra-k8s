# 🛠️ management-infra-k8s

Repositorio de **infraestructura como código (IaC)** para la gestión de un entorno Kubernetes utilizando **Terraform + Helm**, siguiendo buenas prácticas de modularidad, separación de responsabilidades y enfoque GitOps-ready.

Este repositorio está diseñado para:

- Administrar componentes base del clúster Kubernetes
- Desplegar microservicios de forma declarativa
- Gestionar Helm Charts y sus valores
- Facilitar entornos reproducibles (dev / stage / prod)

---

## 📂 Estructura del repositorio

    ```
    management-infra-k8s/
    ├── providers.tf
    ├── variables.tf
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfvars
    │
    ├── modules/
    │   └── microservice/
    │       ├── main.tf
    │       ├── variables.tf
    │       └── outputs.tf
    │
    ├── helm-values/
    │   ├── ingress-nginx-values.yaml
    │   ├── cert-manager-values.yaml
    │   └── wsrecaudos.yaml
    │
    └── charts/
        └── wsrecaudos/
            ├── Chart.yaml
            ├── values.yaml
            └── templates/
                ├── deployment.yaml
                ├── service.yaml
                ├── serviceaccount.yaml
                └── _helpers.tpl
    ```

---

## 🧩 Descripción de componentes

### 📌 Archivos raíz (Terraform)

| Archivo | Descripción |
|------|-----------|
| `providers.tf` | Configuración de proveedores (Kubernetes, Helm, etc.) |
| `variables.tf` | Definición de variables globales del entorno |
| `terraform.tfvars` | Valores específicos del entorno (NO subir secretos) |
| `main.tf` | Orquestación principal de módulos y recursos |
| `outputs.tf` | Salidas útiles del despliegue |

---

### 📦 Módulos Terraform

#### `modules/microservice/`

Módulo reutilizable para desplegar microservicios en Kubernetes usando Helm.

Responsabilidades:

- Crear namespaces
- Desplegar Helm Releases
- Parametrizar recursos (CPU, memoria, replicas)

Esto permite:

- Reutilización
- Menor acoplamiento
- Escalabilidad del código

---

### ⚙️ Helm Values

Directorio que centraliza los archivos `values.yaml` para diferentes charts.

| Archivo | Uso |
|------|----|
| `ingress-nginx-values.yaml` | Configuración personalizada de Ingress NGINX |
| `cert-manager-values.yaml` | Configuración de Cert-Manager |
| `wsrecaudos.yaml` | Valores del microservicio wsrecaudos |

👉 Esta separación permite mantener los charts genéricos y versionables.

---

### ⛵ Helm Chart: wsrecaudos

Chart personalizado para el microservicio **wsrecaudos**.

#### Contenido

- `deployment.yaml`: Despliegue del contenedor
- `service.yaml`: Exposición interna del servicio
- `serviceaccount.yaml`: Cuenta de servicio (RBAC-ready)
- `_helpers.tpl`: Templates reutilizables (nombres, labels)

Diseñado para ser:

- Parametrizable
- Portable
- Compatible con CI/CD

---

## 🚀 Flujo de despliegue

1️⃣ Inicializar Terraform

    ```bash
    terraform init
    ```

2️⃣ Validar

    ```bash
    terraform validate
    ```

3️⃣ Planificar

    ```bash
    terraform plan
    ```

4️⃣ Aplicar cambios

    ```bash
    terraform apply
    ```

---

## 🔐 Seguridad y buenas prácticas

- ❌ No subir secretos al repositorio
- ✔ Usar `terraform.tfvars` fuera de control de versiones
- ✔ Versionar Helm Charts
- ✔ Módulos pequeños y reutilizables
- ✔ Convenciones claras de nombres

---

## 🧪 Requisitos

- Terraform >= 1.x
- kubectl
- Helm >= 3.x
- Acceso a clúster Kubernetes

---

## 📌 Próximas mejoras

- Integración con CI/CD (GitHub Actions / GitLab CI)
- Soporte multi-entorno (workspaces)
- Validaciones con `terraform-docs` y `tflint`
- GitOps con ArgoCD

---

## 👤 Autor

Infraestructura diseñada siguiendo estándares de Cloud Engineering y Kubernetes.

---

> 💡 Este repositorio está preparado para entornos productivos y evaluaciones técnicas de nivel Senior.

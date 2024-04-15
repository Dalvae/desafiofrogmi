# Proyecto Desafío FrogMi

Este repositorio contiene el proyecto desarrollado como parte del desafío técnico propuesto por la empresa FrogMi. El proyecto consiste en una aplicación web construida con Ruby on Rails para el backend y Nuxt.js para el frontend.

## Requisitos

Antes de comenzar, asegúrate de tener instalado lo siguiente en tu sistema:

    Docker
    Docker Compose

## Configuración

1. Clona este repositorio en tu máquina local:

```bash

git clone https://github.com/tu-usuario/proyecto-frogmi.git
```

2. Navega al directorio del proyecto:

```bash

cd proyecto-frogmi
```

3. Copia el archivo .env.example y renómbralo a .env. Luego, asigna los valores correspondientes a las claves necesarias. Construye y inicia los contenedores Docker con el siguiente comando:

```bash

docker-compose up --build
```

Este comando construirá las imágenes de Docker para el backend y el frontend, e iniciará los contenedores correspondientes.
Acceso a la aplicación

## Acceso a la aplicación

Una vez que los contenedores estén en ejecución, podrás acceder a la aplicación en las siguientes direcciones:

- Frontend: http://localhost:8080
- Backend: http://localhost:3000

## Estructura del proyecto

- `backend/`: Directorio que contiene el código fuente del backend desarrollado con Ruby on Rails.
- `frontend/`: Directorio que contiene el código fuente del frontend desarrollado con Nuxt.js.
- `docker-compose.yml`: Archivo de configuración de Docker Compose que define los servicios (backend y frontend) y sus dependencias.

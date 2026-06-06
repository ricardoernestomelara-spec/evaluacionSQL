# evaluacionSQL
# Proyecto SQL - Sistema de Reservas

## 📌 Descripción
Este proyecto contiene un conjunto de **20 consultas SQL** diseñadas para practicar operaciones básicas y avanzadas en PostgreSQL.  
Incluye inserciones, actualizaciones, eliminaciones, consultas con agregaciones y diferentes tipos de JOIN aplicados a un esquema de reservas de alojamientos.

## 🛠️ Motor de base de datos
- **PostgreSQL 15** (compatible con versiones superiores)

## 🗂️ Archivos incluidos
- `consultas_sql.sql`: archivo con las 20 consultas, separadas por comentarios que indican el número y título de cada ejercicio.
- `Capturas de pantalla SQL.pdf`: documento con las evidencias de ejecución de cada consulta en pgAdmin/DBeaver.

## 🏗️ Esquema de la base de datos
El esquema incluye las siguientes tablas principales:
- **owners**: propietarios de alojamientos  
- **accommodations**: alojamientos registrados  
- **locations**: ciudades y países asociados  
- **guests**: huéspedes con sus datos personales  
- **bookings**: reservas realizadas por los huéspedes  
- **payments**: pagos asociados a las reservas  
- **reviews**: reseñas y calificaciones de los alojamientos  
- **booking_statuses**: estados de las reservas (Confirmada, Cancelada, etc.)  
- **accommodation_types**: tipos de alojamiento (Hotel, Casa, Apartamento, etc.)

## 🚀 Ejecución
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tuusuario/nombre-repositorio.git

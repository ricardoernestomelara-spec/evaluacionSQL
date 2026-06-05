-- 01. Insertar propietario
INSERT INTO owners (
    first_name, last_name, company_name, email, 
    phone, address_line1, city, state, country, 
    postal_code
)
VALUES (
    'Ricardo', 'Melara', 'INFRAMEN', 'ricardo@gmail.com',
    '87545655', 'Apopa', 'Apopa', 'Apopa', 
    'El salvador', '1101');


-- 02. Insertar alojamiento
INSERT INTO accommodations (
    owner_id, accommodation_type_id, location_id, 
    name, description, bedroom_count, bathroom_count, 
    base_price_per_night, currency_code, check_in_time, 
    check_out_time, is_active
)
VALUES (
   1, 2, 3, 'Casa de Playa', 'Hermosa casa frente al mar con vista panorámica', 8,
  4, 3, 120.00,  'USD', '14:00',  '11:00',  TRUE
);

-- 03. Insertar huésped y reserva
INSERT INTO guests (
  first_name, last_name, email, phone, date_of_birth, nationality, passport_number,
  emergency_contact_name, emergency_contact_phone
)
VALUES (
  'Ricardo', 'Melara', 'ricardo.melara@example.com', '77454554', '1985-04-20', 'El Salvador', 'SV123456',
  'José Melara', '70001234'
);

INSERT INTO bookings (
  guest_id, accommodation_id, room_id, booking_status_id, check_in_date, check_out_date, adult_count,
  child_count, subtotal_amount, tax_amount, discount_amount, total_amount, special_requests,
  booking_reference
)
VALUES (
  1, 1, NULL, 1, '2026-07-01', '2026-07-05', 2, 0, 480.00, 57.60, 0.00, 537.60,
  'Sin solicitudes especiales', 'RES-20260701-001'
);


-- 04. Insertar pago
INSERT INTO payments (
  booking_id, payment_date, amount, payment_method, payment_status, transaction_reference, notes
)
VALUES (
  1, '2026-07-01', 537.60, 'Tarjeta de crédito', 'Completado', 'TRANS-20260701-001', 'Pago realizado por Ricardo Melara'
);

-- 05. Alojamientos activos
SELECT 
    a.name, 
    at.type_name as tipo,
    l.city,
    a.base_price_per_night,
    a.is_active
FROM accommodations a
JOIN accommodation_types at ON a.accommodation_type_id = at.accommodation_type_id
JOIN locations l ON a.location_id = l.location_id
WHERE a.is_active = true
ORDER BY a.base_price_per_night DESC;

-- 06. Huéspedes por país
SELECT 
    nationality,
    COUNT(*) as total_huespedes,
    MIN(date_of_birth) as mas_joven,
    MAX(date_of_birth) as mas_mayor
FROM guests
GROUP BY nationality
ORDER BY total_huespedes DESC;


-- 07. Reservas por fechas
SELECT 
    b.booking_id,
    g.first_name  as huesped,
    a.name as alojamiento,
    b.check_in_date,
    b.check_out_date,
    b.total_amount
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN accommodations a ON b.accommodation_id = a.accommodation_id
WHERE b.check_in_date BETWEEN '2026-07-01' AND '2026-07-31'
ORDER BY b.check_in_date;

-- 08. Actualizar precio
UPDATE accommodations
SET base_price_per_night = 95.00,
    updated_at = CURRENT_TIMESTAMP
WHERE accommodation_id = 1;


-- 09. Actualizar estado de reserva
UPDATE bookings
SET booking_status_id = 2,  -- Ej: 2 = Cancelada
    updated_at = CURRENT_TIMESTAMP
WHERE booking_id = 1;


-- 10. Eliminar reseña
DELETE FROM reviews
WHERE review_id = 5;


-- 11. JOIN reservas + huésped
SELECT 
    b.booking_id,
    g.first_name,
    g.last_name,
    g.email,
    b.check_in_date,
    b.total_amount,
    bs.status_name
FROM bookings b
INNER JOIN guests g ON b.guest_id = g.guest_id
INNER JOIN booking_statuses bs ON b.booking_status_id = bs.booking_status_id;

-- 12. JOIN alojamiento completo
SELECT 
    a.name,
    at.type_name,
    o.first_name || ' ' || o.last_name as propietario,
    l.city,
    l.country,
    a.base_price_per_night
FROM accommodations a
JOIN accommodation_types at ON a.accommodation_type_id = at.accommodation_type_id
JOIN owners o ON a.owner_id = o.owner_id
JOIN locations l ON a.location_id = l.location_id;

-- 13. JOIN pagos + reservas
SELECT 
    p.payment_id,
    b.booking_id,
    g.first_name  as cliente,
    p.amount,
    p.payment_method,
    p.payment_status,
    p.created_at
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN guests g ON b.guest_id = g.guest_id;


-- 14. LEFT JOIN sin reseñas
SELECT 
    a.name,
    a.base_price_per_night,
    COUNT(r.review_id) as total_resenas,
    COALESCE(AVG(r.rating), 0) as promedio_rating
FROM accommodations a
LEFT JOIN reviews r ON a.accommodation_id = r.accommodation_id
GROUP BY a.accommodation_id, a.name, a.base_price_per_night
HAVING COUNT(r.review_id) = 0;


-- 15. LEFT JOIN sin reservas
SELECT 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.email,
    g.nationality
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL;


-- 16. Total ingresos
SELECT 
    SUM(total_amount) as ingresos_totales,
    COUNT(*) as total_reservas,
    AVG(total_amount) as ticket_promedio
FROM bookings;


-- 17. Promedio rating
SELECT ROUND(AVG(rating)::numeric, 2) AS promedio_rating
FROM reviews;

-- 18. Top alojamientos
SELECT a.name, COUNT(b.booking_id) AS total_reservas
FROM accommodations a
JOIN bookings b ON a.accommodation_id = b.accommodation_id
GROUP BY a.name
ORDER BY total_reservas DESC
LIMIT 5;


-- 19. HAVING más de 3 reservas
SELECT g.first_name  AS nombre, COUNT(b.booking_id) AS total_reservas
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.first_name, g.last_name
HAVING COUNT(b.booking_id) > 3
ORDER BY total_reservas DESC;


-- 20. Subconsulta alojamiento más caro
SELECT name, base_price_per_night
FROM accommodations
ORDER BY base_price_per_night DESC
LIMIT 1;









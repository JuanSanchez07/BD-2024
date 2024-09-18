USE banco;

#-------------------------------------------------------------------------
# Carga de datos de Prueba

#Ciudades:
INSERT INTO ciudad VALUES("Pigue", 8170);
INSERT INTO ciudad VALUES("Bahia Blanca", 8000);
INSERT INTO ciudad VALUES("La Plata", 1900);
INSERT INTO ciudad VALUES("Mar del Plata", 7600);
INSERT INTO ciudad VALUES("Tandil", 7000);
INSERT INTO ciudad VALUES("Olavarria", 7400);
INSERT INTO ciudad VALUES("Junin", 6000);
INSERT INTO ciudad VALUES("San Nicolas de los Arrollos", 2900);
INSERT INTO ciudad VALUES("Chivilcoy", 6620);
INSERT INTO ciudad VALUES("Zarate", 2800);

#Sucursales
INSERT INTO sucursal VALUES(128, "Galicia", "Peru 170", "2915152335", "18:00-20:00", 8170);
INSERT INTO sucursal VALUES(129, "Santander", "Avenida Rivadavia 1020", "1134567890", "09:00-17:00", 8000);
INSERT INTO sucursal VALUES(130, "BBVA", "Calle Florida 750", "1156789123", "10:00-16:00", 1900);
INSERT INTO sucursal VALUES(131, "HSBC", "Corrientes 550", "1122334455", "09:00-15:00", 7600);
INSERT INTO sucursal VALUES(132, "Banco Nacion", "Mitre 1234", "1145678901", "08:00-13:00", 7000);
INSERT INTO sucursal VALUES(133, "Macro", "Belgrano 333", "1134567809", "09:00-14:00", 7400);
INSERT INTO sucursal VALUES(134, "Patagonia", "San Martin 123", "1178901234", "09:00-16:00", 6000);
INSERT INTO sucursal VALUES(135, "Credicoop", "Lavalle 400", "1123456789", "10:00-15:00", 2900);
INSERT INTO sucursal VALUES(136, "Supervielle", "Alem 850", "1167890123", "09:00-17:00", 6620);
INSERT INTO sucursal VALUES(137, "Comafi", "Entre Rios 1200", "1176543210", "09:00-18:00", 2800);

#Empleados
INSERT INTO empleado VALUES(2080, "Sevenants", "Antonio", "DNI", 43091344, "Alem 1047", "2923447685", "Encargado", "perro123", 128);
INSERT INTO empleado VALUES(2081, "Perez", "Juan", "DNI", 40123456, "Sarmiento 123", "1134567890", "Cajero", "clave123", 129);
INSERT INTO empleado VALUES(2082, "Gonzalez", "Maria", "DNI", 39234567, "Colon 450", "1145678901", "Gerente", "clave456", 130);
INSERT INTO empleado VALUES(2083, "Lopez", "Carla", "DNI", 38456789, "Mitre 800", "1156789012", "Cajero", "clave789", 131);
INSERT INTO empleado VALUES(2084, "Martinez", "Lucas", "DNI", 37654321, "Belgrano 900", "1167890123", "Supervisor", "secreto12", 132);
INSERT INTO empleado VALUES(2085, "Fernandez", "Sofia", "DNI", 36890123, "San Martin 350", "1178901234", "Encargado", "pat123456", 133);
INSERT INTO empleado VALUES(2086, "Rodriguez", "Jose", "DNI", 35467890, "Lavalle 500", "1189012345", "Asistente", "macro321", 134);
INSERT INTO empleado VALUES(2087, "Alvarez", "Ana", "DNI", 32145678, "Avenida Rivadavia 200", "1134567891", "Cajero", "clave789", 129);
INSERT INTO empleado VALUES(2088, "Mendoza", "Ricardo", "DNI", 33234567, "Av. Belgrano 600", "1145678912", "Gerente", "seguro12", 130);
INSERT INTO empleado VALUES(2089, "Romero", "Laura", "DNI", 34345678, "Calle San Martin 500", "1156789123", "Cajero", "miClave1", 131);
INSERT INTO empleado VALUES(2090, "Garcia", "Pedro", "DNI", 35456789, "Calle Mitre 1000", "1167890123", "Supervisor", "clave321", 132);
INSERT INTO empleado VALUES(2091, "Vargas", "Sofia", "DNI", 36567890, "Av. San Martin 123", "1178901234", "Encargado", "pass1234", 133);
INSERT INTO empleado VALUES(2092, "Castro", "Carlos", "DNI", 37678901, "Lavalle 450", "1189012345", "Asistente", "pass5678", 134);
INSERT INTO empleado VALUES(2093, "Navarro", "Julieta", "DNI", 38789012, "Peatonal San Martin 550", "1190123456", "Cajero", "word1234", 134);
INSERT INTO empleado VALUES(2094, "Rios", "Tomas", "DNI", 39890123, "Avenida Colon 1500", "1201234567", "Cajero", "1234word", 135);

#Clientes
INSERT INTO cliente VALUES(1, "Gomez", "Julian","DNI", "41238908", "Peru 508", "2923703250", '2000-10-12');
INSERT INTO cliente VALUES(2, "Blackhall", "Emilio", "DNI", "42091787", "Alem 987", "291347689", '1998-04-13');
INSERT INTO cliente VALUES(3, "Lopez", "Agustina", "DNI", "34032123", "Mitre 344", "2923768534", '1999-09-14');
INSERT INTO cliente VALUES(4, "Rueda", "Martina", "DNI", "41654321", "Rondeau 450", "291500632", '2001-04-01');
INSERT INTO cliente VALUES(5, "Schamber", "Gustavo", "DNI", "43091343", "11 de Abril 503", "2923456789", '2003-05-01');

#Plazos fijos
INSERT INTO plazo_fijo VALUES(1, 50000.00, '2023-01-01', '2024-05-01', 3.50, 875.00, 128);
INSERT INTO plazo_fijo VALUES(2, 100000.00, '2024-02-15', '2024-01-15', 4.00, 2000.00, 129);
INSERT INTO plazo_fijo VALUES(3, 75000.00, '2022-03-10', '2024-09-10', 3.75, 1406.25, 130);
INSERT INTO plazo_fijo VALUES(4, 60000.00, '2024-04-05', '2024-06-05', 4.10, 1230.00, 131);
INSERT INTO plazo_fijo VALUES(5, 80000.00, '2024-05-20', '2024-11-20', 3.90, 1560.00, 132);

#Tasas Plazos fijos
INSERT INTO tasa_plazo_fijo VALUES(30, 0.00, 50000.00, 3.50);
INSERT INTO tasa_plazo_fijo VALUES(60, 50000.01, 100000.00, 3.75);
INSERT INTO tasa_plazo_fijo VALUES(90, 100000.01, 150000.00, 4.00);
INSERT INTO tasa_plazo_fijo VALUES(120, 150000.01, 200000.00, 4.25);
INSERT INTO tasa_plazo_fijo VALUES(180, 200000.01, 300000.00, 4.50);

#Plazo Cliente
INSERT INTO plazo_cliente VALUES(1,1); --Es correcto usar el nro_plazo asi?
INSERT INTO plazo_cliente VALUES(2,2);
INSERT INTO plazo_cliente VALUES(3,3);
INSERT INTO plazo_cliente VALUES(4,4);
INSERT INTO plazo_cliente VALUES(5,5);

#Prestamo 
INSERT INTO prestamo VALUES(1, '2024-09-17', 12, 50000.00, 3.50, 1750.00, 4312.50, 2080, 1);
INSERT INTO prestamo VALUES(2, '2024-09-18', 24, 100000.00, 4.00, 4000.00, 4562.50, 2081, 2);
INSERT INTO prestamo VALUES(3, '2024-09-19', 36, 75000.00, 3.75, 2812.50, 2229.00, 2082, 3);
INSERT INTO prestamo VALUES(4, '2024-09-20', 48, 60000.00, 4.10, 2460.00, 1591.25, 2083, 4);
INSERT INTO prestamo VALUES(5, '2024-09-21', 60, 80000.00, 3.90, 3120.00, 1432.75, 2084, 5);

#Pago
INSERT INTO pago VALUES(1, 1, '2024-10-01', '2024-09-25');
INSERT INTO pago VALUES(2, 2, '2024-11-01', NULL);
INSERT INTO pago VALUES(3, 3, '2024-10-15', '2024-10-10');
INSERT INTO pago VALUES(4, 4, '2024-11-15', NULL);
INSERT INTO pago VALUES(5, 5, '2024-12-01', '2024-11-30');

#Tasa prestamo 
INSERT INTO tasa_prestamo VALUES(12, 0.00, 50000.00, 3.50);
INSERT INTO tasa_prestamo VALUES(24, 50000.01, 100000.00, 3.75);
INSERT INTO tasa_prestamo VALUES(36, 100000.01, 150000.00, 4.00);
INSERT INTO tasa_prestamo VALUES(48, 150000.01, 200000.00, 4.25);
INSERT INTO tasa_prestamo VALUES(60, 200000.01, 300000.00, 4.50);

#Caja ahorro 
INSERT INTO caja_ahorro VALUES(123456789012345678, 1500.00);
INSERT INTO caja_ahorro VALUES(987654321098765432, 2500.50);
INSERT INTO caja_ahorro VALUES(111111111111111111, 3200.75);
INSERT INTO caja_ahorro VALUES(222222222222222222, 1800.25);
INSERT INTO caja_ahorro VALUES(333333333333333333, 4100.00);

#Tarjeta 
INSERT INTO tarjeta VALUES(1, '1234', '5678', '2025-12-31', 1001, 1);
INSERT INTO tarjeta VALUES(2, '2345', '6789', '2025-11-30', 1002, 2);
INSERT INTO tarjeta VALUES(3, '3456', '7890', '2026-01-15', 1003, 3);
INSERT INTO tarjeta VALUES(4, '4567', '8901', '2026-06-30', 1004, 4);
INSERT INTO tarjeta VALUES(5, '5678', '9012', '2026-09-25', 1005, 5);


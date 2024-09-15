# Creo de la Base de Datos
CREATE DATABASE banco;

# Selecciono la base de datos sobre la cual voy a hacer modificaciones
USE banco;

#-------------------------------------------------------------------------
# Creacion Tablas para las entidades

CREATE TABLE ciudad ( 
    nombre VARCHAR(45) NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,
    
    CONSTRAINT pk_ciudad 
    PRIMARY KEY (cod_postal)

) ENGINE=InnoDB;

CREATE TABLE sucursal (
    nro_suc SMALLINT unsigned NOT NULL AUTO_INCREMENT, -- Se agrega AUTO_INCREMENT
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    horario VARCHAR(50) NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_sucursal 
    PRIMARY KEY (nro_suc),

    CONSTRAINT fk_sucursal_ciudad 
    FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal)

) ENGINE=InnoDB;


CREATE TABLE empleado (
    legajo SMALLINT unsigned NOT NULL AUTO_INCREMENT, -- Se agrega AUTO_INCREMENT
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_doc VARCHAR(20) NOT NULL, -- Cambiado a VARCHAR(20)
    nro_doc INT(8) unsigned NOT NULL, -- NUMERO DE 8 CIFRAS
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    password VARCHAR(32) NOT NULL, -- Renombrado de 'pass' a 'password'
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_empleado 
    PRIMARY KEY (legajo),

    CONSTRAINT fk_empleado_sucursal 
    FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)

) ENGINE=InnoDB;

CREATE TABLE cliente (
    nro_cliente SMALLINT unsigned NOT NULL AUTO_INCREMENT, -- Se agrega AUTO_INCREMENT
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_doc VARCHAR(20) NOT NULL, -- Cambiado a VARCHAR(20)
    nro_doc INT(8) unsigned NOT NULL, -- NUMERO DE 8 CIFRAS
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,

    CONSTRAINT pk_cliente
    PRIMARY KEY (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE plazo_fijo (
    nro_plazo INT(8) unsigned NOT NULL AUTO_INCREMENT, -- Se agrega AUTO_INCREMENT
    capital DECIMAL(16, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(16,2)
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL, -- Cambiado a NOT NULL
    tasa_interes DECIMAL(4, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(4,2)
    interes DECIMAL(16, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(16,2)
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_plazo_fijo
    PRIMARY KEY (nro_plazo),

    CONSTRAINT fk_plazo_fijo_sucursal 
    FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)

) ENGINE=InnoDB;

CREATE TABLE tasa_plazo_fijo (
    periodo SMALLINT unsigned NOT NULL,
    monto_inf DECIMAL(16, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(16,2)
    monto_sup DECIMAL(16, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(16,2)
    tasa DECIMAL(4, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(4,2)

    CONSTRAINT pk_tasa_plazo_fijo
    PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;


CREATE TABLE plazo_cliente (
    nro_plazo INT(8) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_plazo_cliente
    PRIMARY KEY (nro_plazo, nro_cliente),

    CONSTRAINT fk_plazo_cliente_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente),

    CONSTRAINT fk_plazo_cliente_plazo_fijo
    FOREIGN KEY (nro_plazo) REFERENCES plazo_fijo (nro_plazo)

) ENGINE=InnoDB;

CREATE TABLE prestamo (
    nro_prestamo INT(8) unsigned NOT NULL AUTO_INCREMENT, -- Ahora es AUTO_INCREMENT
    fecha DATE NOT NULL,
    cant_meses SMALLINT unsigned NOT NULL,
    monto DECIMAL(10, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(10,2)
    tasa_interes DECIMAL(4, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(4,2)
    interes DECIMAL(9, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(9,2)
    valor_cuota DECIMAL(9, 2) unsigned NOT NULL, -- Cambiado a DECIMAL(9,2)
    legajo SMALLINT unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_prestamo
    PRIMARY KEY (nro_prestamo),

    CONSTRAINT fk_prestamo_empleado
    FOREIGN KEY (legajo) REFERENCES empleado (legajo),

    CONSTRAINT fk_prestamo_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE pago (
    nro_prestamo INT(8) unsigned NOT NULL,
    nro_pago INT(2) unsigned NOT NULL,
    fecha_venc DATE NOT NULL,
    fecha_pago DATE NULL, -- Ahora permite valores nulos (NULL)

    CONSTRAINT pk_pago 
    PRIMARY KEY (nro_prestamo, nro_pago),

    CONSTRAINT fk_pago_prestamo 
    FOREIGN KEY (nro_prestamo) REFERENCES prestamo(nro_prestamo)

) ENGINE=InnoDB;

CREATE TABLE tasa_prestamo (
    periodo INT(3) unsigned NOT NULL,
    monto_inf DECIMAL(10,2) UNSIGNED NOT NULL, -- Cambiado a DECIMAL(10,2) UNSIGNED
    monto_sup DECIMAL(10,2) UNSIGNED NOT NULL, -- Cambiado a DECIMAL(10,2) UNSIGNED
    tasa DECIMAL(4,2) UNSIGNED NOT NULL,       -- Cambiado a DECIMAL(4,2) UNSIGNED

    CONSTRAINT pk_tasa_prestamo
    PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;

CREATE TABLE caja_ahorro (
    nro_ca INT(8) unsigned NOT NULL AUTO_INCREMENT,
    CBU BIGINT(18) unsigned NOT NULL, -- NUMERO DE 18 CIFRAS
    saldo DECIMAL(16,2) unsigned NOT NULL,

    CONSTRAINT pk_caja_ahorro 
    PRIMARY KEY (nro_ca)

) ENGINE=InnoDB;

CREATE TABLE cliente_ca (
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca INT(8) unsigned NOT NULL,

    CONSTRAINT pk_client_ca
    PRIMARY KEY (nro_cliente,nro_ca),

    CONSTRAINT fk_cliente_ca_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente),

    CONSTRAINT fk_cliente_ca_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca)

) ENGINE=InnoDB;

CREATE TABLE tarjeta (
    nro_tarjeta BIGINT(16) unsigned NOT NULL AUTO_INCREMENT,
    PIN VARCHAR(32) NOT NULL,
    CVT VARCHAR(32) NOT NULL,
    fecha_venc DATE NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca INT(8) unsigned NOT NULL,

    CONSTRAINT pk_tarjeta 
    PRIMARY KEY (nro_tarjeta),

    CONSTRAINT fk_tarjeta_cliente_ca
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca)

) ENGINE=InnoDB;

CREATE TABLE caja (
    cod_caja SMALLINT unsigned NOT NULL AUTO_INCREMENT, -- USO SMALLINT PORQUE TIENE 5 CIFRAS

    CONSTRAINT pk_caja
    PRIMARY KEY (cod_caja)

) ENGINE=InnoDB;

CREATE TABLE ventanilla (
    cod_caja SMALLINT unsigned NOT NULL,
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_ventanilla
    PRIMARY KEY(cod_caja),

    CONSTRAINT fk_ventanilla_caja
    FOREIGN KEY (cod_caja) REFERENCES caja(cod_caja),
    
    CONSTRAINT fk_ventanilla_sucursal
    FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)

) ENGINE=InnoDB;

CREATE TABLE ATM (
    cod_caja SMALLINT unsigned NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,
    direccion VARCHAR(100) NOT NULL,

    CONSTRAINT pk_ATM 
    PRIMARY KEY (cod_caja),

    CONSTRAINT fk_ATM_caja
    FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja),

    CONSTRAINT fk_ATM_ciudad
    FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal)

) ENGINE=InnoDB;

CREATE TABLE transaccion (
    nro_trans INT(10) unsigned NOT NULL AUTO_INCREMENT, -- Cambié para incluir AUTO_INCREMENT
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    monto DECIMAL(16, 2) unsigned NOT NULL, -- Cambié FLOAT a DECIMAL(16,2)

    CONSTRAINT pk_transaccion
    PRIMARY KEY (nro_trans)

) ENGINE=InnoDB;

CREATE TABLE debito (
    nro_trans INT(10) unsigned NOT NULL,
    descripcion TEXT,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca INT(8) unsigned NOT NULL,

    CONSTRAINT pk_debito
    PRIMARY KEY (nro_trans),
    
    CONSTRAINT fk_debito_transaccion
    FOREIGN KEY (nro_trans) REFERENCES transaccion (nro_trans),
    
    CONSTRAINT fk_debito_cliente_ca
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca)

) ENGINE=InnoDB;

CREATE TABLE transaccion_por_caja (
    nro_trans INT(10) unsigned NOT NULL,
    cod_caja SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_transaccion_por_caja
    PRIMARY KEY (nro_trans), 

    CONSTRAINT fk_transaccion_por_caja_transaccion
    FOREIGN KEY (nro_trans) REFERENCES transaccion(nro_trans),

    CONSTRAINT fk_transaccion_por_caja_caja
    FOREIGN KEY (cod_caja) REFERENCES caja(cod_caja)
    
) ENGINE=InnoDB;

CREATE TABLE deposito (
    nro_trans INT(10) unsigned NOT NULL,
    nro_ca INT(8) unsigned NOT NULL,

    CONSTRAINT pk_deposito
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_deposito_transaccion_por_caja
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans),

    CONSTRAINT fk_deposito_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca)

) ENGINE=InnoDB;

CREATE TABLE extraccion (
    nro_trans INT(10) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca INT(8) unsigned NOT NULL,

    CONSTRAINT pk_extraccion
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_extraccion_transaccion_por_caja
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans),

    CONSTRAINT fk_extraccion_cliente_ca
    FOREIGN KEy (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca)

) ENGINE=InnoDB;

CREATE TABLE transferencia (
    nro_trans INT(10) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    origen INT(8) unsigned NOT NULL,
    destino INT(8) unsigned NOT NULL,

    CONSTRAINT pk_transferencia
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_transferencia_transaccion
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans),

    CONSTRAINT fk_transferencia_cliente_ca
    FOREIGN KEY (nro_cliente, origen) REFERENCES cliente_ca(nro_cliente, nro_ca),

    CONSTRAINT fk_transferencia_destino
    FOREIGN KEY (destino) REFERENCES caja_ahorro(nro_ca)
) ENGINE=InnoDB;

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



#-------------------------------------------------------------------------
# Creacion de vistas 
# trans_cajas_ahorro = Datos de todas las transferencias que son "caja_ahorro"
/*
   CREATE VIEW trans_cajas_ahorro AS 
   SELECT c.nro_ca, c.saldo, 
          c.clase, c.pais, c.nro_caniones, c.calibre, c. desplazamiento,
		  b_c.lanzado
   FROM (caja_ahorro as c JOIN  barco_clase as b_c ON b.nombre_barco = b_c.nombre_barco) 
        JOIN clases as c   ON c.clase = b_c.clase
   WHERE c.tipo="acorazado";*/

CREATE VIEW trans_cajas_ahorro AS
SELECT 
    ca.nro_ca,
    ca.saldo,
    t.nro_trans,
    t.fecha,
    t.hora,
    CASE
        WHEN d.nro_trans IS NOT NULL THEN 'debito'
        WHEN e.nro_trans IS NOT NULL THEN 'extraccion'
        WHEN tra.nro_trans IS NOT NULL THEN 'transferencia'
        WHEN dep.nro_trans IS NOT NULL THEN 'deposito'
        ELSE 'desconocido'
    END AS tipo,
    t.monto,
    CASE
        WHEN tra.nro_trans IS NOT NULL THEN tra.destino
        ELSE NULL
    END AS destino,
    tc.cod_caja,
    c.nro_cliente,
    c.tipo_doc,
    c.nro_doc,
    c.nombre,
    c.apellido
FROM caja_ahorro ca
LEFT JOIN transaccion_por_caja tc ON tc.cod_caja = ca.nro_ca
LEFT JOIN transaccion t ON t.nro_trans = tc.nro_trans
LEFT JOIN debito d ON d.nro_trans = t.nro_trans
LEFT JOIN extraccion e ON e.nro_trans = t.nro_trans
LEFT JOIN transferencia tra ON tra.nro_trans = t.nro_trans
LEFT JOIN deposito dep ON dep.nro_trans = t.nro_trans
LEFT JOIN cliente c ON c.nro_cliente = tra.nro_cliente 
    OR c.nro_cliente = e.nro_cliente 
    OR c.nro_cliente = d.nro_cliente;

#-------------------------------------------------------------------------
# Creacion de usuarios y otorgamiento de privilegios

# primero creo un usuario con CREATE USER

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

# el usuario admin con password 'admin' puede conectarse solo 
# desde la desde la computadora donde se encuentra el servidor de MySQL (localhost)   

# luego le otorgo privilegios utilizando solo la sentencia GRANT

    GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

# El usuario 'admin' tiene acceso total a todas las tablas de 
# la B.D. banco y puede crear nuevos usuarios y otorgar privilegios.

# Luego creo un usuario 'empleado' con CREATE USER

    CREATE USER 'empleado'@'localhost' IDENTIFIED BY 'empleado'; 

# el usuario 'empleado' con password 'empleado' puede conectarse solo desde localhost

# Luego le otorgo privilegios con GRANT

    #CONSULTA
    GRANT SELECT ON banco.empleado TO 'empleado'@'localhost';
    GRANT SELECT ON banco.sucursal TO 'empleado'@'localhost'; 
    GRANT SELECT ON banco.tasa_plazo_fijo TO 'empleado'@'localhost';
    GRANT SELECT ON banco.tasa_prestamo TO 'empleado'@'localhost';

    #CONSULTA Y CREA
    GRANT SELECT, INSERT ON banco.prestamo TO 'empleado'@'localhost';
    GRANT SELECT, INSERT ON banco.plazo_fijo TO 'empleado'@'localhost';
    GRANT SELECT, INSERT ON banco.plazo_cliente TO 'empleado'@'localhost';
    GRANT SELECT, INSERT ON banco.caja_ahorro TO 'empleado'@'localhost';
    GRANT SELECT, INSERT ON banco.tarjeta TO 'empleado'@'localhost';

    #CONSULTA, CREA Y MODIFICA
    GRANT SELECT, INSERT, UPDATE ON banco.cliente_ca TO 'empleado'@'localhost';
    GRANT SELECT, INSERT, UPDATE ON banco.cliente TO 'empleado'@'localhost';
    GRANT SELECT, INSERT, UPDATE ON banco.pago TO 'empleado'@'localhost';

# Luego creo un usuario 'atm' con CREATE USER

    CREATE USER 'atm'@'%' IDENTIFIED BY 'atm'; 

# el usuario 'atm' con password 'atm' puede conectarse solo desde localhost

# Luego le otorgo privilegios con GRANT

    GRANT SELECT ON banco.trans_cajas_ahorro TO 'atm'@'%';

    -- Otorgar permisos de lectura y actualización sobre la tabla tarjeta
    GRANT SELECT, UPDATE ON banco.tarjeta TO 'atm'@'%';

-- Aplicar los cambios
FLUSH PRIVILEGES;    
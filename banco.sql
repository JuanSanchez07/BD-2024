-- Creo de la Base de Datos
CREATE DATABASE banco;

-- selecciono la base de datos sobre la cual voy a hacer modificaciones
USE banco;

-- Creación Tablas 

CREATE TABLE ciudad ( 
    nombre VARCHAR(45) NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,
    
    CONSTRAINT pk_ciudad PRIMARY KEY (cod_postal)
) ENGINE=InnoDB;

CREATE TABLE sucursal (
    nro_suc SMALLINT unsigned NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    horario VARCHAR(50) NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_sucursal PRIMARY KEY (nro_suc),
    CONSTRAINT fk_sucursal_ciudad FOREIGN KEY (cod_postal) REFERENCES  ciudad(cod_postal)
) ENGINE=InnoDB;

CREATE TABLE empleado (
    legajo SMALLINT unsigned NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_doc VARCHAR(100) NOT NULL,
    nro_doc SMALLINT unsigned NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    pass VARCHAR(32) NOT NULL,
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_empleado PRIMARY KEY (legajo),
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)
) ENGINE=InnoDB;

CREATE TABLE cliente (
    nro_cliente SMALLINT unsigned NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_doc VARCHAR(100) NOT NULL,
    nro_doc SMALLINT unsigned NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    fecha_nac VARCHAR(100) NOT NULL,

    CONSTRAINT pk_cliente
    PRIMARY KEY (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE plazo_fijo (
    nro_plazo SMALLINT unsigned NOT NULL,
    capital FLOAT(100, 2) unsigned NOT NULL,
    fecha_inicio VARCHAR(100) NOT NULL,
    fecha_fin VARCHAR(100),
    tasa_interes FLOAT(100, 2) unsigned NOT NULL,
    interes FLOAT(100, 2) unsigned NOT NULL,
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_plazo_fijo
    PRIMARY KEY (nro_plazo),

    CONSTRAINT fk_plazo_fijo_sucursal FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)

    
) ENGINE=InnoDB;

CREATE TABLE tasa_plazo_fijo (
    periodo SMALLINT unsigned NOT NULL,
    monto_inf FLOAT(100, 2) unsigned NOT NULL,
    monto_sup FLOAT(100, 2) unsigned NOT NULL,
    tasa FLOAT(100, 2) unsigned NOT NULL,

    CONSTRAINT pk_tasa_plazo_fijo
    PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;

CREATE TABLE plazo_cliente (
    nro_plazo SMALLINT unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_plazo_cliente
    PRIMARY KEY (nro_plazo, nro_cliente),

    CONSTRAINT fk_plazo_cliente_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente),

    CONSTRAINT fk_plazo_cliente_plazo_fijo
    FOREIGN KEY (nro_plazo) REFERENCES plazo_fijo (nro_plazo)

) ENGINE=InnoDB;

CREATE TABLE prestamo (
    nro_prestamo SMALLINT unsigned NOT NULL,
    fecha VARCHAR(45) NOT NULL,
    cant_meses SMALLINT unsigned NOT NULL,
    monto FLOAT(100, 2) unsigned NOT NULL,
    tasa_interes FLOAT(100, 2) unsigned NOT NULL,
    interes FLOAT(100, 2) unsigned NOT NULL,
    valor_cuota FLOAT(100, 2) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_prestamo
    PRIMARY KEY (nro_prestamo),

    CONSTRAINT fk_prestamo_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)
) ENGINE=InnoDB;

CREATE TABLE pago (
    nro_prestamo SMALLINT unsigned NOT NULL,
    nro_pago SMALLINT unsigned NOT NULL,
    fecha_venc VARCHAR(100) NOT NULL,
    fecha_pago VARCHAR(100) NOT NULL,

    CONSTRAINT pk_pago 
    PRIMARY KEY (nro_prestamo,nro_pago),

    CONSTRAINT fk_pago_prestamo 
    FOREIGN KEY (nro_prestamo) REFERENCES prestamo(nro_prestamo)
) ENGINE=InnoDB;

CREATE TABLE tasa_prestamo (
    periodo SMALLINT unsigned NOT NULL,
    monto_inf FLOAT(100,2) unsigned NOT NULL,
    monto_sup FLOAT(100,2) unsigned NOT NULL,
    tasa FLOAT(100,2) unsigned NOT NULL,

    CONSTRAINT pk_tasa_prestamo
    PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE caja_ahorro (
    nro_ca SMALLINT unsigned NOT NULL,
    CBU BIGINT unsigned NOT NULL,
    saldo FLOAT(100,2) unsigned NOT NULL,

    CONSTRAINT pk_caja_ahorro 
    PRIMARY KEY (nro_ca)
) ENGINE=InnoDB;

CREATE TABLE cliente_ca (
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_client_ca
    PRIMARY KEY (nro_cliente,nro_ca)
    -- son llaves foraneas?
) ENGINE=InnoDB;

CREATE TABLE tarjeta (
    nro_tarjeta BIGINT unsigned NOT NULL,
    PIN VARCHAR(32) NOT NULL,
    CVT VARCHAR(32) NOT NULL,
    fecha_venc VARCHAR(100) NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_tarjeta 
    PRIMARY KEY (nro_tarjeta),

    CONSTRAINT fk_tarjeta_cliente 
    FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente),

    CONSTRAINT fk_tarjeta_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca)

) ENGINE=InnoDB;

CREATE TABLE ventanilla (
    cod_caja SMALLINT unsigned NOT NULL,
    nro_suc SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_ventanilla
    PRIMARY KEY(cod_caja),
    
    CONSTRAINT fk_ventanilla_sucursal
    FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc)

) ENGINE=InnoDB;

CREATE TABLE ATM (
    cod_caja SMALLINT unsigned NOT NULL,
    cod_postal SMALLINT unsigned NOT NULL,
    direcccion VARCHAR(100) NOT NULL,

    CONSTRAINT pk_ATM 
    PRIMARY KEY (cod_caja),

    CONSTRAINT fk_ATM_ciudad
    FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal)

) ENGINE=InnoDB;

CREATE TABLE debito (
    nro_trans BIGINT(10) unsigned NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca SMALLINT unsigned NOT NULL,
    monto FLOAT(100,2) unsigned NOT NULL,
    fecha VARCHAR(100) NOT NULL,
    hora VARCHAR(100) NOT NULL,

    CONSTRAINT pk_debito
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_debito_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca),

    CONSTRAINT fk_debito_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE deposito (
    nro_trans BIGINT(10) unsigned NOT NULL,
    monto FLOAT(100,2) unsigned NOT NULL,
    fecha VARCHAR(100) NOT NULL,
    hora VARCHAR(100) NOT NULL,
    nro_ca SMALLINT unsigned NOT NULL,

    CONSTRAINT pk_deposito
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_deposito_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca)

) ENGINE=InnoDB;

CREATE TABLE extraccion (
    nro_trans BIGINT(10) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    nro_ca SMALLINT unsigned NOT NULL,
    monto FLOAT(100,2) unsigned NOT NULL,
    fecha VARCHAR(100) NOT NULL,
    hora VARCHAR(100) NOT NULL,

    CONSTRAINT pk_extraccion
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_extraccion_caja_ahorro
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca),

    CONSTRAINT fk_extraccion_cliente
    FOREIGN KEy (nro_cliente) REFERENCES cliente(nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE transferencia (
    nro_trans BIGINT(10) unsigned NOT NULL,
    nro_cliente SMALLINT unsigned NOT NULL,
    origen SMALLINT unsigned NOT NULL,
    destino SMALLINT unsigned NOT NULL,
    monto FLOAT(100,2) unsigned NOT NULL,
    fecha VARCHAR(100) NOT NULL,
    hora VARCHAR(100) NOT NULL,

    CONSTRAINT pk_transferencia
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_transferencia_cliente
    FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente),

    CONSTRAINT fk_transferencia_origen
    FOREIGN KEY (origen) REFERENCES caja_ahorro(nro_ca),

    CONSTRAINT fk_transferencia_destino
    FOREIGN KEY (destino) REFERENCES caja_ahorro(nro_ca)
    
) ENGINE=InnoDB;




-- INSERT INTO ciudad VALUES('pigue',8170);
-- INSERT INTO sucursal VALUES(128, 'galicia', 'peru170', '291', '18:00-20:00', 8170);
-- INSERT INTO empleado VALUES( 127000 , 'sevenants', 'antonio', 'DNI', 43091344, 'alem1047', '2923', 'asistente', md5('hola'), 128);
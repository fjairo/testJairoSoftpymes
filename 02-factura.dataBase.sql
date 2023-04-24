create database if not exists  `test-mysql`;

use `test-mysql`;

CREATE TABLE `documenttypes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT 'Tipo de documento'
);

CREATE TABLE `documentnumbers` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `lastNumber` varchar(10) NOT NULL DEFAULT 0 COMMENT 'último número de documento',
  `documentType` int
);

CREATE TABLE `invoices` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `documentNumber` varchar(10) NOT NULL COMMENT 'Número documento',
  `date` datetime DEFAULT (now()) COMMENT 'Fecha de la factura',
  `documentTypeId` int,
  `person` varchar(250) NOT NULL COMMENT 'Nombre de la persona',
  `total` decimal(16, 4) NOT NULL DEFAULT 0 COMMENT 'Valor total de los productos'
);

CREATE TABLE `invoicesdetails` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `itemName` varchar(250) NOT NULL COMMENT 'Nombre del producto',
  `invoiceId` int,
  `value` decimal(16, 4) NOT NULL DEFAULT 0 COMMENT 'Valor del producto'
);

ALTER TABLE `documentnumbers` ADD FOREIGN KEY (`documentType`) REFERENCES `documenttypes` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`documentTypeId`) REFERENCES `documenttypes` (`id`);

ALTER TABLE `invoicesdetails` ADD FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`);
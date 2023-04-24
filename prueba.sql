--SELECT guardarFactura('Andres Baragan','pago') as Resultado;
DELIMITER //
CREATE TRIGGER `INVOICE_AFTER_INSERT` AFTER INSERT ON `invoices` FOR EACH ROW
BEGIN
    DECLARE document_type_id INT; ---table DocumentTypes
    DECLARE last_number INT;      ---teble documentNumbers
--GESTIONAR PARA MODIFICAR O INSERTAR LAS TABLAS documenttype Y documentnumbers
    
    --verificar nombre(name) documentType
    SELECT id INTO document_type_id  FROM documentType WHERE name = new.name;

    if(document_type_id IS NULL) THEN
        --Insertar name en la  tabla documenttype
        INSERT INTO documentTypes(name) VALUES(NEW.name);
        SET document_type_id= LAST_INSERT_ID();
        
        --insertar documenttype en la tabla documentsnumbers
        INSERT INTO documentNumbers(documentType) values (document_type_id);
    ELSE
        --encuentro last_number de la tabla documentnumbers con document_type_id
        SELECT lastNumber into last_number from documentNumbers WHERE documentType = document_type_id;
        SET last_number=last_number + 1;

        --actualizar lastNumber de la tabla documentNumber--
        UPDATE documentNumbers SET lastNumber=last_number WHERE documentType=document_type_id;
    END IF;

--GENERAR NUMERO
    set document_number=CONCAT('V-', LPAD(last_number,6,'0'));

    SET NEW.documentNumber=document_number;

    DELIMITER;
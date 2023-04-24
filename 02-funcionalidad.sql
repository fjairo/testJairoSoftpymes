/*requerimientos general
    1. Se requiere crear facturas de clientes
    estas facturas inicialmente estarán en valor cero(0.00)
    
    2. una vez se agreguen productos a estas facturas, el valor de la factura debe
    actualizarse

    3. el número de la factura debe ser generado de manera dinámica

/*****************************EJERCICIO 1*****************************

requerimiento especifico

    1. crear un trigger

    2. una vez se cree una factura

    2.  aumentar el valor del último número (lastNumber) del documento del documento una vez se cree una factura
    
    SI NO EXISTE

    3. tener en cuenta que los números de las facturas (invoice.documentNumber) dependen del la tabla tipo de documento(documenttype)
    en caso de no existir debe ser creado el registro tipo de documento(registro documentTypes) y el registro(documeNtNumbers) que controla el número de las facturas.


*/

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
    UCASE(LEFT(NEW.name,1))
    set document_number=CONCAT( UCASE(LEFT(NEW.name,1)),'-', LPAD(last_number,6,'0'));

    SET NEW.documentNumber=document_number;

    DELIMITER;


/*****************************EJERCICIO 2*****************************

2.  Crear una función o procedimiento almacenado, que permita crear una factura en la
    tabla invoices, para lo cual se debe enviar los siguientes datos:
|       ● nombre de la persona o cliente (varchar)
        ● tipo de documento (varchar)

En caso de no existir el tipo de documento(documenttypes), la función o procedimiento almacenado,
debe crear dicho tipo de documento.
*/ 
/* la factura se ingresa de la siguiente manera: SELECT guardarFactura('Andres Baragan','pago') as Resultado;*/

DROP FUNTION IF exists guardarFactura;

DELIMITER //

CREATE FUNCTION guardarFactura(_persona VARCHAR(50), _tipoDocumento_name VARCHAR(50)) RETURNS VARCHAR(250)
BEGIN
    DECLARE document_type_id varchar(50);
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        RETURN 'Error al tratar de guardar la factura';
    END;
    --buscar id de documenttypes
    SELECT id INTO document_type_id from DocumentTypes where name= _tipoDocumento_name; 
    --si existe
    IF(document_type_id IS NOT NULL)THEN
    --insertar datos a la tabla invoices
        INSERT INTO invoices(person, documentTypeId) values(_person, Document_type_id);
    ELSE
    --insertar datos en documenttype
        INSERT INTO documenttypes(name) values (_tipoDocumento_name);
        SET document_type_id= LAST_INSERT_ID();
    --insertar datos en invoices
        INSERT INTO invoices(person, documentTypeId) values(_person, document_type_id);
         SET id_invoice= LAST_INSERT_ID();
    END IF;
    -- devuelvo texto y id de la la tabla invoices
    SET SALIDA=CONCAT('La factura se almacenó correctamente con el ID: ', CONVERT(id_invoice, char(50)));
END
//

/*****************************EJERCICIO 3*****************************/
/*como se cinsulta SELECT agregarProductos('Pago de servicio',113000, 6) as Resultado;

*/

drop function if exists agregarProductos;

DELIMITER //

CREATE function agregarProductos(_producto VARCHAR(50), _valor DECIMAL(16, 4), _idFactura int) RETURNS VARCHAR(250)
BEGIN
    DECLARE salida varchar(250);

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIn
       RETURN  'Error al tratar de agregar productos a la factura';
    END;

INSERT INTO invoicesdetails(itemName, value, invoiceId) VALUES(_producto, _valor, _idFactura)
    SET salida = concat('El producto: ', _producto, ', fue agregado correctamente.');
    RETURN salida;
END
//

/*****************************EJERCICIO 4*****************************/
/*SELECT modificarQuitarProductos('Laptop', 0, 2, 'D') as Resultado;


*/





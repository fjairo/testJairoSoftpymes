/*los programas usados son MySQLWorkbench, Visual Studio Code, Github

MySQLWorkbench esta en modo de actualización segura está habilitado en tu cliente de MySQL.
*/



/*
 1. Consultar los items que pertenezcan a la compañia con ID #3 (debe utilizar INNER JOIN) */

/*  respuesta
                SELECT * FROM companies INNER JOIN ITEMS WHERE companies.id=3;
 */


/* 2. Mostrar los items para los cuales su precio se encuentre en el rango 70000 a 90000*/
 
 /* 
    respuesta
                SELECT * FROM ITEMS WHERE price BETWEEN 70000 AND 90000;



/* 3. Mostrar los items que en el nombre inicien con la letra "A" */
/*
    respuesta
                SELECT * FROM ITEMS WHERE name LIKE 'a%';


/* 4. Mostrar los items que tengan relacionado el color Rojo */
    /*
    respuesta
                SELECT * FROM ITEMS INNER JOIN colors WHERE code=2;

                
/* 5. Se requiere asignar un precio a los items cuyo precio sea NULL, 
el precio a agregar debe ser calculado de la siguiente forma: costo del item + 10.000*/
    
    /*
        respuesta 
                UPDATE items SET price =10000 WHERE price=0.0 AND id > 0;

    */

    /* 6. Incrementar el precio de los items en un 20% */
/*
        respuesta
              UPDATE ITEMS SET price = price * 1.2 WHERE id > 0;
*/

/* 7. Consultar los items por nombre y limitar la consulta para que sea paginada por un 
limite de 5 registros por página */
/*
        respuesta
            SELECT * FROM ITEMS WHERE name LIKE 'ZAPATO%'LIMIT 5 OFFSET 0;

/* 8. Eliminar los items que pertenezcan a la compañía con ID #1  (Debe usar inner join)*/

/*      respuesta

            DELETE items FROM items
            INNER JOIN companies
            ON companies.id=items.companyId
             WHERE companies.id=1;
 

 /* 9. Eliminar los items que tengan el costo menor a 10.000 */

/*            comentario: desabilitar modo seguro de MySQLWorkbench con SET SQL_SAFE_UPDATES=0; y SET SQL_SAFE_UPDATES=1;*/
/*      respuesta
            SET SQL_SAFE_UPDATES=0;
            DELETE items FROM items WHERE cost>10000;
            SET SQL_SAFE_UPDATES=1;

/* 10. Cree una función que permita insertar registros en la tabla colores*/
/*
        respuesta

           CREATE FUNCTION insertar_color(code_color VARCHAR(3), name_color VARCHAR(25))
            RETURNS VARCHAR(50)
            DETERMINISTIC
            NO SQL
            BEGIN
                DECLARE var_id INT;
                INSERT INTO colors(code, name) VALUES(code_color, name_color);
                SET var_id = LAST_INSERT_ID();
                RETURN CONCAT('Se ha insertado el color con ID ', var_id);
            END//
            DELIMITER ;



            SELECT insert_color('9', 'PINK');

/* 11. Eliminar todos los datos de la tabla colores*/
/*          comentario: se requiere hacer uso de la clausula where con una columna clave para la eliminación accidental de datos en MySQLWorkbench
            respuesta
            /*DELETE FROM colors WHERE id > 0;*/


            /* 12. Agregar un campo llamado "isdelete" en la tabla items, que no permita ser NULL,
debe tener un valor por defecto = 0 debe ser un campo númerico, tener un comentario que diga
(0=No se borra / 1=Se borra) cantidad permitida de caracteres = 1 */
/*          
                respuesta
                ALTER TABLE items ADD COLUMN isdelete TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=No se borra / 1=Se borra';
*/



set @v_id_subscriptor = 16;
set @v_id_fact = null;
set @v_id_prod = 2;
set @v_cant = 2;
set @v_num_items = 2; 
set @v_p_venta = 0;

/* 1) Crear usuario en Tabla Subscriptores */
/*  insert into bd_sample.tbl_subscriptores (
		id_subscriptor, codigo_subscriptor, nombres, apellidos
    ) values ( @v_id_subscriptor, 202212345, 'Jon Paul', 'Doe');
    
	
select * from bd_sample.tbl_subscriptores order by id_subscriptor asc; */

/* 2) Crear Registro de Productos y Facturas*/
         
    insert into bd_sample.tbl_facturas (
		id_factura, fecha_emision, id_subscriptor, numero_items, isv_total, subtotal, totapagar
    ) values ( @v_id_fact, curdate(), @v_id_subscriptor, @v_num_items, 0, 0, 0);

    select last_insert_id() into @v_id_fact;
    
	insert into bd_sample.tbl_items_factura (
		id_factura, id_producto, cantidad
    ) values ( @v_id_fact, @v_id_prod, @v_cant);
    
/* 3) INSERTs de nuevos atributos y guardado */
    
    select sum(cantidad) into @v_num_items
    from bd_sample.tbl_items_factura
    where id_factura = @v_id_fact;
    
    select precio_venta into @v_p_venta 
	from bd_sample.tbl_productos 
	where id_producto = @v_id_prod;
    
    update bd_sample.tbl_facturas
		set numero_items = @v_num_items,
			isv_total = (@v_p_venta * @v_num_items)*0.18, 
            subtotal  =  @v_p_venta * @v_num_items,
            totapagar = (@v_p_venta * @v_num_items)*1.18
		where id_factura = @v_id_fact;
        
	commit;
	
	select *
    from bd_sample.tbl_facturas
    where id_subscriptor= 16;

/* 4) ¿Cuál es el resultado final? Resultado de Suma de id_producto 2 y 3  */

    select sum(totapagar) Monto_Final
    from bd_sample.tbl_facturas
    where id_factura between '42' and '43';
    
/* Addendum: El motivo por el que las IDs de las facturas
lucen de esa manera es debido a las múltiples pruebas fallidas
que resulatron en el proceso de aprendizaje. Cabe destacar que,
si se necesita hacer prueba en una Base de Datos totalmente menta,
lo mejor que se puede hacer es cambiar los ultimos atributos del
//SELECT// de /42/ y /43/ a los números /26/ y /27/, para la
respuesta final. */
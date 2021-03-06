Drop Procedure if Exists bd_factsv2.SP_Registro_Producto;
Delimiter //
Create Procedure bd_factsv2.SP_Registro_Producto(
	in p_idFactura 	int,
    in p_idProducto int,
    in p_cantidad 	int
)
Begin
	declare v_idFactura 			int;
    declare v_idProducto 			int;
    declare v_cantidad 				int default 0;
    declare v_impuestosobreventa 	decimal(12,2);
    declare v_precioVenta 			decimal(12,2);
    declare v_saldoUnidades     	int;
    declare v_saldoUnidades_Mod     int;
    
    declare v_estado varchar(45);
    declare v_fechaVencimiento datetime;
         
    set v_idFactura = p_idFactura;
    set v_idProducto = p_idProducto;
    set v_cantidad = p_cantidad;
    
	select precioVenta into v_precioVenta from bd_factsv2.tbl_productos where idProducto = v_idProducto;
    
    set v_impuestosobreventa = v_precioVenta * 0.15;
    
    select saldoUnidades into v_saldoUnidades from bd_factsv2.tbl_productos where idProducto = v_idProducto;
    
    if v_idFactura is not null and v_cantidad <= v_saldoUnidades then
		insert into bd_factsv2.tbl_productos_facturados(
			idProducto, idFactura, cantidad, impuestosobreventa, precioVenta
		) values (
			v_idProducto, v_idFactura, v_cantidad, v_impuestosobreventa, v_precioVenta
		);
   /* ------------------------------------------------------------------- */     
        set v_saldoUnidades_Mod = v_saldoUnidades - v_cantidad;
		
		update bd_factsv2.tbl_productos set
			saldoUnidades = v_saldoUnidades_Mod
		where idProducto = v_idProducto;
   /* ------------------------------------------------------------------- */ 
    else
		update bd_factsv2.tbl_productos_facturados set
			idProducto = v_idProducto,
            idFactura = v_idProducto,
            cantidad = 0,
            impuestosobreventa = v_precioVenta * 0.15,
            precioVenta = v_precioVenta
		where idFactura = v_idFactura and idProducto = v_idProducto;
	end if;
    
    /* ------------------------------------------------------------------ */
    select fechaVencimiento into v_fechaVencimiento from bd_factsv2.tbl_facturas where idFactura = v_idFactura;
    
    if v_fechaVencimiento <= now() then 
		set v_estado = "VENCIDA";
    else
		set v_estado = "PENDIENTE";
    end if;
    
    update bd_factsv2.tbl_facturas set
		fechaEmision = now(),
		fechaVencimiento = date_add(now(),interval 30 day),
		cantidadProductos = v_cantidad,
		subTotalPagar = v_cantidad * v_precioVenta,
		totalISV = (v_cantidad * v_precioVenta) * 0.15,
		totalpagar = (v_cantidad * v_precioVenta) * 1.15,
		estado = v_estado,
		fechapagada = null
    where idFactura = v_idFactura;
		
    
    commit;
End;


Call bd_factsv2.SP_Registro_Producto(1000, 207, 6);

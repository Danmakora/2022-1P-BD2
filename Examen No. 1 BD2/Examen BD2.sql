/* Ejercicio No. 1*/

select Tbl2.nombrecompleto, Tbl2.idAsesor, concat(Tbl1.nombres,' ', Tbl1.apellidos) Nombres_asesores, Tbl1.numeroID
from bd_facts.tbl_asesores Tbl1
inner join bd_facts.tbl_clientes Tbl2 on Tbl1.idAsesor = Tbl2.idAsesor
order by Tbl2.idAsesor asc;

/* Ejercicio No. 2*/

select Tbl1.idCliente, Tbl1.nombrecompleto, Tbl2.idFactura, Tbl2.fechaEmision, Tbl2.fechaVencimiento
from bd_facts.tbl_clientes Tbl1
inner join bd_facts.tbl_facturas Tbl2 on Tbl1.idCliente = Tbl2.idCliente
where Tbl2.fechaVencimiento <= curdate() and Tbl2.estado = 'PENDIENTE'
order by Tbl2.fechaVencimiento asc;

/* Ejercicio No.3 */

set @v_idTipoCliente = 1;
set @v_idCiudad = 1;
set @v_idAsesor = (SELECT round(RAND()*(18-1)+1));
set @v_idCliente = 132;
set @v_idFact = 236;
set @v_nomcom = "John Doe";
set @v_cantClientes = 0;
set @v_numItems = ROUND((RAND() * (25 - 1))+ 1);

insert into bd_facts.tbl_clientes (
	idCliente, numeroID, numeroRTN, nombrecompleto, edad, fechanacimiento, direccion, fechaingreso, numeroTelefono, idTipoCliente, idCiudad, idAsesor
) values ( @v_idCliente + 1, 093547819467, null, @v_nomcom, 35, '1985-02-01', null, curdate(), null, @v_idTipoCliente, @v_idCiudad, @v_idAsesor);
        
        select last_insert_id() into @v_idAsesor;
        
insert into bd_facts.tbl_facturas ( idFactura, idCliente, tipopago, fechaEmision, fechaVencimiento, cantidadProductos,subTotalPagar, totalISV, totalpagar, estado, fechapagada ) 
	values (@v_idFact + 1, '64', 'CREDITO', curdate(), '2022-02-23 20:29:17', @v_numItems, null, null, null, null, null
);
        
select sum(cantClientes) into @v_cantClientes
from bd_facts.tbl_asesores
where idAsesor = @v_idAsesor;
    
    update bd_facts.tbl_asesores
		set cantClientes = @v_cantClientes
        where idAsesor = @v_idAsesor;
commit;
    
/*------------------------------------------------*/

set @v_idTipoCliente = 1;
set @v_idCiudad = 1;
set @v_idAsesor = 14;
set @v_idCliente = 101;
set @v_idFact = 236;
set @v_nomcom = "John Doe";
set @v_cantClientes = 0;
set @v_numItems = ROUND((RAND() * (25 - 1))+ 1);

insert into bd_facts.tbl_clientes (
	idCliente, numeroID, numeroRTN, nombrecompleto, edad, fechanacimiento, direccion, fechaingreso, numeroTelefono, idTipoCliente, idCiudad, idAsesor
) values ( @v_idCliente , 093547819467, null, @v_nomcom, 35, '1985-02-01', null, curdate(), null, @v_idTipoCliente, @v_idCiudad, @v_idAsesor);
        
        select last_insert_id() into @v_idAsesor;
        
insert into bd_facts.tbl_facturas ( idFactura, idCliente, tipopago, fechaEmision, fechaVencimiento, cantidadProductos,subTotalPagar, totalISV, totalpagar, estado, fechapagada ) 
	values (@v_idFact +1, '64', 'CREDITO', curdate(), '2022-02-23 20:29:17', @v_numItems, null, null, null, null, null
);
        
select sum(cantClientes) into @v_cantClientes
from bd_facts.tbl_asesores
where idAsesor = @v_idAsesor;
    
    update bd_facts.tbl_asesores
		set cantClientes = @v_cantClientes
        where idAsesor = @v_idAsesor;
commit;

/*-----------------------------------------------------*/
    
    set @v_idTipoCliente = 1;
set @v_idCiudad = 1;
set @v_idAsesor = 1;
set @v_idCliente = 128;
set @v_idFact = 236;
set @v_nomcom = "John Doe";
set @v_cantClientes = 0;
set @v_numItems = ROUND((RAND() * (25 - 1))+ 1);

insert into bd_facts.tbl_clientes (
	idCliente, numeroID, numeroRTN, nombrecompleto, edad, fechanacimiento, direccion, fechaingreso, numeroTelefono, idTipoCliente, idCiudad, idAsesor
) values ( @v_idCliente , 093547819467, null, @v_nomcom, 35, '1985-02-01', null, curdate(), null, @v_idTipoCliente, @v_idCiudad, @v_idAsesor);
        
        select last_insert_id() into @v_idAsesor;
        
insert into bd_facts.tbl_facturas ( idFactura, idCliente, tipopago, fechaEmision, fechaVencimiento, cantidadProductos,subTotalPagar, totalISV, totalpagar, estado, fechapagada ) 
	values (@v_idFact + 1, '64', 'CREDITO', curdate(), '2022-02-23 20:29:17', @v_numItems, null, null, null, null, null
);
        
select sum(cantClientes) into @v_cantClientes
from bd_facts.tbl_asesores
where idAsesor = @v_idAsesor;
    
    update bd_facts.tbl_asesores
		set cantClientes = @v_cantClientes
        where idAsesor = @v_idAsesor;
commit;


/* Ejercicio No.4 */
select Tbl2.nombrecompleto, Tbl2.idAsesor, concat(Tbl1.nombres,' ', Tbl1.apellidos) Nombres_asesores, Tbl1.numeroID
from bd_facts.tbl_asesores Tbl1
inner join bd_facts.tbl_clientes Tbl2 on Tbl1.idAsesor = Tbl2.idAsesor
order by Tbl2.idAsesor asc;
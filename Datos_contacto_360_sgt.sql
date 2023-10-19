select 
CASE OTPID 
when 6 then 'AUTOMOTORES'
WHEN 9 then 'TASAS COMERCIALES'
WHEN 10 THEN 'SERVICIOS GENERALES'
ELSE 'OTROS'
END tasa,
case mpgid
 when 1 then 'Tarjeta de Crédito'
 when 2 then 'Cuenta Bancaria'
 end medio_pago,
O.OJTIDENTIFICADOR OBJETO,adestado estado, 
 PSNCUIL CUIT, PSNNOMBRES denominación, PSNEMAIL EMAIL,PSNTELEFONO TELEFONO, PSNCELULAR CELULAR,
 ADFECHAALTA FECHA_ALTA_ADHESION, ADFECHABAJA FECHA_BAJA_ADHESION, ADIOBSERVACIONES OBSERVACIONES
  from debaut.adhesion ad, debaut.objeto o, sgtescobar.objetos ob, debaut.personas pe
where ob.ojtid = o.ojtidsgt
and ad.ojtid = o.ojtid
and ad.psnid = pe.psnid
and OJTIDENTIFICADOR in (select ojtidentificador from aux_ojtidentificador_debitos)
and adestado in ('ACEPTADA')
group by otpid, mpgid, O.OJTIDENTIFICADOR, adestado , 
 PSNCUIL , PSNNOMBRES , PSNEMAIL ,PSNTELEFONO , PSNCELULAR ,
 ADFECHAALTA , ADFECHABAJA , ADIOBSERVACIONES 
ORDER BY O.OJTIDENTIFICADOR 

--and to_date(ADFECHAALTA) between to_date('01-04-2020','dd-mm-yyyy') and to_date('19-07-2022','dd-mm-yyyy')
--and adestado in ('CANCELADA')
--and O.OJTIDENTIFICADOR2 = 'DA' -- para no traer planes de pago


select rowid,a.* from debaut.objeto a


select rowid,a.* from aux_identificador1_deb a


create table aux_ojtid_debitos_datos(
PSNID   VARCHAR(20)
)

select rowid,a.* from aux_ojtid_debitos_datos a

select rowid,a.* from aux_ojtid_deb_datos a

select rowid,a.* from aux_ojtidentificador_debitos a


select o.OJTIDENTIFICADOR1 objeto, p.psncuip, vpo.TVOID vinculo, p.PSNDENOMINACION apellido, p.PSNNOMBRE numero, p.PSNNUMERODOCUMENTO nro_documento, p.PSNCARACTER02 FIJO, P.PSNCARACTER04 CELULAR, P.PSNCARACTER03 CORREO, P.PSNCARACTER07 CORREO_VALIDADO, 
case o.otpid
WHEN 10 THEN 'SERVICIOS GENERALES'
WHEN 9    THEN 'TASAS COMERCIALES'
WHEN 6    THEN 'RODADOS'
ELSE 'OTRO'
end tipo_tasa 
from sgtescobar.objetos o 
    inner join sgtescobar.vinculos_persona_objeto vpo
        on vpo.ojtid = o.ojtid 
    inner join  personas p
        on p.psnid = vpo.psnid           
    where p.psnid in (select psnid from aux_ojtid_debitos_datos)
    AND VPO.TVOID = 'RESPP'
    and sgtescobar.to_null(PSNFECHAFIN) is null
    and sgtescobar.to_null(PSNFECHABAJA) is null
    and sgtescobar.to_null(VPOFECHAFIN) is null
    and sgtescobar.to_null(VPOFECHABAJA) is null
    and sgtescobar.to_null(OJTFECHAFIN) is null
    and sgtescobar.to_null(OJTFECHABAJA) is null
group by o.otpid,  o.OJTIDENTIFICADOR1,  p.psncuip, vpo.TVOID, p.PSNDENOMINACION, p.PSNNOMBRE, p.PSNNUMERODOCUMENTO, p.PSNCARACTER02 , P.PSNCARACTER04 , P.PSNCARACTER03 , P.PSNCARACTER07  
order by o.OJTIDENTIFICADOR1   

select rowid,a.* from sgtescobar.vinculos_persona_objeto a
    where ojtid in  (select ojtid from aux_ojtid_deb_datos)
    and TVOID = 'RESPP'
    and sgtescobar.to_null(vpofechafin) is null

select rowid,a.* from  sgtescobar.objetos a
    where ojtidentificador1 in (select ojtidentificador from aux_ojtidentificador_debitos)
    and sgtescobar.to_null(ojtfechafin) is null
    and sgtescobar.to_null(ojtfechabaja) is null

select rowid,a.* from personas a

select rowid,a.* from objetos o, 
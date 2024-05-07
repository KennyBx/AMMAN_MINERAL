@AbapCatalog.sqlViewName: '/SIMPLE/MLD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Ledger Document'
define view /SIMPLE/MLDOC
  as select from mlhd  as t1
    inner join   mlit  as t2 on  t1.belnr = t2.belnr
                             and t1.kjahr = t2.kjahr
                             and t2.psart = 'PC'
    inner join   mlpp as t3  on  t2.belnr = t3.belnr
                             and t2.kjahr = t3.kjahr
                             and t2.posnr = t3.posnr

{
  t1.belnr,
  t2.matnr,
  t2.bwtar,
  t2.bwkey,
  t3.budat,
  t1.cpudt, 
  t1.cputm
}

@AbapCatalog.sqlViewName: '/SIMPLE/MDPROALT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - PROCUREMENT ALTERNATIVE'
define view /SIMPLE/MDPROALTERNATIVE as select from ckmlmv001
                                inner join  ckmlmv001t on ckmlmv001.kalnr = ckmlmv001t.kalnr
{
  key ckmlmv001.kalnr  as procurementAlternative,
      werks            as plant,
      matnr            as material,
      btyp             as processCategogy,   
      ckmlmv001t.ktext as description
}

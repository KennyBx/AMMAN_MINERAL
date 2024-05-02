@AbapCatalog.sqlViewName: '/SIMPLE/MDAMN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Asset Number'
define view /SIMPLE/MDASSETNUMBER
  as select from    anla
    left outer join anlz on  anla.bukrs = anlz.bukrs
                         and anla.anln1 = anlz.anln1
                         and anla.anln2 = anlz.anln2
{
  key anla.bukrs as companyCode,
  key anla.anln1 as assetNumber,
  key anla.anln2 as subnumber,
      anla.anlkl as assetClass,
      anla.aktiv as capDate,
      anlz.kostl as costCenter,
      anla.spras as locale,
      anla.txt50 as description
}

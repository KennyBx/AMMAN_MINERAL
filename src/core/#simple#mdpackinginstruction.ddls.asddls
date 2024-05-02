@AbapCatalog.sqlViewName: '/SIMPLE/MDPI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDpackingInstruction'
define view /SIMPLE/MDPACKINGINSTRUCTION
  as select distinct from packkp
    left outer join       packpo  on  packkp.packnr   = packpo.packnr
                                 and packpo.packitem   = '000010'                                  
    left outer join       packkps on packkps.packnr = packpo.packnr
{
  key  packkp.pobjid   as packingInstructionNumber,
  key  packkps.spras   as locale,
       packkps.content as packingInstructionText,
       packkp.inddel   as deletionIndicator,
       packpo.matnr    as productNumber
}
where packpo.paitemtype = 'P'
 
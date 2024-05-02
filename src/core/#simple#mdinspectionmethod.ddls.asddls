@AbapCatalog.sqlViewName: '/SIMPLE/MDIM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Inspection Method'
define view /SIMPLE/MDINSPECTIONMETHOD as select from qmtb as head 
inner join qmtt as item on head.werks    = item.werks
                        and head.pmtnr   = item.pmtnr
                        and head.version = item.version
{
    key  head.werks         as Plant,
    key  head.pmtnr         as InspectionMEthod,
    key  head.version       as Version,
         head.gueltigab     as ValidFrom,
         sortfeld      as SearchField,
         item.kurztext as ShortField,
         loekz         as Status
         
}

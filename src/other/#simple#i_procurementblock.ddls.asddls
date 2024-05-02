@AbapCatalog: {
    sqlViewName: '/SIMPLE/IPRCBL',
    preserveKey: true,
    compiler.compareFilter: true
}
@EndUserText.label: 'Procurement Block'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM: {
    viewType: #BASIC,
    lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@ObjectModel: {
    representativeKey: 'ProcurementBlock',
    usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
}
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_ProcurementBlock
  as select from tq04a

//  association [1..*] to /SIMPLE/I_ProcurementBlockText as _ProcurementBlockText on $projection.ProcurementBlock = _ProcurementBlockText.ProcurementBlock

{
  key tq04a.sperrfkt as ProcurementBlock
      //  tq04a.bestellung   as ProcmtBlockPurOrdIsBlocked,
      //  tq04a.anfrage      as ProcmtBlockQtanReqIsBlocked,
      //  tq04a.bzgquelle    as ProcmtBlockSourceDetnIsBlocked,
      //  tq04a.wesperr      as ProcmtBlockGoodsRcptIsBlocked,

      /* Associations */
//      _ProcurementBlockText
}

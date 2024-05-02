@AbapCatalog.sqlViewName: '/SIMPLE/MDWBSE'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDWBSElement'
define view /SIMPLE/MDWBSElement
  as select from prps
{
  key cast ( prps.pspnr as ps_s4_pspnr preserving type )        as wbsElementInternalID,
      cast( prps.posid   as /simple/ps_posid  preserving type ) as wbsElement,
      cast ( prps.post1 as ps_s4_post1 preserving type )        as wbsDescription,
      cast ( prps.pbukr as bukrs preserving type )              as companyCode,
      poski                                                     as shortID
}

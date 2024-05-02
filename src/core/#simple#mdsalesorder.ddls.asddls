@AbapCatalog.sqlViewName: '/SIMPLE/MDSO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDRequestingOrder'
define view /SIMPLE/MDSalesOrder
  as select from vbak
    join         vbkd as vbkd on  vbak.vbeln = vbkd.vbeln
                              and vbkd.posnr = '000000'
{
  key  vbak.vbeln as salesDocument,
       vbak.vkorg as salesOrganization,
       vbak.kunnr as soldToParty,
       vbak.vtweg as distributionChannel,
       vbak.spart as organizationDivision,
       vbak.vkbur as salesOffice,
       vbak.vkgrp as salesGroup,
       vbak.ernam as createdByUser,
       vbak.auart as salesDocumentType,
       vbkd.bstkd as customerReference,
       vbkd.bstdk as customerReferenceDate
}

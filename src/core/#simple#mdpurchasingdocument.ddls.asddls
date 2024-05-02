@AbapCatalog.sqlViewName: '/SIMPLE/MDPUDOC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Purchasing Document'
define view /SIMPLE/MDPURCHASINGDOCUMENT
  as select from ekko
{
  key ebeln as purchasingDocument,
      ekorg as purchasingOrg,
      ekgrp as purchasingGroup,
      bedat as documentDate,
      bstyp as purchasingDocumentCategory,     //Flynn - insert++ 20240325 - JLR575
      bsart as purchasingDocumentType          //Flynn - insert++ 20240325 - JLR575
}

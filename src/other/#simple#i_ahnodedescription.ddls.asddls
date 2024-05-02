@AbapCatalog.sqlViewName: '/SIMPLE/IAHND'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Node Description'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHNODEDESCRIPTION
  as select from wrf_matgrp_strct
{
  key hier_id,
  key node,
  key spras,
      ltext,
      ltextg,
      ltextlg
}

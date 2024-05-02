@AbapCatalog.sqlViewName: '/SIMPLE/IAHNSKU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Node Assignments'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHNODESKU
  as select from wrf_matgrp_sku
{
  key  hier_id,
  key  matnr,
  key  node,
  key  date_from,
       date_to,
       mainflg,
       strategy
}

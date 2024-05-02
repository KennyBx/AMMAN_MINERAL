@AbapCatalog.sqlViewName: '/SIMPLE/IAHN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Node'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHNODE
  as select from    wrf_matgrp_struc as struc
    left outer join wrf_matgrp_treet as text on text.tree_level = struc.tree_level //SSPD-2541 - 20240315 - Danh Tran - Ins
{
  key hier_id,
  key node,
  key date_from,
      date_to,
      struc.tree_level,
      text.level_text, //SSPD-2541 - 20240315 - Danh Tran - Ins
      parent,
      catflg,
      role,
      strategy,
      productclf,
      price_group,
      reference,
      responsibility
}
where text.spras = 'E'

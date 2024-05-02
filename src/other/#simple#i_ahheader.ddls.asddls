@AbapCatalog.sqlViewName: '/SIMPLE/IAHD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Header'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHHEADER
  as select from wrf_matgrp_hier
  association [0..*] to /SIMPLE/I_AHNODE as _ArticleHierarchyNode on $projection.hier_id = _ArticleHierarchyNode.hier_id
{
  key hier_id,
      node,
      vkorg,
      vtweg,
      status,
      prodflg,
      bwflg,
      hierflg,
      mltpflg,
      dateflg,
      ersda,
      laeda,
      laend,

      /*Association*/
      _ArticleHierarchyNode
}

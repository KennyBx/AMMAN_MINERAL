@AbapCatalog.sqlViewName: '/SIMPLE/IAHDD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Article Hieararchy Header Description'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_AHHDESCRIPTION
  as select from wrf_matgrp_hiert

  association [0..1] to /SIMPLE/I_Language as _Language on $projection.spras = _Language.Language
{
  key hier_id,
  key spras,
      ltext,

      /*Association*/
      _Language
}

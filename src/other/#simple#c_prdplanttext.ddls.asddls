@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPLT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantText'
define view /SIMPLE/C_PrdPlantText
  as select from /SIMPLE/I_PrdPlantTextContent
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant
{

  key Product                        as product, 
  key Plant                          as plant,
      // key Language,
      //LongTextID,
//      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:/SIMPLE/CL_PRDLONGTEXT'
      LongText                       as longText,
      // LanguageISOCode,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      /* Associations */
      _Plant,
      @Consumption.hidden: true
      clustr,
      @Consumption.hidden: true
      clustd
}

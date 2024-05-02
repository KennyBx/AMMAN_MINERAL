@AbapCatalog.sqlViewName: '/SIMPLE/CPPRT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ProductProductionTool'
define view /SIMPLE/C_PrdPRT
  as select from crvm_b as t1
    inner join   crfh   as t2 on  t1.objty = t2.objty
                              and t1.objid = t2.objid
  association to parent /SIMPLE/C_ProductPlant as _ProductPlant on  _ProductPlant.product = $projection.product
                                                                and _ProductPlant.plant   = $projection.plant

{
  key t1.matnr                       as product,
  key t1.werks                       as plant,
      t2.planv                       as prtUsage,
      t2.fgru1                       as groupingKey1,
      t2.fgru2                       as groupingKey2,
      t2.steuf                       as prtControlProfile,
      t2.steuf_ref                   as referIndPRTControlProfile,
      t2.ktsch                       as standardTextKey,
      t2.ktsch_ref                   as referIndStandardTextKey,
      t2.mgform                      as quantityFormula,
      t2.mgform_ref                  as referIndQuantityFormula,
      t2.ewform                      as usageValueFormula,
      t2.ewform_ref                  as referIndUsageValueFormula,
      t2.bzoffb                      as refDateForStart,
      t2.bzoffb_ref                  as refIndRefDateForStart,
      t2.offstb                      as offsetToStart,
      t2.ehoffb                      as startOffsetUnit,
      t2.offstb_ref                  as refIndOffsetToStart,
      t2.bzoffe                      as refDateForFinish,
      t2.bzoffe_ref                  as refIndrefDateForFinish,
      t2.offste                      as offsetToFinish,
      t2.ehoffe                      as offsetEndUnit,
      t2.offste_ref                  as refIndOffsetToEnd,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      _ProductPlant

}

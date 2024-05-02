@AbapCatalog: {
  sqlViewName: '/SIMPLE/IMTRL',
  preserveKey: true
 }
@Analytics: { dataCategory: #DIMENSION }
@VDM.viewType: #BASIC
@EndUserText.label: 'Material'
@ObjectModel.representativeKey: 'Material'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #M
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions:true

define view /SIMPLE/I_Material
  as select from mara
//  association [0..*] to /SIMPLE/I_MaterialText  as _Text          on $projection.Material = _Text.Material
//  association [0..1] to /SIMPLE/I_MaterialType  as _MaterialType  on $projection.MaterialType = _MaterialType.MaterialType
//  association [0..1] to /SIMPLE/I_MaterialGroup as _MaterialGroup on $projection.MaterialGroup = _MaterialGroup.MaterialGroup
//  association [0..1] to /SIMPLE/I_UnitOfMeasure as _BaseUnit      on $projection.MaterialBaseUnit = _BaseUnit.UnitOfMeasure
//  association [0..1] to /SIMPLE/I_UnitOfMeasure as _WeightUnit    on $projection.MaterialWeightUnit = _WeightUnit.UnitOfMeasure
//  association [0..*] to /SIMPLE/I_MaterialPlant as _MaterialPlant on $projection.Material = _MaterialPlant.Material
{
      --@EndUserText.label: 'Material'
//      @Search.defaultSearchElement: true
//      @Search.fuzzinessThreshold: 0.8
//      @ObjectModel.text.association: '_Text'
  key mara.matnr  as Material,
//      _Text,

      --@EndUserText.label: 'Material Type'
      mara.mtart  as MaterialType,
//      _MaterialType,

      --@EndUserText.label: 'Material Group'
      mara.matkl  as MaterialGroup,
//      _MaterialGroup,

      --@EndUserText.label: 'Base Unit of Measure'
//      @Semantics.unitOfMeasure: true
//      @ObjectModel.foreignKey.association: '_BaseUnit'
      mara.meins  as MaterialBaseUnit,
//      _BaseUnit,

      --@EndUserText.label: 'Gross Weight'
//      @Semantics.quantity.unitOfMeasure: 'MaterialWeightUnit'
//      @Analytics.hidden: true
      mara.brgew  as MaterialGrossWeight,

      --@EndUserText.label: 'Net Weight'
//      @Semantics.quantity.unitOfMeasure: 'MaterialWeightUnit'
//      @Analytics.hidden: true
      mara.ntgew  as MaterialNetWeight,

      --@EndUserText.label: 'Weight Unit'
//      @Semantics.unitOfMeasure: true
//      @ObjectModel.foreignKey.association: '_WeightUnit'
      mara.gewei  as MaterialWeightUnit,
//      _WeightUnit,

      mara.mfrnr  as MaterialManufacturerNumber,
      mara.mfrpn  as MaterialManufacturerPartNumber,
      mara.begru  as AuthorizationGroup,
      mara.xchpf  as IsBatchManagementRequired,
      mara.groes  as SizeDimension 
//      _MaterialPlant
}

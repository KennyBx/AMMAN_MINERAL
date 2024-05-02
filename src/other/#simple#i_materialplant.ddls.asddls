@AbapCatalog: {
  sqlViewName: '/SIMPLE/IMATPL',
  preserveKey: true
}
@Analytics: { dataCategory: #DIMENSION }
@VDM.viewType: #BASIC
@EndUserText.label: 'Material Plant'
@ObjectModel.representativeKey: 'Plant'
@Search.searchable: true
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

@AccessControl: {
    authorizationCheck: #CHECK,
    privilegedAssociations: '_MRPController'
}
@Metadata.allowExtensions:true


define view /SIMPLE/I_MaterialPlant
  as select from marc
//  association [1..1] to /SIMPLE/I_Material                  as _Material                      on  $projection.Material = _Material.Material
//  association [0..1] to /SIMPLE/I_MRPController             as _MRPController                 on  $projection.Plant         = _MRPController.Plant
//                                                                                      and $projection.MRPController = _MRPController.MRPController
//  association [0..*] to /SIMPLE/I_MaterialText              as _MaterialText                  on  $projection.Material = _MaterialText.Material
//  association [0..1] to /SIMPLE/I_Matlabcclassif            as _MaterialABCClassification     on  $projection.MaterialABCClassification = _MaterialABCClassification.MaterialABCClassification
//
//  association [0..*] to /SIMPLE/I_Matlabcclassiftext        as _MaterialABCClassificationDesc on  $projection.MaterialABCClassification = _MaterialABCClassificationDesc.MaterialABCClassification

{
//      //--[ GENERATED:012:GFBfhxvv7jY4jTYbPy8kum
//      @Consumption.valueHelpDefinition: [
//        { entity:  { name:    'I_MaterialStdVH',
//                     element: 'Material' }
//        }]
//      // ]--GENERATED
//      @ObjectModel.foreignKey.association: '_Material'
//      @ObjectModel.text.association: '_MaterialText'
  key marc.matnr as Material,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key marc.werks as Plant,

      dispo      as MRPController,
      eisbe      as MaterialSafetyStockQty,
      lgfsb      as DfltStorLocForExtProcmt,

      //ABC Classification
//      @ObjectModel.foreignKey.association: '_MaterialABCClassification'
      maabc      as MaterialABCClassification,
      marc.schgt as BulkMaterialIndMaterial
//      _MaterialABCClassification,
//      _MRPController,
//      _MaterialText,
//      _MaterialABCClassificationDesc,
//      _Material

}

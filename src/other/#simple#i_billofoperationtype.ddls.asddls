@AbapCatalog.sqlViewName: '/SIMPLE/IBOOTYPE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.representativeKey: 'BillOfOperationsType'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Bill of Operations Type'

define view /SIMPLE/I_BillOfOperationType
  as select from tca01

//  association [0..*] to /SIMPLE/I_BOOTypeText     as _Text                        on $projection.BillOfOperationsType = _Text.BillOfOperationsType
//  association [0..1] to /SIMPLE/I_BOOApplication  as _BillOfOperationsApplication on $projection.BillOfOperationsApplication = _BillOfOperationsApplication.BillOfOperationsApplication

{
//      @ObjectModel.text.association: '_Text'
  key cast(plnty as billofoperationstype preserving type)        as BillOfOperationsType,
//      @ObjectModel.foreignKey.association: '_BillOfOperationsApplication'
      cast(plnaw as billofoperationsapplication preserving type) as BillOfOperationsApplication

//      // Associations
//      _Text,
//      _BillOfOperationsApplication
}; 

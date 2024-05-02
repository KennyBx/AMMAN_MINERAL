@AbapCatalog.sqlViewName: '/SIMPLE/IUOMTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Unit of Measure Text'

@VDM.viewType: #BASIC 

@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.representativeKey: 'UnitOfMeasure'

@Analytics.internalName: #LOCAL
@Analytics.dataExtraction.enabled: true

define view /SIMPLE/I_UnitOfMeasureText 
  as select from t006a
   
    association [0..1] to /SIMPLE/I_UnitOfMeasure as _UnitOfMeasure
        on  $projection.UnitOfMeasure = _UnitOfMeasure.UnitOfMeasure
    association [0..1] to /SIMPLE/I_Language as _Language
        on $projection.Language = _Language.Language 
             
 {
    @Semantics.language: true
    @ObjectModel.foreignKey.association: '_Language'
    key spras as Language,
//    _Language,
    
    @Semantics.unitOfMeasure: true
    @ObjectModel.foreignKey.association: '_UnitOfMeasure'
    key msehi as UnitOfMeasure,
//    _UnitOfMeasure,
       
    @Semantics.text: true
    msehl as UnitOfMeasureLongName,

    @Semantics.text: true
    mseht as UnitOfMeasureName,

    @Semantics.text: true
    mseh6 as UnitOfMeasureTechnicalName,    
           
    mseh3 as UnitOfMeasure_E,       
    
    @Semantics.text: true
    mseh3 as UnitOfMeasureCommercialName,
    
    _UnitOfMeasure,
    _Language
    
}  

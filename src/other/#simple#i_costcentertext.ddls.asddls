@EndUserText.label: 'Cost Center Text'
@Analytics: {dataExtraction.enabled: true}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFICSTCT'
@AccessControl.authorizationCheck: #CHECK //NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'CostCenter'
@AbapCatalog.preserveKey:true
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@Metadata.ignorePropagatedAnnotations: true

@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {
  dataClass: #MASTER,
  serviceQuality: #A,
  sizeCategory: #M
}
@Search.searchable: true
//--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
@AccessControl.privilegedAssociations: ['_ControllingAreaText']
// ]--GENERATED
@Consumption.filter.businessDate.at: true

define view /SIMPLE/I_CostCenterText as select from cskt inner join csks as _md on cskt.kostl = _md.kostl and
                                                                           cskt.kokrs = _md.kokrs and
                                                                           cskt.datbi = _md.datbi


  //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
  association [0..1] to I_ControllingArea      as _ControllingAreaText on   $projection.ControllingArea = _ControllingAreaText.ControllingArea
  // ]--GENERATED
  association[0..1] to I_ControllingArea as _ControllingArea on $projection.ControllingArea   = _ControllingArea.ControllingArea
association[0..1] to I_Language as _Language on $projection.Language = _Language.Language

{ 
  key cskt.kostl as CostCenter,

//      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_ControllingAreaStdVH',
//                     element: 'ControllingArea' }
//        }]
//      @ObjectModel.text.association: '_ControllingAreaText'
//      // ]--GENERATED
  @ObjectModel.foreignKey.association: '_ControllingArea'
  key cskt.kokrs as ControllingArea,

  @Semantics.language: true
  @ObjectModel.foreignKey.association: '_Language'
  key cskt.spras as Language,

  @Semantics.businessDate.to: true
  key cskt.datbi as ValidityEndDate,

 @Semantics.businessDate.from: true
  datab as ValidityStartDate,

  @Semantics.text: true
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  cast(ktext as fis_kostl_name preserving type) as CostCenterName,

  @Semantics.text: true
  cast(ltext as fis_kostl_ltext preserving type) as CostCenterDescription,

  _ControllingArea,
  _Language,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.hidden: true
      _ControllingAreaText
      // ]--GENERATED

  
}  

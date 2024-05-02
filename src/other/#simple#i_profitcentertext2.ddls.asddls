@EndUserText.label: 'Profit Center Text'
@Analytics.dataExtraction.enabled: true 
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIPCTRT'
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK //NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ProfitCenter'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {
  dataClass: #MASTER,
  serviceQuality: #A,
  sizeCategory: #M
}

@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true
//--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
@AccessControl.privilegedAssociations: ['_ControllingAreaText']
// ]--GENERATED
@Consumption.filter.businessDate.at: true

define view /SIMPLE/I_ProfitCenterText2 as select from cepct inner join cepc as _md on cepct.prctr = _md.prctr and
                                                                              cepct.kokrs = _md.kokrs and
                                                                              cepct.datbi = _md.datbi

  
  //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
  association [0..1] to I_ControllingArea      as _ControllingAreaText on   $projection.ControllingArea = _ControllingAreaText.ControllingArea
  // ]--GENERATED
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
  association [0..1] to I_ControllingArea as _ControllingArea  on $projection.ControllingArea   = _ControllingArea.ControllingArea

{
  @Semantics.language
  @ObjectModel.foreignKey.association: '_Language'
  key cepct.spras as Language,
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ControllingArea',
                     element: 'ControllingArea' }
        }]
      @ObjectModel.text.association: '_ControllingAreaText'
      // ]--GENERATED
  @ObjectModel.foreignKey.association: '_ControllingArea'
  key cepct.kokrs  as ControllingArea,
  key cepct.prctr as ProfitCenter,
  @Semantics.businessDate.to: true
  key cepct.datbi as ValidityEndDate,
  
  @Semantics.businessDate.from: true
  datab as ValidityStartDate,
  
  @Semantics.text
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  cast (ktext as fis_prctr_shorttext preserving type) as ProfitCenterName,
  @Semantics.text
  ltext as ProfitCenterLongName,
  
  _ControllingArea,
  _Language ,
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.hidden: true
      _ControllingAreaText
      // ]--GENERATED

};

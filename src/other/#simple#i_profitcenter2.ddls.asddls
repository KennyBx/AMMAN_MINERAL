@EndUserText.label: 'Profit Center'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIPCTR'
@AbapCatalog.preserveKey:true

@AccessControl.authorizationCheck: #CHECK 
@AccessControl.privilegedAssociations:  [ '_ProfitCenterHierarchyNode'
//--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
,'_ControllingAreaText','_SegmentText'
// ]--GENERATED
]
@Metadata.allowExtensions: true
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ProfitCenter'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: {
  dataClass: #MASTER,
  serviceQuality: #A,
  sizeCategory: #M
}

@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}

@Search.searchable: true
@Consumption.filter.businessDate.at: true
define view /SIMPLE/I_ProfitCenter2  as select distinct from cepc


  //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
  association [1..1] to I_ControllingArea      as _ControllingAreaText on   $projection.ControllingArea = _ControllingAreaText.ControllingArea
  association [0..*] to I_SegmentText      as _SegmentText on   $projection.Segment = _SegmentText.Segment
  // ]--GENERATED
  association[1..1] to I_ControllingArea           as _ControllingArea           on $projection.ControllingArea   = _ControllingArea.ControllingArea
association[0..*] to /SIMPLE/I_ProfitCenterText2          as _Text                      on $projection.ControllingArea   = _Text.ControllingArea and
                                                                                  $projection.ProfitCenter      = _Text.ProfitCenter and
                                                                                  $projection.ValidityEndDate   = _Text.ValidityEndDate
association[0..*] to I_ProfitCenterHierarchyNode as _ProfitCenterHierarchyNode on $projection.ControllingArea   = _ProfitCenterHierarchyNode.ControllingArea and
                                                                                  $projection.ProfitCenter      = _ProfitCenterHierarchyNode.ProfitCenter
association[0..1] to I_Country                   as _Country                   on $projection.Country           = _Country.Country
association[0..1] to I_CompanyCode               as _Company                   on $projection.CompanyCode       = _Company.CompanyCode
association[0..1] to I_Segment                   as _Segment                   on $projection.Segment           = _Segment.Segment
association[0..1] to I_Region                    as _Region                    on $projection.Country           = _Region.Country and
                                                                                  $projection.Region            = _Region.Region
//association[0..*] to I_TaxJurisdiction           as _TaxJurisdiction           on $projection.TaxJurisdiction   = _TaxJurisdiction.TaxJurisdiction
association[0..1] to I_Language                  as _Language                  on $projection.Language = _Language.Language
association[1..1] to E_ProfitCenter               as _Extension               on  $projection.ControllingArea    = _Extension.ControllingArea
                                                                              and  $projection.ProfitCenter      = _Extension.ProfitCenter
                                                                              and  $projection.ValidityEndDate   = _Extension.ValidityEndDate

{ 
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ControllingArea',
                     element: 'ControllingArea' }
        }]
      @ObjectModel.text.association: '_ControllingAreaText'
      // ]--GENERATED
  @ObjectModel.foreignKey.association: '_ControllingArea'
  key kokrs  as ControllingArea,
  @ObjectModel.text.association: '_Text'
  @ObjectModel.Hierarchy.association: '_ProfitCenterHierarchyNode'
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  key prctr  as ProfitCenter,
  
 @Semantics.businessDate.to: true
  key datbi  as      ValidityEndDate,  
  verak as          ProfitCtrResponsiblePersonName,
  bukrs as          CompanyCode,
  verak_user as     ProfitCtrResponsibleUser,
  @Semantics.businessDate.from: true
  datab as          ValidityStartDate,
  abtei as          Department,
  khinr as          ProfitCenterStandardHierarchy,
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_SegmentStdVH',
                     element: 'Segment' }
        }]
      @ObjectModel.text.association: '_SegmentText'
      // ]--GENERATED
@ObjectModel.foreignKey.association: '_Segment' //Inserted by VDM CDS Suite Plugin
  segment as        Segment,
  lock_ind as       ProfitCenterIsBlocked,
  pca_template as   FormulaPlanningTemplate,
  anred as          FormOfAddress,
  name1 as          AddressName,
  name2 as          AdditionalName,
  name3 as          ProfitCenterAddrName3,
  name4 as          ProfitCenterAddrName4,
  stras as          StreetAddressName,
  pfach as          POBox,
  ort01 as          CityName,
  pstlz as          PostalCode,
  ort02 as          District,
@ObjectModel.foreignKey.association: '_Country' //Inserted by VDM CDS Suite Plugin
  land1 as          Country,
@ObjectModel.foreignKey.association: '_Region'
  regio as          Region,
  txjcd as          TaxJurisdiction,
  @Semantics.language:true
@ObjectModel.foreignKey.association: '_Language' //Inserted by VDM CDS Suite Plugin
  spras as          Language,
  telf1 as          PhoneNumber1,
  telf2 as          PhoneNumber2,
  telbx as          TeleboxNumber,
  telx1 as          TelexNumber,
  telfx as          FaxNumber,
  datlt as          DataCommunicationPhoneNumber,
  drnam as          ProfitCenterPrinterName,
  usnam as          ProfitCenterCreatedByUser,
  ersda as          ProfitCenterCreationDate,
  
  _Text,
  _Country, 
  _ControllingArea,
  _ProfitCenterHierarchyNode,
  _Language,
  _Company,
  _Segment,
  _Region,
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.hidden: true
      _ControllingAreaText,
      @Consumption.hidden: true
      _SegmentText
      // ]--GENERATED

   //_TaxJurisdiction
} 

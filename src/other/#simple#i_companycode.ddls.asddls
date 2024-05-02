@EndUserText.label: 'Company Code'

@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
            mapping:
            [ { table: 'T001', 
                role: #MAIN,
                viewElement: ['CompanyCode'],
                tableElement: ['bukrs']
              },
              { table: 'tka02', 
                role: #LEFT_OUTER_TO_ONE_JOIN,
                viewElement: ['CompanyCode'],
                tableElement: ['bukrs']
              }
            ]
        }
    }
}

@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/ICOMCD'
@AbapCatalog.preserveKey:true
// BEN @ObjectModel.representativeKey: 'CompanyCode'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.buffering.status: #NOT_ALLOWED
// BEN @ObjectModel.usageType.sizeCategory: #S
// BEN @ObjectModel.usageType.dataClass:  #ORGANIZATIONAL
// BEN @ObjectModel.usageType.serviceQuality: #A
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true

//--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//@AccessControl.privilegedAssociations: ['_ChartOfAccountsText','_CountryChartOfAccountsText']
// ]--GENERATED

@AccessControl.privilegedAssociations: ['_Address']

define view /SIMPLE/I_CompanyCode 
  as select from           t001
    left outer to one join tka02 on tka02.bukrs = t001.bukrs
//  
//  //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//  association [0..*] to /SIMPLE/I_ChartOfAccountsText      as _ChartOfAccountsText on   $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
//  association [0..*] to /SIMPLE/I_ChartOfAccountsText      as _CountryChartOfAccountsText on   $projection.CountryChartOfAccounts = _CountryChartOfAccountsText.ChartOfAccounts
//  association [0..1] to /SIMPLE/I_ControllingArea      as _ControllingAreaText on   $projection.ControllingArea = _ControllingAreaText.ControllingArea
//  association [0..*] to /SIMPLE/I_CreditCtlAreaText      as _CreditControlAreaText on   $projection.CreditControlArea = _CreditControlAreaText.CreditControlArea
//  // ]--GENERATED
//  association [0..1] to /SIMPLE/I_Currency            as _Currency               on $projection.Currency = _Currency.Currency
//  association [0..1] to /SIMPLE/I_Country             as _Country                on $projection.Country = _Country.Country
//  association [0..1] to /SIMPLE/I_Address             as _Address                on $projection.AddressID = _Address.AddressID
//  association [0..1] to /SIMPLE/I_Language            as _Language               on $projection.Language = _Language.Language
//  association [0..1] to /SIMPLE/I_ChartOfAccounts     as _ChartOfAccounts        on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts
//  association [0..1] to /SIMPLE/I_FiscalYearVariant   as _FiscalYearVariant      on $projection.FiscalYearVariant = _FiscalYearVariant.FiscalYearVariant
//  association [0..1] to /SIMPLE/I_ChartOfAccounts     as _CountryChartOfAccounts on $projection.CountryChartOfAccounts = _CountryChartOfAccounts.ChartOfAccounts
//  association [0..1] to /SIMPLE/I_ControllingArea     as _ControllingArea        on $projection.ControllingArea = _ControllingArea.ControllingArea
//  association [0..1] to /SIMPLE/I_CreditControlArea   as _CreditControlArea      on $projection.CreditControlArea = _CreditControlArea.CreditControlArea
//  association [0..1] to /SIMPLE/I_FieldStatusVariant  as _FieldStatusVariant     on $projection.FieldStatusVariant = _FieldStatusVariant.FieldStatusVariant
//  association [0..1] to /SIMPLE/I_Globalcompany       as _GlobalCompany          on $projection.Company = _GlobalCompany.Company
//  association [0..*] to /SIMPLE/I_CompanyCodeHierNode as _CompanyCodeHierNode    on $projection.CompanyCode = _CompanyCodeHierNode.CompanyCode
{
      // BEN @ObjectModel.text.element: 'CompanyCodeName'
      // BEN @ObjectModel.hierarchy.association: '_CompanyCodeHierNode'
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold:0.8
      @Search.ranking:#HIGH
  key t001.bukrs    as CompanyCode,
      @Semantics.text
      t001.butxt    as CompanyCodeName,
      t001.ort01    as CityName,
      // BEN @ObjectModel.foreignKey.association: '_Country'
      t001.land1    as Country,
      // BEN @ObjectModel.foreignKey.association: '_Currency'
      t001.waers    as Currency,
      // BEN @ObjectModel.foreignKey.association: '_Language'
      t001.spras    as Language,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_ChartOfAccountsStdVH',
//                     element: 'ChartOfAccounts' }
//        }]
//      // BEN @ObjectModel.text.association: '_ChartOfAccountsText'
//      // ]--GENERATED
//      // BEN @ObjectModel.foreignKey.association: '_ChartOfAccounts'
      t001.ktopl    as ChartOfAccounts,
      // BEN @ObjectModel.foreignKey.association: '_FiscalYearVariant'
      t001.periv    as FiscalYearVariant,
      t001.rcomp    as Company,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_CreditControlAreaStdVH',
                     element: 'CreditControlArea' }
        }]
      // BEN @ObjectModel.text.association: '_CreditControlAreaText'
      // ]--GENERATED
      // BEN @ObjectModel.foreignKey.association: '_CreditControlArea'
      t001.kkber    as CreditControlArea,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_ChartOfAccountsStdVH',
//                     element: 'ChartOfAccounts' }
//        }]
//      // BEN @ObjectModel.text.association: '_CountryChartOfAccountsText'
//      // ]--GENERATED
//      // BEN @ObjectModel.foreignKey.association: '_CountryChartOfAccounts'
      t001.ktop2    as CountryChartOfAccounts,
      t001.fikrs    as FinancialManagementArea,
      // BEN @ObjectModel.foreignKey.association: '_Address'
      t001.adrnr    as AddressID,
      t001.umkrs    as TaxableEntity,
      t001.stceg    as VATRegistration,
      t001.wt_newwt as ExtendedWhldgTaxIsActive,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ControllingAreaStdVH',
                     element: 'ControllingArea' }
        }]
      // BEN @ObjectModel.text.association: '_ControllingAreaText'
      // ]--GENERATED
      // BEN @ObjectModel.foreignKey.association: '_ControllingArea'
      tka02.kokrs   as ControllingArea,
      // BEN @ObjectModel.foreignKey.association: '_FieldStatusVariant'
      t001.fstva    as FieldStatusVariant,
      t001.mwska    as NonTaxableTransactionTaxCode,
      t001.xstdt    as DocDateIsUsedForTaxDetn,
      t001.xvatdate as TaxRptgDateIsActive
//      _Currency,
//      _Country,
//      _Address,
//      _Language,
//      _ChartOfAccounts,
//      _CountryChartOfAccounts,
//      _FiscalYearVariant,
//      _ControllingArea,
//      _CreditControlArea,
//      _FieldStatusVariant,
//      _GlobalCompany,
//      _CompanyCodeHierNode,
//      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//      @Consumption.hidden: true
//      _ChartOfAccountsText,
//      @Consumption.hidden: true
//      _CountryChartOfAccountsText,
//      @Consumption.hidden: true
//      _ControllingAreaText,
//      @Consumption.hidden: true
//      _CreditControlAreaText
//      // ]--GENERATED

};

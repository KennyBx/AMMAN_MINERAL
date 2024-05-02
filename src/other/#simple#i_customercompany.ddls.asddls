@EndUserText.label: 'Customer Company' //same as DDL description
@Analytics: { dataCategory: #FACT }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/ICUSCPN' //must start with "I"
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey:'CompanyCode'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.personalData.blocking: #REQUIRED
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_CustomerCompany //must start with "I_"; same as DDL source name in upper-camelcase notation
  as select from knb1

  association [1..1] to /SIMPLE/I_Customer        as _Customer               on  $projection.Customer = _Customer.Customer

//  association [0..1] to /SIMPLE/I_CompanyCode     as _CompanyCode            on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..*] to /SIMPLE/I_CustomerDunning as _CustomerDunning        on  $projection.Customer    = _CustomerDunning.Customer
                                                                     and $projection.CompanyCode = _CustomerDunning.CompanyCode

  //Default dunning area
  association [0..1] to /SIMPLE/I_CustomerDunning as _CustomerDefaultDunning on  $projection.Customer                = _CustomerDefaultDunning.Customer
                                                                     and $projection.CompanyCode             = _CustomerDefaultDunning.CompanyCode
                                                                     and _CustomerDefaultDunning.DunningArea = ''

//  association [0..*] to I_BusinessPartnerCustWhdgTax as _CustomerWhdgTax        on  $projection.Customer    = _CustomerWhdgTax.Customer
//                                                                     and $projection.CompanyCode = _CustomerWhdgTax.CompanyCode

  // Associations added for Text Annotation Removal
//  association [0..1] to /SIMPLE/I_PmntBlockingReason   as _PaymentBlockValueHelp     on  $projection.PaymentBlockingReason = _PaymentBlockValueHelp.PaymentBlockingReason
//
//  association [0..*] to /SIMPLE/I_PmntBlckngReasonText as _PaymentBlockingReasonText on $projection.PaymentBlockingReason = _PaymentBlockingReasonText.PaymentBlockingReason

{

//      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_Customer_VH',
//                     element: 'Customer' }
//        }]
//      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Customer'
  key kunnr                            as Customer,
//      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_CompanyCodeStdVH',
//                     element: 'CompanyCode' }
//        }]
//      // ]--GENERATED
       @ObjectModel.foreignKey.association: '_CompanyCode'
  key bukrs                            as CompanyCode,
      //@ObjectModel.foreignKey.association: '_CustomerDunning'
      //key _CustomerDunning.DunningArea,

      busab                            as AccountingClerk,
      akont                            as ReconciliationAccount,
      begru                            as AuthorizationGroup,
      knrze                            as CustomerHeadOffice,
      knrzb                            as AlternativePayerAccount,
      @ObjectModel: {
               foreignKey.association: '_PaymentBlockValueHelp'
             }
      @ObjectModel.text.association: '_PaymentBlockingReasonText'
      zahls                            as PaymentBlockingReason,
      vzskz                            as InterestCalculationCode,
      zindt                            as InterestCalculationDate,
      zinrt                            as IntrstCalcFrequencyInMonths,
      kverm                            as CustomerAccountNote,
      togru                            as APARToleranceGroup,
      hbkid                            as HouseBank,
      xpore                            as ItemIsToBePaidSeparately,
      xedip                            as PaytAdviceIsSentbyEDI,

      //Following Fields are needed in BP Customer-Supplier App

      sperr                            as PhysicalInventoryBlockInd,
      zsabe                            as UserAtCustomer,
      tlfns                            as AccountingClerkPhoneNumber,
      tlfxs                            as AccountingClerkFaxNumber,
      intad                            as AccountingClerkInternetAddress,
      eikto                            as AccountByCustomer,
      xdezv                            as IsToBeLocallyProcessed,
      perkz                            as CollectiveInvoiceVariant,
      zuawa                            as LayoutSortingRule,
      zterm                            as PaymentTerms,
      xverr                            as CustomerSupplierClearingIsUsed,
      xzver                            as RecordPaymentHistoryIndicator,
      zwels                            as PaymentMethodsList,
      loevm                            as DeletionIndicator,
      guzte                            as CreditMemoPaymentTerms,
      mgrup                            as DunningNoticeGroup,
      datlz                            as LastInterestCalcRunDate,
      altkn                            as CustPreviousMasterRecordNumber,
      wbrsl                            as ValueAdjustmentKey,
      
      //Add Missing Fields 200805
      fdgrv                            as PlanningGroup,                  
      pernr                            as PersonnelNumber,                
      ekvbd                            as AccountNumberOfBuyingGroup,     
      wakon                            as TermsOfPmntForBillOfExCharges,  
      kultg                            as ProbableTimeTilCheckIsEncashed, 
      urlid                            as ShortKeyKnownNegotiatedLeave,   
      zgrup                            as KeyForPaymentGrouping,          
      webtr                            as BillOfExchangeLimit,            
      lockb                            as Lockbox,                        
      remit                            as NextPayee,                      
      cession_kz                       as AccountsReceivablePledgingInd,  
      vrsdg                            as ReasonCodeConversionVersion,    
      sregl                            as SelectionRuleForPaymentAdvices, 
      zamim                            as PmntNoticeToCuswClearedItems,   
      zamio                            as PmntNoticeToCuswoClearedItems,  
      zamib                            as PaymentNoticeToTheAccntDeptInd, 
      zamiv                            as PaymentNoticeToSalesDepartment, 
      zamir                            as PaymentNoticeToLegalDepartment, 
      vrsnr                            as InsuranceNumber,                
      vrbkz                            as ExportCreditInsInstitutionNum,  
      vlibb                            as AmountInsured,                  
      verdt                            as ValidityDateOfInsurance,        
      vrszl                            as InsuranceTarget,                
      vrspr                            as PercentageOfDeductible,         
      nodel                            as DeletionBlock,                  


      // added for Fiori app (F1993) Customer Summary Report as a part of  DPP (Data Protection & Privacy)
      cvp_xblck_b                      as IsBusinessPurposeCompleted,

      @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
      @Consumption.hidden: true
      _CustomerDefaultDunning.LastDunnedOn,

      @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
      @Consumption.hidden: true
      _CustomerDefaultDunning.DunningProcedure,

       @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
       @Consumption.hidden: true
      _CustomerDefaultDunning.DunningLevel,

       @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
       @Consumption.hidden: true
      _CustomerDefaultDunning.DunningBlock,

       @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
       @Consumption.hidden: true
      _CustomerDefaultDunning.DunningRecipient,

       @VDM.deprecated: true    //Use  _CustomerDefaultDunning to expose the feild
       @Consumption.hidden: true
      _CustomerDefaultDunning.LegDunningProcedureOn,



      // associations
      _Customer,
//      _CompanyCode,
      _CustomerDunning,
      _CustomerDefaultDunning
//      _PaymentBlockValueHelp,
//      _PaymentBlockingReasonText

}






@EndUserText.label: 'Customer Sales Area'
@Analytics: { dataCategory: #FACT }
@VDM.viewType: #BASIC
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.authorizationCheck:#CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/ICUSAREA'
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm : #SESSION_VARIABLE
@ObjectModel.representativeKey:'Division'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_CustomerSalesArea
  as select from knvv
  association [1..1] to /SIMPLE/I_Customer                   as _Customer                     on $projection.Customer = _Customer.Customer
//  association [0..1] to /SIMPLE/I_SalesOrganization          as _SalesOrganization            on $projection.SalesOrganization = _SalesOrganization.SalesOrganization
//  association [0..1] to /SIMPLE/I_DistributionChannel        as _DistributionChannel          on $projection.DistributionChannel = _DistributionChannel.DistributionChannel
//  association [0..1] to /SIMPLE/I_Division                   as _Division                     on $projection.Division = _Division.Division
//  association [0..1] to /SIMPLE/I_SalesOffice                as _SalesOffice                  on $projection.SalesOffice = _SalesOffice.SalesOffice
//  association [0..1] to /SIMPLE/I_SalesGroup                 as _SalesGroup                   on $projection.SalesGroup = _SalesGroup.SalesGroup
  association [0..1] to /SIMPLE/I_Currency                   as _Currency                     on $projection.Currency = _Currency.Currency
//  association [0..1] to /SIMPLE/I_DeliveryPriority           as _DeliveryPriority             on $projection.DeliveryPriority = _DeliveryPriority.DeliveryPriority
//  association [0..1] to /SIMPLE/I_ShippingCondition          as _ShippingCondition            on $projection.ShippingCondition = _ShippingCondition.ShippingCondition
//  association [0..1] to /SIMPLE/I_IncotermsClassif           as _IncotermsClassification      on $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification
  association [0..1] to /SIMPLE/I_Plant                      as _SupplyingPlant               on $projection.SupplyingPlant = _SupplyingPlant.Plant
//  association [0..1] to /SIMPLE/I_DeliveryBlockReason        as _DeliveryIsBlockedForCustomer on $projection.DeliveryIsBlockedForCustomer = _DeliveryIsBlockedForCustomer.DeliveryBlockReason
//  association [0..1] to /SIMPLE/I_BillingBlockReason         as _BillingIsBlockedForCustomer  on $projection.BillingIsBlockedForCustomer = _BillingIsBlockedForCustomer.BillingBlockReason
//  association [0..1] to /SIMPLE/I_CustomerPaymentTerms       as _CustomerPaymentTerms         on $projection.CustomerPaymentTerms = _CustomerPaymentTerms.CustomerPaymentTerms
//  association [0..1] to /SIMPLE/I_CusAccntAssgmtGroup         as _CustomerAccountAssgmtGroup   on $projection.CustomerAccountAssignmentGroup = _CustomerAccountAssgmtGroup.CustomerAccountAssignmentGroup
  association [0..1] to E_BPSALESAREA_D                      as _SalesAreaExt                on $projection.SalesOrganization   = _SalesAreaExt.SalesOrganization
                                                                                     and $projection.DistributionChannel = _SalesAreaExt.DistributionChannel
                                                                                     and $projection.Division            = _SalesAreaExt.Division
                                                                                     and $projection.Customer            = _SalesAreaExt.Customer
{
//      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_Customer_VH',
//                     element: 'Customer' }
//        }]
//      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Customer'
  key kunnr                                                                                 as Customer,
      @ObjectModel.foreignKey.association: '_SalesOrganization'
  key vkorg                                                                                 as SalesOrganization,
//      @ObjectModel.foreignKey.association: '_DistributionChannel'
  key vtweg                                                                                 as DistributionChannel,
//     @ObjectModel.foreignKey.association:'_Division'          //Still need to clarify the compatibility of @Analytics and @representativeKey annotation
  key spart                                                                                 as Division,
      klabc                                                                                 as CustomerABCClassification,
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vkbur                                                                                 as SalesOffice,
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vkgrp                                                                                 as SalesGroup,
      aufsd                                                                                 as OrderIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_Currency'
      waers                                                                                 as Currency,
      //kurst as ExchangeRateType,
      konda                                                                                 as CustomerPriceGroup,
      pltyp                                                                                 as PriceListType,
      @ObjectModel.foreignKey.association: '_DeliveryPriority'
      lprio                                                                                 as DeliveryPriority,
      @ObjectModel.foreignKey.association: '_ShippingCondition'
      vsbed                                                                                 as ShippingCondition,
      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      inco1                                                                                 as IncotermsClassification,
      @ObjectModel.foreignKey.association: '_SupplyingPlant'
      vwerk                                                                                 as SupplyingPlant,
      autlf                                                                                 as CompleteDeliveryIsDefined,
      @ObjectModel.foreignKey.association: '_DeliveryIsBlockedForCustomer'
      lifsd                                                                                 as DeliveryIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_BillingIsBlockedForCustomer'
      faksd                                                                                 as BillingIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_CustomerPaymentTerms'
      zterm                                                                                 as CustomerPaymentTerms,
      ktgrd                                                                                 as CustomerAccountAssignmentGroup,
      eikto                                                                                 as AccountByCustomer, //needed in customer_supplier app
      kdgrp                                                                                 as CustomerGroup, //gfn doubt //needed in customer_supplier app
      kalks                                                                                 as CustomerPricingProcedure, //needed in customer_supplier app
      kzazu                                                                                 as OrderCombinationIsAllowed, //gfn doubt //needed in customer_supplier app
      kztlf                                                                                 as PartialDeliveryIsAllowed, //needed in customer_supplier app
      // transpzone                                                                            as TransportZone, //gfn doubt //needed in customer_supplier app
      perfk                                                                                 as InvoiceDate, //gfn doubt //needed in customer_supplier app
      zterm                                                                                 as PaymentTerms,              //needed in customer_supplier app
      inco2                                                                                 as IncotermsTransferLocation, //needed in customer_supplier app

      awahr                                                                                 as ItemOrderProbabilityInPercent,
      inco3_l                                                                               as IncotermsLocation2,
      begru                                                                                 as AuthorizationGroup,
      bzirk                                                                                 as SalesDistrict,
      
      incov                                                                                 as IncotermsVersion,
      inco2_l                                                                               as IncotermsLocation1,
      loevm                                                                                 as DeletionIndicator,
      cvp_xblck_v                                                                           as IsBusinessPurposeCompleted,
      vsort                                                                                 as SalesItemProposal,
      
      //podtg                                                                                 as ProofOfDeliveryTime, //in hhhhhhh:mm:ss, divide by 24 for number of days *Conversion Exit ATC*
      antlf                                                                                 as MaxNmbrOfPartialDelivery,
      untto                                                                                 as UnderdelivTolrtdLmtRatioInPct,
      uebto                                                                                 as OverdelivTolrtdLmtRatioInPct,
      //For extensibility
      cast( 'X' as sdraft_is_active preserving type )                                       as IsActiveEntity,
      
      kvgr1                                                                                 as AdditionalCustomerGroup1,
      kvgr2                                                                                 as AdditionalCustomerGroup2,
      kvgr3                                                                                 as AdditionalCustomerGroup3,
      kvgr4                                                                                 as AdditionalCustomerGroup4,
      kvgr5                                                                                 as AdditionalCustomerGroup5,
      
      //Add Missing Fields 200805
      rdoff                                                                                 as RoundingOff,                    
      megru                                                                                 as UnitOfMeasureGroup,             
      pvksm                                                                                 as PpCustomerProced,               
      kurst                                                                                 as ExchangeRateType,               
      agrel                                                                                 as RelevantForSettlementMngmnt,    
      podkz                                                                                 as PodRelevant,                   
      podtg                                                                                 as PodTimeframe,                   
      uebtk                                                                                 as UnlimitedTolerance,             
      mrnkz                                                                                 as SusInvoiceProc,                 
      perrl                                                                                 as InvoiceListSched,               
      kabss                                                                                 as PaymtGuarantProc,               
      cassd                                                                                 as BlockSalesSupport,         
      //Begin of Ins by Danh Tran 2022.11.30 
      bokre                                                                                 as rebate ,
      kkber                                                                                 as creditControlArea, 
      //End of Ins by Danh Tran 2022.11.30      
      prfre                                                                                 as PriceDetermination, //Ins by Danh Tran 20230811 - LD-0053

      _Customer,
//      _SalesOrganization,
//      _DistributionChannel,
//      _Division,
//      _SalesOffice,
//      _SalesGroup,
      _Currency
//      _DeliveryPriority,
//      _ShippingCondition,
//      _IncotermsClassification,
//      _SupplyingPlant
//      _DeliveryIsBlockedForCustomer
//      _BillingIsBlockedForCustomer,
//      _CustomerPaymentTerms
//      _CustomerAccountAssgmtGroup

} 
  
  
  
  
  
  
 

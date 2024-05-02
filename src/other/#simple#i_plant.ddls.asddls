@AbapCatalog:{
               sqlViewName: '/SIMPLE/IPLANT',
               preserveKey: true,
               compiler.compareFilter: true
             }
@EndUserText.label: 'Plant'
@ObjectModel:{
               usageType:{
                           sizeCategory: #S,
                           serviceQuality: #A,
                           dataClass:#CUSTOMIZING
                         },
               representativeKey: 'Plant'
             }
@AccessControl:{
                 authorizationCheck: #NOT_REQUIRED,
                 personalData.blocking: #NOT_REQUIRED,
                 privilegedAssociations: ['_Address']
               }
@VDM:{
       viewType: #BASIC,
       lifecycle.contract.type: #PUBLIC_LOCAL_API
     }
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics.dataCategory: #DIMENSION
@Search.searchable: true
@Metadata: {
             allowExtensions: true,
             ignorePropagatedAnnotations: true
           }

define view /SIMPLE/I_Plant
  as select from t001w
//  association [0..1] to /SIMPLE/I_Address                     as _Address                on $projection.AddressID = _Address.AddressID
//  association [0..1] to /SIMPLE/I_Customer                    as _Customer               on $projection.PlantCustomer = _Customer.Customer
//  association [0..1] to /SIMPLE/I_Supplier                    as _Supplier               on $projection.PlantSupplier = _Supplier.Supplier
//  association [0..*] to /SIMPLE/I_PlantPurchOrg               as _ResponsiblePurchaseOrg on $projection.Plant = _ResponsiblePurchaseOrg.Plant
//  association [0..*] to /SIMPLE/I_PlantCategoryT              as _PlantCategoryText      on $projection.PlantCategory = _PlantCategoryText.PlantCategory
{
      @ObjectModel.text.element: 'PlantName'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key werks                                      as Plant,
      @Semantics.text: true
      cast(name1 as werks_name preserving type ) as PlantName,
      bwkey                                      as ValuationArea,
      kunnr                                      as PlantCustomer,
      lifnr                                      as PlantSupplier,
      fabkl                                      as FactoryCalendar,
      ekorg                                      as DefaultPurchasingOrganization,
      vkorg                                      as SalesOrganization,     
      adrnr                                      as AddressID,
      vlfkz                                      as PlantCategory,
      vtweg                                      as DistributionChannel,
      spart                                      as Division
//      _Address,
//      _Customer,
//      _Supplier,
//      _ResponsiblePurchaseOrg,
//      _PlantCategoryText
}                                             
  
  
  
  
  
 
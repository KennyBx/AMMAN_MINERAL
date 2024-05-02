@AbapCatalog.sqlViewName: '/SIMPLE/IPPQTM'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product: Draft node for Plant QM'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_Prdplantqtmanagement
  as select from nsdm_e_marc as PlantQualityMgmt 
  association [1..1] to /SIMPLE/I_Product      as _Product            on  $projection.Product = _Product.Product
  association [0..1] to E_Productplant as _ProdPlantQtMgmtExt on  $projection.Product = _ProdPlantQtMgmtExt.Product
                                                              and $projection.Plant   = _ProdPlantQtMgmtExt.Plant
{
  key PlantQualityMgmt.matnr                                        as Product,
  key PlantQualityMgmt.werks                                        as Plant,
      PlantQualityMgmt.maxlz                                        as MaximumStoragePeriod,
      PlantQualityMgmt.ssqss                                        as QualityMgmtCtrlKey,
      PlantQualityMgmt.qmata                                        as MatlQualityAuthorizationGroup,
      cast (PlantQualityMgmt.insmk  as hasposttoinspectionstock )   as HasPostToInspectionStock,
      cast( 'X' as sdraft_is_active preserving type )               as IsActiveEntity, // to enbale extensibility in Draft 2.0
      
      // New fields from MDG model, as part of unified API development
      PlantQualityMgmt.kzdkz                                        as InspLotDocumentationIsRequired,
      //PlantQualityMgmt.qmata                                        as MatlQualityAuthorizationGroup,
      PlantQualityMgmt.qssys                                        as SuplrQualityManagementSystem,
      PlantQualityMgmt.prfrq                                        as RecrrgInspIntervalTimeInDays,
      PlantQualityMgmt.qzgtp                                        as ProductQualityCertificateType,
      
      _Product
}

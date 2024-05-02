@AbapCatalog.sqlViewName: '/SIMPLE/CPRDPQM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductPlantQualityMgmt'
define view /SIMPLE/C_PrdPlantQualityMgmt
  as select from /SIMPLE/I_Prdplantqtmanagement
  association to parent /SIMPLE/C_ProductPlant as _Plant on  $projection.product = _Plant.product
                                                         and $projection.plant   = _Plant.plant

{ 
  key   Product                        as product,
  key   Plant                          as plant,
        MaximumStoragePeriod           as maximumStoragePeriod,
        QualityMgmtCtrlKey             as qualityMgmtCtrlKey,
        MatlQualityAuthorizationGroup  as matlQualityAuthorizationGroup,
        HasPostToInspectionStock       as hasPostToInspectionStock,
        InspLotDocumentationIsRequired as inspLotDocumentationIsRequired,
        SuplrQualityManagementSystem   as suplrQualityManagementSystem,
        RecrrgInspIntervalTimeInDays   as recrrgInspIntervalTimeInDays,
        ProductQualityCertificateType  as productQualityCertificateType,

        /* SimpleMDG specific fields for integration */
        cast( '' as abap.char( 10 ) )  as action,
        cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

        /* Associations */
        _Plant
}

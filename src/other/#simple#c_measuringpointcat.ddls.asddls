@AbapCatalog.sqlViewName: '/SIMPLE/CMPCAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MeasuringPointCategory'
define view /SIMPLE/C_MeasuringPointCat as select from I_MeasuringPointCategory
{
    key MeasuringPointCategory          as measuringPointCategory,
        MeasurementPositionNumber       as measurementPositionNumber,
        MeasuringPointCatalogType       as measuringPointCatalogType,
        OnlineMessageType               as onlineMessageType,
        MsmtDocumentTimeDiffThreshold   as msmtDocumentTimeDiffThreshold,
        MsrgPtCategoryIsValid           as msrgPtCategoryIsValid,
        
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      
     // Propagate association(s)
      _MeasuringPointCategoryText,
      _MeasuringPointCatalog
    
}

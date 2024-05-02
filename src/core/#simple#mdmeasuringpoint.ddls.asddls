@AbapCatalog.sqlViewName: '/SIMPLE/MDMPOINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Measuring Point'
define view /SIMPLE/MDMEASURINGPOINT
  as select from    imptt
    left outer join equi  on imptt.mpobj = equi.objnr
    left outer join iflot on imptt.mpobj = iflot.objnr
{
  key cast (point as char12)   as measuringPoint,
      psort                    as posn,
      pttxt                    as description,
      ---MNGUYEN03 add
      LTRIM( iflot.tplnr, '0') as functionalLocation,
      LTRIM(equi.equnr, '0')   as equipment,
      indct                    as isCounter,
      cjump                    as overflowReading,
      pyear                    as annualEstimate,
      ---MNGUYEN03 add
      mrngu                    as unitOfMeasure
}

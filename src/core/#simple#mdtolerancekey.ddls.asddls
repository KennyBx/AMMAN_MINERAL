@AbapCatalog.sqlViewName: '/SIMPLE/MDTOLKEY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 -ToleranceKey'
define view /SIMPLE/MDTOLERANCEKEY as select from tq29 
                                left outer join  tq29t on tq29.toleranzsl = tq29t.toleranzsl
{
    key tq29.toleranzsl as toleranceKey,
    key sprache    as locale, 
        einheit    as unitOfMeasurement,   
        kurztext    as shortTextt
}

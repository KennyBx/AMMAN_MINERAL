@AbapCatalog.sqlViewName: '/SIMPLE/MDWGTCHA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Weighting Of Characteristic'
define view /SIMPLE/MDWEIGHTINGOFCHARAC as select from tq17a 
                                       left outer join tq17u on tq17a.merkklasse = tq17u.merkklasse
{
    key tq17a.merkklasse as characteristicWeighting,
    key tq17u.sprache    as locale,
        tq17u.kurztext   as shortText
}

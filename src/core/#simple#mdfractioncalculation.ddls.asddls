@AbapCatalog.sqlViewName: '/SIMPLE/MDFRACAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Fraction Calculation'
define view /SIMPLE/MDFRACTIONCALCULATION as select from tq72 
                                         left outer join tq72t on tq72.antverf = tq72t.antverf
{
    key tq72.antverf as fractionCalculation,
    key tq72t.sprache as locale,
        tq72t.kurztext as shortText
}

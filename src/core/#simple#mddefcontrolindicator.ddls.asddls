@AbapCatalog.sqlViewName: '/SIMPLE/MDCONIND'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG]F4 - Default Control Indicator'
define view /SIMPLE/MDDEFCONTROLINDICATOR as select from tq27
                                        left outer join  tq27t on tq27.steuerkz = tq27t.steuerkz
                                                              and tq27.kzeinstell = tq27t.kzeinstell
{
    key tq27.steuerkz  as controlKey,
    key tq27t.sprache  as locale,
    key tq27t.kurztext as shortText     
}

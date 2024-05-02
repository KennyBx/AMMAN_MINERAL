@AbapCatalog.sqlViewName: '/SIMPLE/MDMAAUG2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Matl Auth Grp for Activity2'
define view /SIMPLE/MDQMMATLAUTHGRP2 as select from /SIMPLE/MDQMMATLAUTHGRP {
    key QMMatlAuthorizationGroup as qmMatlAuthorizationGroup,
    key Locale as locale,
    InspectionLot as inspectionLot,
    Description as description
}

@AbapCatalog.sqlViewName: '/SIMPLE/IFLOCEQU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Location Equipment'
define view /SIMPLE/I_FLOCEQUIPMENT as select from iloa 
inner join equz on iloa.iloan = equz.iloan
left outer join eqkt on equz.equnr = eqkt.equnr {
    key equz.equnr as Equipment,
    key equz.datbi as ValidTo,
    key equz.eqlfn as UsgePerConsecNum,
    key cast ( iloa.tplnr as /simple/tplnr preserving type ) as FunctionalLocation,
        equz.equzn as NxtUsagePeriodNum,
        equz.timbi as Time,
        equz.iloan as LocAcctAssignment,
        eqkt.eqktx as Description
} where equz.datbi = '99991231'

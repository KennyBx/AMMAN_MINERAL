@AbapCatalog.sqlViewName: '/SIMPLE/MDWATYP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '[MDG] F4 - Wage Type'
define view /SIMPLE/MDWAGETYPE
  as select from t703k
    inner join   t703m on t703m.lstyp = t703k.lstyp
    inner join   t512t on  t512t.molga = t703k.molga
                       and t512t.lgart = t703k.lgart
                       and t512t.sprsl = t703m.sprsl
{
  key  t703k.molga as hcmLocal,
  key  t703k.lgart as wageType,
  key  t703k.lstyp as timeTicketType,
  key  t703k.endda as endDate,
       t703k.begda as startDate,
       t703m.sprsl as language,
       t703m.lgtxt as timeTicketDescription,
       t512t.lgtxt as wageTypeDescription
}

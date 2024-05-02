@AbapCatalog.sqlViewName: '/SIMPLE/MDDOCPI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MDDocumentPI'
define view /SIMPLE/MDDOCUMENTPI
  as select from    draw as t1
    left outer join drat as t2 on  t1.doknr = t2.doknr
                               and t1.dokar = t2.dokar
{
  key t1.dokar as documentType,
  key t1.doknr as document,
  key t1.dokvr as documentVersion,
  key t1.doktl as documentPart,
  key t2.langu as locale,
      t2.dktxt as description,
      begru
}
where
  t1.dokar = 'PAC' and 
  t2.langu =   $session.system_language

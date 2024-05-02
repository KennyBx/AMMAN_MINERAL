@AbapCatalog.sqlViewName: '/SIMPLE/MDDOC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Document Info Record'
define view /SIMPLE/MDDOCUMENT
  as select from draw as draw 
  left outer join drat as DRAT on draw.dokar = drat.dokar
                              and draw.doknr = drat.doknr
                              and draw.dokvr = drat.dokvr
                              and draw.doktl = drat.doktl
{   
  key draw.dokar as docType,
  key draw.doknr as docNumber,
  key draw.dokvr as docVersion,
  key draw.doktl as docPart,
  key drat.langu as locale,
      drat.dktxt as description
}

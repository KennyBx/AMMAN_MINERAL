@AbapCatalog.sqlViewName: '/SIMPLE/MDSEGMNT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] Master Data for Segments'
define view /SIMPLE/MDSEGMENT
  as select from    fagl_segm  as t1
    left outer join fagl_segmt as t2 on t1.segment = t2.segment
{
  key t1.segment as segment,
  key langu      as locale,
      name       as description
}

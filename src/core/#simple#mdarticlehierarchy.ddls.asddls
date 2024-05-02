@AbapCatalog.sqlViewName: '/SIMPLE/MDAH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Article Hierarchy Master Data'
define view /SIMPLE/MDARTICLEHIERARCHY
  as select from wrf_matgrp_hier  as ArticleHierarchy
    inner join   wrf_matgrp_hiert as Text on ArticleHierarchy.hier_id = Text.hier_id
{
  key ArticleHierarchy.hier_id as articleHierarchy,
  key Text.spras               as locale,
      Text.ltext               as description,
      ArticleHierarchy.status  as status
}

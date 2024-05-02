@AbapCatalog.sqlViewName: '/SIMPLE/MDAHN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MDArticleHierarchyNode'
define view /SIMPLE/MDArticleHierarchyNode
  as select from    wrf_matgrp_struc
    left outer join wrf_matgrp_strct on  wrf_matgrp_struc.hier_id = wrf_matgrp_strct.hier_id
                                     and wrf_matgrp_struc.node    = wrf_matgrp_strct.node
{
  key  wrf_matgrp_struc.hier_id as hierarchy,               //SSPD-2537 - 20240314 - Danh Tran - Ins
  key  wrf_matgrp_struc.node    as articleHierarchyNode,
  key  wrf_matgrp_strct.spras   as locale,
       wrf_matgrp_strct.ltext   as description,
       wrf_matgrp_struc.catflg  as categoryFlag             //SSPD-2537 - 20240314 - Danh Tran - Ins
}

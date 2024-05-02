@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMITM'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master'
define view /SIMPLE/MDBILLOFMATERIALITEM
  as select distinct from /SIMPLE/I_BOMItemHChangeState as item
    left outer join       tcs21                         as TCS21 on  TCS21.objty = item.ObjectType
                                                                 and TCS21.spras = $session.system_language
{
  key    cast( item.BillOfMaterial  as /simple/stnum preserving type )          as billOfMaterial,
  key    item.BillOfMaterialCategory                                            as billOfMaterialCategory,
  key    item.BillOfMaterialVariant                                             as billOfMaterialVariant,
  key    item.BillOfMaterialItemNodeNumber                                      as billOfMaterialItemNodeNumber,
  key    item.BillOfMaterialItemUUID                                            as billOfMaterialItemUUID,
         item.Material                                                          as material,
         item.Plant                                                             as plant,
         //         item.IdentifierBOMItem                                                   as identifierBOMItem,
         item.BillOfMaterialVariantUsage                                        as billOfMaterialVariantUsage,
         item.ValidityStartDate                                                 as validityStartDate,
         item.ValidityEndDate                                                   as validityEndDate,
         item.ComponentDescription                                              as componentDescription,
         item.BillOfMaterialComponent                                           as billOfMaterialComponent,
         item.BillOfMaterialItemCategory                                        as billOfMaterialItemCategory,
         cast( item.BillOfMaterialItemNumber as /simple/sposn preserving type ) as billOfMaterialItemNumber,
         item.BillOfMaterialItemUnit                                            as billOfMaterialItemUnit,
         item.BillOfMaterialItemQuantity                                        as billOfMaterialItemQuantity,
         item.IsSubItem                                                         as isSubItem,
         item.IsAssembly                                                        as isAssembly,
         item.DocumentType                                                      as documentType,
         item.DocNumber                                                         as docNumber,
         item.DocumentVersion                                                   as documentVersion,
         item.DocumentPart                                                      as documentPart,
         item.EngineeringChangeDocument                                         as engineeringChangeDocument,
         item.ChgToEngineeringChgDocument                                       as chgToEngineeringChgDocument,
         tcs21.obtsp                                                            as objectType
}

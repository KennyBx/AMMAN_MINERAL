@AbapCatalog.sqlViewName: '/SIMPLE/MDBOMIT2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master'
define view /SIMPLE/MDBILLOFMATERIALITEM2
  as select from /SIMPLE/MDBILLOFMATERIALITEM
{

  key    cast( billOfMaterial  as /simple/stnum preserving type ) as billOfMaterial,
  key    billOfMaterialCategory                                   as billOfMaterialCategory,
  key    billOfMaterialVariant                                    as billOfMaterialVariant,
  key    billOfMaterialItemNodeNumber                             as billOfMaterialItemNodeNumber,
  key    billOfMaterialItemUUID                                   as billOfMaterialItemUUID,
         material                                                 as material,
         plant                                                    as plant,
         billOfMaterialVariantUsage                               as billOfMaterialVariantUsage,
         validityStartDate                                        as validityStartDate,
         validityEndDate                                          as validityEndDate,
         componentDescription                                     as componentDescription,
         billOfMaterialComponent                                  as billOfMaterialComponent,
         billOfMaterialItemCategory                               as billOfMaterialItemCategory,
         billOfMaterialItemNumber                                 as billOfMaterialItemNumber,
         billOfMaterialItemUnit                                   as billOfMaterialItemUnit,
         billOfMaterialItemQuantity                               as billOfMaterialItemQuantity,
         isSubItem                                                as isSubItem,
         isAssembly                                               as isAssembly,
         documentType                                             as documentType,
         docNumber                                                as docNumber,
         documentVersion                                          as documentVersion,
         documentPart                                             as documentPart,
         engineeringChangeDocument                                as engineeringChangeDocument,
         chgToEngineeringChgDocument                              as chgToEngineeringChgDocument,
         objectType                                               as objectType
}

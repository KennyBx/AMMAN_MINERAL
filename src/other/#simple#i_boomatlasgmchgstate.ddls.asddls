@AbapCatalog.sqlViewName: '/SIMPLE/IBOMACHS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
// BEN @ObjectModel.representativeKey: 'BOOMatlInternalVersionCounter'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Change State of Material assgmt. to BOO'
// BEN @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BOOMatlAsgmChgState

  as select from mapl

//  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType  on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                                 and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//  association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations      on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                                 and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                                 and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
//  association [1..1] to /SIMPLE/I_BOOMaterialAssignmnt as _BOOMaterialAssignment on  $projection.Plant                   = _BOOMaterialAssignment.Plant
//                                                                                 and $projection.Material                = _BOOMaterialAssignment.Material
//                                                                                 and $projection.BillOfOperationsType    = _BOOMaterialAssignment.BillOfOperationsType
//                                                                                 and $projection.BillOfOperationsGroup   = _BOOMaterialAssignment.BillOfOperationsGroup
//                                                                                 and $projection.BillOfOperationsVariant = _BOOMaterialAssignment.BillOfOperationsVariant
//                                                                                 and $projection.BOOToMaterialInternalID = _BOOMaterialAssignment.BOOToMaterialInternalID
//  association [1..1] to /SIMPLE/I_Plant                as _Plant                 on  $projection.Plant = _Plant.Plant
//  association [1..1] to /SIMPLE/I_Material             as _Material              on  $projection.Material = _Material.Material
//  association [0..1] to /SIMPLE/I_Supplier             as _Supplier              on  $projection.Supplier = _Supplier.Supplier
//  association [0..1] to /SIMPLE/I_Customer             as _Customer              on  $projection.Customer = _Customer.Customer
//  association [0..1] to I_SalesOrder                   as _SalesOrder            on  $projection.SalesOrder = _SalesOrder.SalesOrder
//  association [0..1] to I_SalesOrderItem               as _SalesOrderItem        on  $projection.SalesOrder     = _SalesOrderItem.SalesOrder
//                                                                                 and $projection.SalesOrderItem = _SalesOrderItem.SalesOrderItem
//  association [0..1] to I_WBSElementByInternalKey      as _WBSElement            on  $projection.WBSElementInternalID = _WBSElement.WBSElementInternalID
//  association [0..1] to /SIMPLE/I_ChangeMaster         as _ChangeMaster          on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber
//  
//  association [1..1] to /SIMPLE/I_RoutingAPITP         as _BOOHeader            on  $projection.BillOfOperationsType    = _BOOHeader.BillOfOperationsType
//                                                                                 and $projection.BillOfOperationsGroup   = _BOOHeader.BillOfOperationsGroup
//                                                                                 and $projection.BillOfOperationsVariant = _BOOHeader.BillOfOperationsVariant
{
      // BEN @ObjectModel.foreignKey.association: '_Material'
  key mapl.matnr                                                  as Material,
      // BEN @ObjectModel.foreignKey.association: '_Plant'
  key mapl.werks                                                  as Plant,
      // BEN @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key mapl.plnty                                                  as BillOfOperationsType,

      // BEN @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key mapl.plnnr                                                  as BillOfOperationsGroup,
      // BEN @ObjectModel.foreignKey.association: '_BillOfOperations'
  key mapl.plnal                                                  as BillOfOperationsVariant,
      // BEN @ObjectModel.foreignKey.association: '_BOOMaterialAssignment'
  key mapl.zkriz                                                  as BOOToMaterialInternalID,
  key mapl.zaehl                                                  as BOOMatlInternalVersionCounter,

      @Semantics.businessDate.from: true
      mapl.datuv                                                  as ValidityStartDate,
      @Semantics.businessDate.to: true
      mapl.valid_to                                               as ValidityEndDate,

      // BEN @ObjectModel.foreignKey.association: '_ChangeMaster'
      mapl.aennr                                                  as ChangeNumber,
      @Semantics.systemDate.createdAt: true
      mapl.andat                                                  as CreationDate,
      @Semantics.user.createdBy: true
      cast(mapl.annam as vdm_createdbyuserid preserving type)     as CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      mapl.aedat                                                  as LastChangeDate,
      @Semantics.user.lastChangedBy: true
      cast(mapl.aenam as vdm_lastchangedbyuserid preserving type) as LastChangedByUser,

      mapl.loekz                                                  as IsDeleted,
      mapl.loekz_inherited                                        as IsImplicitlyDeleted,

      // BEN @ObjectModel.foreignKey.association: '_Supplier'
      mapl.lifnr                                                  as Supplier,
      // BEN @ObjectModel.foreignKey.association: '_Customer'
      mapl.kunr                                                   as Customer,
      // BEN @ObjectModel.foreignKey.association: '_SalesOrder'
      mapl.vbeln                                                  as SalesOrder,
      // BEN @ObjectModel.foreignKey.association: '_SalesOrderItem'
      mapl.posnr                                                  as SalesOrderItem,
      // BEN @ObjectModel.foreignKey.association: '_WBSElement'
      cast(mapl.pspnr as pph_pspel preserving type)               as WBSElementInternalID,
      suchfeld                                                    as BOOSearchText,
      //      MS_OBJECT Q_MS_OBJECT     global field name not available
      //      MS_OBJTYPE  Q_MS_OBJTYPE  global field name not available

      mapl.versn                                                  as BillOfOperationsVersion,
      // Start adding missing F4
      ms_object                                                   as ObjectForMultipleSpec,
      ms_objtype                                                  as ObjectTypeForMultipleSpec,
      parkz                                                       as InactiveChangesIndicator,
      techv                                                       as TechnicalStatusFrom
//      // End adding missing F4
//      _Material,
//      _Plant,
//      _BillOfOperationsType,
//      _BillOfOperationsGroup,
//      _BillOfOperations,
//      _BOOMaterialAssignment,
//      _Supplier,
//      _Customer,
//      _SalesOrder,
//      _SalesOrderItem,
//      _WBSElement,
//      _ChangeMaster,
//      _BOOHeader
}

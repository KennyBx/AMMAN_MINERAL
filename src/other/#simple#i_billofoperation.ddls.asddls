@AbapCatalog.sqlViewName: '/SIMPLE/IBOOPRT'
@ObjectModel.compositionRoot: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
//@Analytics: {dataCategory: #DIMENSION}
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BillOfOperationsVariant'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true 

define view /SIMPLE/I_BillOfOperation
  as select from plkz

  association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType        on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [0..1] to /SIMPLE/I_BOOVersionType       as _BillOfOperationsVersionType on  $projection.BillOfOperationsVersionType = _BillOfOperationsVersionType.BillOfOperationsVersionType  
  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup       on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
                                                                                      and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//  -- to child: Change State of Root
//  association [1..*] to /SIMPLE/I_BillOfOperationHead as _BillOfOperationsChangeState on  $projection.BillOfOperationsType    = _BillOfOperationsChangeState.BillOfOperationsType
//                                                                                      and $projection.BillOfOperationsGroup   = _BillOfOperationsChangeState.BillOfOperationsGroup
//                                                                                      and $projection.BillOfOperationsVariant = _BillOfOperationsChangeState.BillOfOperationsVariant
//  -- to child: Sequences
  association [1..*] to /SIMPLE/I_BOOSequence          as _BillOfOperationsSequence    on  $projection.BillOfOperationsType    = _BillOfOperationsSequence.BillOfOperationsType
                                                                                      and $projection.BillOfOperationsGroup   = _BillOfOperationsSequence.BillOfOperationsGroup
                                                                                      and $projection.BillOfOperationsVariant = _BillOfOperationsSequence.BillOfOperationsVariant

  -- to child: Material to BOO assignment
  association [1..*] to /SIMPLE/I_BOOMaterialAssignmnt as _BOOMaterialAssignment       on  $projection.BillOfOperationsType    = _BOOMaterialAssignment.BillOfOperationsType
                                                                                      and $projection.BillOfOperationsGroup   = _BOOMaterialAssignment.BillOfOperationsGroup
                                                                                      and $projection.BillOfOperationsVariant = _BOOMaterialAssignment.BillOfOperationsVariant
{
//      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plkz.plnty                                                   as   BillOfOperationsType,

//      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key plkz.plnnr                                                   as   BillOfOperationsGroup,
  key plkz.plnal                                                   as   BillOfOperationsVariant,

//      @ObjectModel.foreignKey.association: '_BillOfOperationsVersionType'
      plkz.subtype                                                 as   BillOfOperationsVersionType,
      
      plkz.subtype                                                 as   BillOfOperationsSubtype, //kept for compatibility reasons

      plkz.abdat                                                   as   LastUsageDate,
      plkz.abanz                                                   as   NumberOfUsages,

      plkz.flg_ecm                                                 as   HasChangeNumber,
      plkz.flg_ecm_par                                             as   HasParameterEffectivity,

      -- Administrative Data
      @Semantics.systemDate.lastChangedAt: true
      plkz.aedat                                                   as   LastChangeDate,
      plkz.aeuzeit                                                 as   LastChangeTime,
      @Semantics.user.lastChangedBy: true
      cast(plkz.aenam as vdm_lastchangedbyuserid preserving type)  as   LastChangedByUser,
      
      plkz.rework                                                  as   RoutingIsReworkRouting,
      plkz.relaxed                                                 as   ProdnProcgIsFlexible,

      // **************************** Associations *****************************

      _BOOMaterialAssignment,
//      _BillOfOperationsChangeState,
      _BillOfOperationsGroup,
      _BillOfOperationsSequence,
      _BillOfOperationsType
//      _BillOfOperationsVersionType
}

@AbapCatalog.sqlViewName: '/SIMPLE/IPRDSTR'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product: Draft node for product storage'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_Productstorage
  as select from mara

  association [0..1] to E_Product                as _ProdStorageExt            on $projection.Product = _ProdStorageExt.Product
  association [0..1] to I_Storagecondition       as _Storagecondition          on $projection.StorageConditions = _Storagecondition.StorageConditions
  association [0..*] to I_Storageconditiontext   as _StorageText               on $projection.StorageConditions = _StorageText.StorageConditions
  association [0..1] to I_Tempindcndn            as _TemperatureConditionInd   on $projection.TemperatureConditionInd = _TemperatureConditionInd.TemperatureConditionInd
  association [0..*] to I_Tempindcndntext        as _TemperatureConditionText  on $projection.TemperatureConditionInd = _TemperatureConditionText.TemperatureConditionInd
  association [0..1] to I_CtnRqmtsForProduct     as _StorageBinInstruction     on $projection.StorageBinInstruction = _StorageBinInstruction.StorageBinInstruction
  association [0..*] to I_CtnRqmtsForProductText as _StorageBinInstructionText on $projection.StorageBinInstruction = _StorageBinInstructionText.StorageBinInstruction

{
  key mara.matnr                                      as Product,
      @ObjectModel.foreignKey.association:'_Storagecondition'
      @ObjectModel.text.association: '_StorageText'
      mara.raube                                      as StorageConditions,
      _Storagecondition,
      _StorageText,
      @ObjectModel.foreignKey.association:'_TemperatureConditionInd'
      @ObjectModel.text.association: '_TemperatureConditionText'
      mara.tempb                                      as TemperatureConditionInd,
      _TemperatureConditionInd,
      _TemperatureConditionText,
      mara.stoff                                      as HazardousMaterialNumber,
      mara.wesch                                      as NmbrOfGROrGISlipsToPrintQty,
      mara.etiar                                      as LabelType,
      mara.etifo                                      as LabelForm,
      mara.mhdrz                                      as MinRemainingShelfLife,
      mara.sled_bbd                                   as ExpirationDate,


      //    Retail Field
      @ObjectModel.foreignKey.association:'_StorageBinInstruction'
      @ObjectModel.text.association: '_StorageBinInstructionText'
      mara.behvo                                      as StorageBinInstruction,
      _StorageBinInstruction,
      _StorageBinInstructionText,
      //      mara.mhdhb                                      as TotalShelfLife, //pstat changes
      mara.mhdlp                                      as TotalShelfLifeStoragePercent,
      mara.iprkz                                      as ShelfLifeExpirationDatePeriod,
      mara.rdmhd                                      as ShelfLifeExprtnDateRndingRule,
      mara.begru                                      as AuthorizationGroup,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0
      mara.mhdhb                                      as TotalShelfLife // as per mdg model the field should be part of storage






}

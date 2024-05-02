@AbapCatalog.sqlViewName: '/SIMPLE/CFUNCL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FunctionalLocation'
define root view /SIMPLE/C_FunctionalLocation
  as select from    /SIMPLE/I_FUNCTIONALLOCATION as _FunctionalLocation
    left outer join jest                         as FlocStatusDel   on  FlocStatusDel.objnr = _FunctionalLocation.ObjectNumber
                                                                    and FlocStatusDel.stat  = 'I0076'
                                                                    and FlocStatusDel.inact is initial
    left outer join jest                         as FlocStatusDeact on  FlocStatusDeact.objnr = _FunctionalLocation.ObjectNumber
                                                                    and FlocStatusDeact.stat  = 'I0320'
                                                                    and FlocStatusDeact.inact is initial
  composition [0..*] of /SIMPLE/C_FLOCText           as _FunctionalLocationText
  //                                                                                   on $projection.functionalLocation = _FunctionalLocationText.functionalLocation
  //                                                                                and $projection.language           = _FunctionalLocationText.language
  composition [0..*] of /SIMPLE/C_FLOCAddress        as _FunctionalLocationAddess
  //  on $projection.addressNumber = _FunctionalLocationAddess.addressNumber
  composition [0..*] of /SIMPLE/C_FLOCEQUIPMENT      as _FunctionalLocationEquipment
  //  on $projection.functionalLocation = _FunctionalLocationEquipment.functionalLocation
  //                                                                                and $projection.validTo            = _FunctionalLocationEquipment.validTo
  //                                                                                and $projection.consecNumber       = _FunctionalLocationEquipment.usgePerConsecNum
  composition [0..*] of /SIMPLE/C_FLOCMEASURING      as _MeasuringPoint
  //  on $projection.objectNumber = _MeasuringPoint.objectNumMeasurePoint
  composition [0..*] of /SIMPLE/C_FLOCSTATUS         as _FlocStatus
  //  on $projection.objectNumber = _FlocStatus.objectNumber
  composition [0..*] of /SIMPLE/C_FLOCCLASSIFICATION as _Classification
  //  on $projection.functionalLocation = _Classification.functionalLocation
{
  key _FunctionalLocation.FunctionalLocation                                                                                                                    as functionalLocation,
      _FunctionalLocation.StructureIndicator                                                                                                                    as structureIndicator,
      _FunctionalLocation.FunctionalLocationCategory                                                                                                            as functionalLocationCategory,
      _FunctionalLocation.LabelingSystem                                                                                                                        as labelingSystem,
      //      Language                       as language,
      //      DeletionFlag                   as deletionFlag,
      _FunctionalLocation.SupLoc                                                                                                                                as supLoc,
      _FunctionalLocation.RefLoc                                                                                                                                as refLoc,
      _FunctionalLocation.ObjectNumber                                                                                                                          as objectNumber,
      _FunctionalLocation.AddressNumber                                                                                                                         as addressNumber,
      _FunctionalLocation.LocAcctAssignment                                                                                                                     as locAcctAssignment,
      //      Equipment                      as equipment,
      //      ValidTo                        as validTo,
      //      ConsecNumber                   as consecNumber,
      _FunctionalLocation.Description                                                                                                                           as description,
      _FunctionalLocation.ObjectType                                                                                                                            as objectType,
      _FunctionalLocation.InventoryNumber                                                                                                                       as inventoryNumber,
      @Semantics.quantity.unitOfMeasure: 'unitOfWeight'
      _FunctionalLocation.WeightOfObject                                                                                                                        as weightOfObject,
      @Semantics.unitOfMeasure: true
      _FunctionalLocation.UnitOfWeight                                                                                                                          as unitOfWeight,
      _FunctionalLocation.SizeAndDimension                                                                                                                      as sizeAndDimension,
      _FunctionalLocation.StartUpDate                                                                                                                           as startUpDate,
      _FunctionalLocation.AuthorizationGroup                                                                                                                    as authorizationGroup,
      _FunctionalLocation.AcquisitionDate                                                                                                                       as acquisitionDate,
      @Semantics.amount.currencyCode: 'currencyKey'
      _FunctionalLocation.AcquisitionValue                                                                                                                      as acquisitionValue,
      @Semantics.currencyCode: true
      _FunctionalLocation.CurrencyKey                                                                                                                           as currencyKey,
      _FunctionalLocation.ManufacturerOfAsset                                                                                                                   as manufacturerOfAsset,
      _FunctionalLocation.CountryOfManufacture                                                                                                                  as countryOfManufacture,
      _FunctionalLocation.ManufacturerModelNumber                                                                                                               as manufacturerModelNumber,
      cast( _FunctionalLocation.ConstructionYear as abap.char( 4 ) )                                                                                            as constructionYear,
      _FunctionalLocation.ConstructionMonth                                                                                                                     as constructionMonth,
      _FunctionalLocation.ManufPartNumber                                                                                                                       as manufPartNumber,
      _FunctionalLocation.ManufSerialNumber                                                                                                                     as manufSerialNumber,
      _FunctionalLocation.MaintenancePlant                                                                                                                      as maintenancePlant,
      _FunctionalLocation.MaintenanceLocation                                                                                                                   as maintenanceLocation,
      _FunctionalLocation.Room                                                                                                                                  as room,
      _FunctionalLocation.PlantSection                                                                                                                          as plantSection,
      _FunctionalLocation.ControllingArea                                                                                                                       as controllingArea,
      case when _FunctionalLocation.WorkCenter is initial then cast( '' as abap.char( 8 )) else  _FunctionalLocation.WorkCenter end                             as workCenter,
      _FunctionalLocation.ABCIndicator                                                                                                                          as aBCIndicator,
      _FunctionalLocation.SortField                                                                                                                             as sortField,
      _FunctionalLocation.CompanyCode                                                                                                                           as companyCode,
      _FunctionalLocation.BusinessArea                                                                                                                          as businessArea,
      _FunctionalLocation.PlanningPlan                                                                                                                          as planningPlant,
      _FunctionalLocation.Plant                                                                                                                                 as plant,
      _FunctionalLocation.PpWorkCenter                                                                                                                          as ppWorkCenter,
      _FunctionalLocation.MainWorkCenter                                                                                                                        as mainWorkCenter,
      _FunctionalLocation.MainWorkCenterPlant                                                                                                                   as mainWorkCenterPlant,
      case when _FunctionalLocation.WoCenter is initial then cast( '' as abap.char( 8 )) else _FunctionalLocation.WoCenter end                                  as woCenter,
      _FunctionalLocation.MainAsset                                                                                                                             as mainAsset,
      _FunctionalLocation.SubAsset                                                                                                                              as subAsset,
      _FunctionalLocation.CostCenter                                                                                                                            as costCenter,
      case when _FunctionalLocation.WBSElement is initial then cast( '' as abap.char( 24 ) ) else cast( _FunctionalLocation.WBSElement as abap.char( 24 ) ) end as wBSElement,
      _FunctionalLocation.StandingOrder                                                                                                                         as standingOrder,
      _FunctionalLocation.SettlementOrder                                                                                                                       as settlementOrder,
      _FunctionalLocation.PlannerGroup                                                                                                                          as plannerGroup,
      _FunctionalLocation.CatalogProfile                                                                                                                        as catalogProfile,
      _FunctionalLocation.PositionObject                                                                                                                        as positionObject,
      _FunctionalLocation.InstallationAllowed                                                                                                                   as installationAllowed,
      _FunctionalLocation.SingleInstallation                                                                                                                    as singleInstallation,
      _FunctionalLocation.ConstructionType                                                                                                                      as constructionType,
      /* SimpleMDG specific fields for integration */
      case when FlocStatusDel.objnr is not null
      then cast( 'X' as boole_d ) else cast( ' ' as boole_d ) end                                                                                               as mdgMarkForDeletionStatus,
      case when FlocStatusDeact.objnr is not null
      then cast( 'X' as boole_d ) else cast( ' ' as boole_d ) end                                                                                               as mdgMarkForDeactivationStatus,
      cast( '' as abap.char( 50 ) )                                                                                                                             as action,
      cast( '' as abap.char( 1333 ) )                                                                                                                           as mdgMarkForChange,
      cast( '' as abap.char( 36 ) )                                                                                                                             as mdgLogID,
      cast( '' as abap.char( 50 ) )                                                                                                                             as actionMode,
      cast( '' as abap.char( 20 ) )                                                                                                                             as activateID,
      cast( '' as abap.char( 20 ) )                                                                                                                             as activateItemID,
      cast( '' as abap.char( 100 ) )                                                                                                                            as crNumber,
      cast( '' as abap.char( 100 ) )                                                                                                                            as crItem,

      _FunctionalLocationText,
      _FunctionalLocationAddess,
      _FunctionalLocationEquipment,
      _MeasuringPoint,
      _FlocStatus,
      _Classification
}

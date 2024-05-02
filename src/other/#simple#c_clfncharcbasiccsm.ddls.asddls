@AbapCatalog.sqlViewName: '/SIMPLE/ICHRB2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'ClassCharacteristicBasic'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
define view /SIMPLE/C_ClfnCharcBasicCsm
  as select from /SIMPLE/I_ClfnCharcBasic
{
  key CharcInternalID                as charcInternalID,
  key TimeIntervalNumber             as timeIntervalNumber,
      Characteristic                 as characteristic,
      CharcIdentificationCode        as charcIdentificationCode,
      CharcStatus                    as charcStatus,
      CharcDataType                  as charcDataType,
      CharcLength                    as charcLength,
      CharcDecimals                  as charcDecimals,
      CharcTemplate                  as charcTemplate,
      ValueIsCaseSensitive           as valueIsCaseSensitive,
      CharcConversionRoutine         as charcConversionRoutine,
      CharcGroup                     as charcGroup,
      EntryIsRequired                as entryIsRequired,
      MultipleValuesAreAllowed       as multipleValuesAreAllowed,
      CharcValueUnit                 as charcValueUnit,
      Currency                       as currency,
      CharcExponentFormat            as charcExponentFormat,
      CharcExponentValue             as charcExponentValue,
      ValueIntervalIsAllowed         as valueIntervalIsAllowed,
      AdditionalValueIsAllowed       as additionalValueIsAllowed,
      NegativeValueIsAllowed         as negativeValueIsAllowed,
      ValidityStartDate              as validityStartDate,
      ValidityEndDate                as validityEndDate,
      ChangeNumber                   as changeNumber,
      IsDeleted                      as isDeleted,
      DocumentInfoRecordDocType      as documentInfoRecordDocType,
      DocumentInfoRecordDocNumber    as documentInfoRecordDocNumber,
      DocumentInfoRecordDocVersion   as documentInfoRecordDocVersion,
      DocumentInfoRecordDocPart      as documentInfoRecordDocPart,
      CharcMaintAuthGrp              as charcMaintAuthGrp,
      CharcIsReadOnly                as charcIsReadOnly,
      CharcIsHidden                  as charcIsHidden,
      CharcReferenceTable            as charcReferenceTable,
      CharcReferenceTableField       as charcReferenceTableField,
      CharcCheckTable                as charcCheckTable,
      CharcCheckFunctionModule       as charcCheckFunctionModule,
      CharcEntryIsNotFormatCtrld     as charcEntryIsNotFormatCtrld,
      CharcTemplateIsDisplayed       as charcTemplateIsDisplayed,
      CharcSelectedSet               as charcSelectedSet,
      Plant                          as plant,
      CharcCatalogType               as charcCatalogType,
      CreatedByUser                  as createdByUser,
      CreationDate                   as creationDate,
      LastChangedByUser              as lastChangedByUser,
      LastChangeDate                 as lastChangeDate,
      CharcLastChangedDateTime       as charcLastChangedDateTime,
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange

}

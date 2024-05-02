@EndUserText.label: 'Business Partner Identification' //same as DDL description
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/IBUPAID' //must start with "I"
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_BuPaIdentification
  as select from but0id

  association [1..1] to /SIMPLE/I_BusinessPartner     as _BusinessPartner     on $projection.BusinessPartner = _BusinessPartner.BusinessPartner
{

  key partner     as BusinessPartner,
  key type        as BPIdentificationType,
  key idnumber    as BPIdentificationNumber,
      institute   as BPIdnNmbrIssuingInstitute,
      entry_date  as BPIdentificationEntryDate,
      country     as Country,
      region      as Region,
    //  but0ID.idnumber_guid as IdentificationUUID,
      valid_date_from as ValidityStartDate,
      valid_date_to as ValidityEndDate,
      _BusinessPartner.AuthorizationGroup as AuthorizationGroup,
      _BusinessPartner

}


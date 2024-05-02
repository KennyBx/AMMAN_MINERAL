@EndUserText.label: 'Business Partner Contact'
@Analytics.dataCategory: #DIMENSION //or #CUBE or #FACT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:  #CHECK //or #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/IBPCNT' //must start with "I"
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey:'RelationshipNumber'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true

define view /SIMPLE/I_BPContact
  as select from but050
  association [1..1] to /SIMPLE/I_BusinessPartner        as _BusinessPartnerCompany on  _BusinessPartnerCompany.BusinessPartner = $projection.BusinessPartnerCompany
  association [1..1] to /SIMPLE/I_BusinessPartner        as _BusinessPartnerPerson  on  _BusinessPartnerPerson.BusinessPartner = $projection.BusinessPartnerPerson
//  association [0..*] to /SIMPLE/I_BpContactToAddress     as _ContactAddress         on  $projection.RelationshipNumber     = _ContactAddress.RelationshipNumber
//                                                                            and $projection.BusinessPartnerCompany = _ContactAddress.BusinessPartnerCompany
//                                                                            and $projection.BusinessPartnerPerson  = _ContactAddress.BusinessPartnerPerson
//                                                                            and $projection.ValidityEndDate        = _ContactAddress.ValidityEndDate

//  association [0..1] to /SIMPLE/I_BPContactToFuncDept as _ContactRelationship    on  $projection.RelationshipNumber     = _ContactRelationship.RelationshipNumber
//                                                                            and $projection.BusinessPartnerCompany = _ContactRelationship.BusinessPartnerCompany
//                                                                            and $projection.BusinessPartnerPerson  = _ContactRelationship.BusinessPartnerPerson
//                                                                            and $projection.ValidityEndDate        = _ContactRelationship.ValidityEndDate




{
  key  but050.relnr                                    as             RelationshipNumber,
       @ObjectModel.foreignKey.association: '_BusinessPartnerCompany'
  key  partner1                                        as             BusinessPartnerCompany,
       @ObjectModel.foreignKey.association: '_BusinessPartnerPerson'
  key  partner2                                        as             BusinessPartnerPerson,
  key  date_to                                         as             ValidityEndDate,
       date_from                                       as             ValidityStartDate,
       xdfrel                                          as             IsStandardRelationship,
       reltyp                                          as             RelationshipCategory,

       /* Associations */
       _BusinessPartnerCompany,
       _BusinessPartnerPerson
       //  _BusinessPartnerPerson._CurrentDefaultAddress._StandardAddress,
//       _ContactAddress,
//       _ContactRelationship
       //_BusinessPartnerPerson._CurrentDefaultAddress._StandardAddress




}
where
  reltyp = 'BUR001'

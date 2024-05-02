@EndUserText.label: 'Business Partner assignment to BP Role' //same as DDL description
@Analytics.dataCategory: #DIMENSION //or #CUBE or #FACT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/IBPROLE' //must start with "I"
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey:'BusinessPartnerRole'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.personalData.blocking: #REQUIRED
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_BP_to_BP_Role
  as select from but100

//  association [0..1] to /SIMPLE/I_BusinessPartnerRole as _BusinessPartnerRole on $projection.BusinessPartnerRole = _BusinessPartnerRole.BusinessPartnerRole
  association [0..1] to I_BusinessPartner     as _BusinessPartner     on $projection.BusinessPartner = _BusinessPartner.BusinessPartner

{

  key but100.mandt as mandt,
//      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_BusinessPartnerVH',
//                     element: 'BusinessPartner' }
//        }]
//      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BusinessPartner'
  key but100.partner     as BusinessPartner,
      // @ObjectModel.text.association: '_BusinessPartnerRoleText'
  key but100.rltyp       as BusinessPartnerRole,

      but100.valid_from  as ValidFrom,
      but100.valid_to    as ValidTo,


      //        Association
//      _BusinessPartnerRole,
      _BusinessPartner.AuthorizationGroup,
      _BusinessPartner

}
where
  but100.dfval = ''

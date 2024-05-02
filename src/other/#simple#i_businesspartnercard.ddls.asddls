@AbapCatalog.sqlViewName: '/SIMPLE/IBPCARD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'core view for Bank details'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BUSINESSPARTNERCARD
  as select from but0cc as BusinessPartnerCard

  association [1..1] to /SIMPLE/I_BusinessPartner as _BusinessPartner on  $projection.BusinessPartner = _BusinessPartner.BusinessPartner

  association [1..1] to /SIMPLE/I_CARD            as _Card    
                                                              on  $projection.CardNumber     = _Card.CardNumber
                                            //                  and $projection.CardType = _Card.CardType
{
  key BusinessPartnerCard.partner                                            as  BusinessPartner,
  key BusinessPartnerCard.ccard_id                                           as  PaymentCardID,
      BusinessPartnerCard.ccins                                              as  CardType,
      BusinessPartnerCard.ccnum                                              as  CardNumber,
      BusinessPartnerCard.ccdef                                              as  StandardCard,
      BusinessPartnerCard.ccaccname                                          as  CardDetail,
      BusinessPartnerCard.card_guid                                          as  CardGuid,
      _Card,
      _Card.ValidFrom                                              as  ValidFrom,
      _Card.ValidTo                                              as  ValidTo,
      _Card.IssuingBank                                            as  IssuingBank,
      _Card.NameOfCardholder                                            as  NameOfCardHolder,
      _Card.DateOfIssue                                            as  DateOfIssue,
      _Card.CardCategory                                            as  CardCategory,
  //    _Card.MaskNummber                                         as  MaskNumber,
      _Card.MaskNumber                                         as  MaskNumber,
      _Card.BlockingReason                                             as  BlockingReason
}

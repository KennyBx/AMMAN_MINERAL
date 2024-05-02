@AbapCatalog.sqlViewName: '/SIMPLE/ICARD'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'core view for card details'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_CARD
  as select from ccard as Card

{
  key Card.ccnum                                              as  CardNumber,
  key Card.ccins                                              as  CardType,
      Card.datab                                              as  ValidFrom,
      Card.datbi                                              as  ValidTo,
      Card.issbank                                            as  IssuingBank,
      Card.ccname                                             as  NameOfCardholder,
      Card.ausgdat                                            as  DateOfIssue,
      Card.masked_id                                          as  MaskNumber,
      Card.cctyp                                              as  CardCategory,
      Card.cclock                                             as  BlockingReason
}

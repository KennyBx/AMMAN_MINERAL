@AbapCatalog.sqlViewName: '/SIMPLE/ICREPRO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'Credit Profile Basic View'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BPCreditProfile as select from ukmbp_cms {
    key partner                 as BusinessPartner,
    key own_rating              as OwnRating,  
    check_rule                  as CheckRule,
    limit_rule                  as LimitRule,
    rating_val_date             as RatingValueDate,
    rating_chg_date             as RatingChangeDate,
    alternate_bp                as AlternateBP,
    own_rating_calc             as OwnRatingCalc,
    risk_class                  as RiskClass,
    risk_class_calc             as RiskClassCalc,
    risk_class_chgdt            as RiskClassChangeDate,
    credit_group                as CreditGroup
}

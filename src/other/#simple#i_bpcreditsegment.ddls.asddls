@AbapCatalog.sqlViewName: '/SIMPLE/BUCRESEG'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'Credit Segment Basic View'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BPCreditSegment as select from ukmbp_cms_sgm {
    key partner                 as BusinessPartner,
    key credit_sgmnt            as CreditSegment,  
    credit_limit                as CreditLimit,
    xblocked                    as IsBlocked,
    limit_valid_date            as LimitValidDate,
    limit_chg_date              as LimitChangeDate,
    coordinator                 as Coordinator,
    cust_group                  as CustGroup,
    follow_up_dt                as FollowUpDate,
    cred_lim_calc               as CreditLimitCal,
    xcritical                   as IsCritical,
    x_limit_zero                as IsLimitZero,
    block_reason                as BlockReason,
    cred_lim_req                as CreditLimitReq,
    automatic_req               as IsAutomaticReq,
    lim_val_date_req            as ValidToDate,
    req_date                    as ReqDate,
    item_error                  as IsItemError,
    log_hndl                    as LogHNDL
}

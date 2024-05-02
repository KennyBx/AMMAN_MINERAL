@AbapCatalog.sqlViewName: '/SIMPLE/MDWC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Work Center'
define view /SIMPLE/MDWORKCENTER
  as select from    crhd
    left outer join crco as t1 on  t1.objid = crhd.objid
                               and t1.objty = crhd.objty
                               and t1.lanum = '0001'
                               and t1.endda >= $session.system_date
    left outer join crco as t2 on  t2.objid = crhd.objid
                               and t2.objty = crhd.objty
                               and t2.lanum = '0002'
                               and t2.endda >= $session.system_date
    left outer join crco as t3 on  t3.objid = crhd.objid
                               and t3.objty = crhd.objty
                               and t3.lanum = '0003'
                               and t3.endda >= $session.system_date
    left outer join crco as t4 on  t4.objid = crhd.objid
                               and t4.objty = crhd.objty
                               and t4.lanum = '0004'
                               and t4.endda >= $session.system_date
    left outer join crco as t5 on  t5.objid = crhd.objid
                               and t5.objty = crhd.objty
                               and t5.lanum = '0005'
                               and t5.endda >= $session.system_date
    left outer join crco as t6 on  t6.objid = crhd.objid
                               and t6.objty = crhd.objty
                               and t6.lanum = '0006'
                               and t6.endda >= $session.system_date
  association [0..1] to /SIMPLE/I_WorkCenterText as _TextSys on  crhd.objid        = _TextSys.WorkCenterInternalID
                                                             and crhd.objty        = _TextSys.WorkCenterTypeCode
                                                             and _TextSys.Language = $session.system_language
  association [0..1] to /SIMPLE/I_WorkCenterText as _TextEN  on  crhd.objid       = _TextEN.WorkCenterInternalID
                                                             and crhd.objty       = _TextEN.WorkCenterTypeCode
                                                             and _TextEN.Language = 'E'
{
  key crhd.objid                                    as workCenterInternalID,
  key crhd.objty                                    as workCenterTypeCode,
  key case when _TextSys.Language is not initial
      then _TextSys.Language
      else _TextEN.Language end                     as locale,

      cast(crhd.arbpl as pph_arbpl preserving type) as workCenter,

      crhd.werks                                    as plant,

      case when _TextSys.Language is not initial
          then _TextSys.WorkCenterText
          else _TextEN.WorkCenterText end           as description,

      t1.lstar                                      as parameter1,
      t2.lstar                                      as parameter2,
      t3.lstar                                      as parameter3,
      t4.lstar                                      as parameter4,
      t5.lstar                                      as parameter5,
      t6.lstar                                      as parameter6,
      crhd.vge01                                    as unit1,
      crhd.vge02                                    as unit2,
      crhd.vge03                                    as unit3,
      crhd.vge04                                    as unit4,
      crhd.vge05                                    as unit5,
      crhd.vge06                                    as unit6,
      crhd.parv1                                    as value1,
      crhd.parv2                                    as value2,
      crhd.parv3                                    as value3,
      crhd.parv4                                    as value4,
      crhd.parv5                                    as value5,
      crhd.parv6                                    as value6,
      crhd.vgm01                                    as rule1,
      crhd.vgm02                                    as rule2,
      crhd.vgm03                                    as rule3,
      crhd.vgm04                                    as rule4,
      crhd.vgm05                                    as rule5,
      crhd.vgm06                                    as rule6,
      crhd.steus                                    as controlKey,
      crhd.ktsch                                    as standardTextKey,
      crhd.qualf                                    as suitability,
      crhd.rasch                                    as setupTypeKey,
      crhd.loart                                    as wageType,
      crhd.logrp                                    as wageGroup,
      crhd.loanz                                    as numberOfTimeTickets,
      crhd.rsanz                                    as numberOfConfirmationSlips,
      crhd.steus_ref                                as controlKeyRef,
      crhd.ktsch_ref                                as standardTextKeyRef,
      crhd.qualf_ref                                as suitabilityRef,
      crhd.rasch_ref                                as setupTypeKeyRef,
      crhd.loart_ref                                as wageTypeRef,
      crhd.logrp_ref                                as wageGroupRef,
      crhd.loanz_ref                                as numberOfTimeTicketsRef,
      crhd.rsanz                                    as numberOfConfirmationSlipsRef

}
//where
//      t1.endda >= $session.system_date
//  and t2.endda >= $session.system_date
//  and t3.endda >= $session.system_date
//  and t4.endda >= $session.system_date
//  and t5.endda >= $session.system_date
//  and t6.endda >= $session.system_date

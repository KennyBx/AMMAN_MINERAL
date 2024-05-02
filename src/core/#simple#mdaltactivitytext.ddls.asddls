@AbapCatalog.sqlViewName: '/SIMPLE/MDALTACT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Alt.Activity Text'
define view /SIMPLE/MDALTACTIVITYTEXT
  as select from    /SIMPLE/I_StdWorkFmlaPG as a
    left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam1
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,
      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
  left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam2
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,

      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
  left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam3
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,

      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
  left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam4
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,

      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
  left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam5
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,

      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
  left outer join /SIMPLE/I_StdWorkFP     as b on b.StandardWorkFormulaParameter = a.StandardWorkFormulaParam6
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key b.StandardWorkFormulaParameter  as standardWorkFormulaParameter,
  key case when b._TextSysLanguage.Language is not initial
      then b._TextSysLanguage.Language
      when b._TextEnLanguage.Language is not initial
      then b._TextEnLanguage.Language
      else 'E'
      end                             as locale,

      case when b._TextSysLanguage.Language is not initial
          then b._TextSysLanguage.StandardWorkFormulaParamName
          else b._TextEnLanguage.StandardWorkFormulaParamName
          end                         as description
}
where
  StandardWorkFormulaParameter <> ''

union select from /SIMPLE/I_StdWorkFmlaPG as a
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key '%%%1'                          as standardWorkFormulaParameter,
  key 'E'                             as locale,
      'Standard Value Text'           as description
}

union select from /SIMPLE/I_StdWorkFmlaPG as a
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key '%%%2'                          as standardWorkFormulaParameter,
  key 'E'                             as locale,
      'Activity Type Text'            as description
}

union select from /SIMPLE/I_StdWorkFmlaPG as a
{
  key a.StandardWorkFormulaParamGroup as standardWorkFormulaParamGroup,
  key '%%%3'                          as standardWorkFormulaParameter,
  key 'E'                             as locale,
      'No Activity'                   as description
}

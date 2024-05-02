@AbapCatalog.sqlViewName: '/SIMPLE/MDAENR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master'
define view /SIMPLE/MDCHANGENUMBER
  as select from    aenr as aenr
    left outer join aenv as aenv on aenr.aennr = aenv.aennr
  //    left outer join tcc01 as tcc01 on aenv.aetyp = tcc01.aetyp

{
  key aenr.aennr as changeNumber,
      aenv.aetyp as objectType,
      aenr.aetxt as description,
      aenr.annam as createdBy,
      aenr.datuv as validFrom,
      aenr.ccart as changeType,
      aenr.aenst as changeNoStatus,
      aenr.aenbe as authorizationGroup,
      aenr.aefun as function,
      aenv.aeerl as isActivate,
      //      case aenv.aetyp   "Start Insert 12112023 - FLE
      //      when '01'
      //      then 'X'
      //      else ''
      //      end        as isActivateBOM,  "End Insert 12112023 - FLE
      case aenv.aetyp
      when '41'
      then 'X'
      else ''
      end        as isActivateMaterial
      //      case aenv.aetyp          "Start Insert 12112023 - FLE
      //      when '11'
      //      then 'X'
      //      else ''
      //      end        as isActivateTaskList,
      //      case aenv.aetyp
      //      when '51'
      //      then 'X'
      //      else ''
      //      end        as isActivateCharacteristic,
      //
      //      case aenv.aetyp
      //      when '52'
      //      then 'X'
      //      else ''
      //      end        as isActivateClassChars   "End Insert 12112023 - FLE

}
//where
//       aenv.aeerl = 'X'
//  and(
//       aenv.aetyp = '01' // BOM
//    or aenv.aetyp = '41' // Material
//    or aenv.aetyp = '11' // TaskList
//    or aenv.aetyp = '51' // Characteristic
//    or aenv.aetyp = '52' // Characteristics of Class

//  )

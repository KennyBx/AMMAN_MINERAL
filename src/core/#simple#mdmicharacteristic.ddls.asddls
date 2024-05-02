@AbapCatalog.sqlViewName: '/SIMPLE/MDMIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Onpremise MIC'
define view /SIMPLE/MDMICHARACTERISTIC
  as select from    qpmk
    left outer join qpmt on  qpmk.zaehler = qpmt.zaehler
                         and qpmk.mkmnr   = qpmt.mkmnr
                         and qpmk.version = qpmt.version
    left outer join qpmz on  qpmk.zaehler = qpmz.zaehler
                         and qpmk.mkmnr   = qpmz.mkmnr
                         and qpmk.version = qpmz.version
{
  key qpmk.zaehler    as plant,
  key qpmk.mkmnr      as masterInspectionCharacteristc,
  key qpmk.version    as version,
      qpmk.gueltigab  as validFrom,
      qpmk.sortfeld   as searchField,
      qpmt.sprache    as locale,
      qpmt.kurztext   as shortText,
      // JHOANG add fields for TaskList MIC - 5/5/2022 - start
      qpmk.merkgew    as weightingOfCharacteristic,
      qpmk.prfql      as inspectorQualification,
      qpmk.dummy10    as infoField1,
      qpmk.dummy20    as infoField2,
      qpmk.dummy40    as infoField3,
      qpmk.qauth      as authorizationGroup,
      qpmk.toleranzsl as toleranceKey,
      qpmk.stellen    as decimalPlaces,
      qpmk.masseinhsw as unitOfMeasurement,
      qpmk.sollwert   as targetValue,
      qpmk.toleranzob as upperSpecification,
      qpmk.toleranzun as lowerSpecification,
      qpmk.grenzeob1  as firstUpperLimit,
      qpmk.grenzeun1  as firstLowerLimit,
      qpmk.grenzeob2  as secondUpperLimit,
      qpmk.grenzeun2  as secondLowerLimit,
      qpmk.plausioben as upperPlausibilityLimit,
      qpmk.plausiunte as lowerPlausibilityLimit,
      qpmk.tolerweiob as upperSpecificatioLimitChange,
      qpmk.tolerweiun as lowerSpecificatioLimitChange,
      qpmk.tolerwab   as toleranceChangeValidFrom,
      qpmk.tolerwbis  as toleranceChangeValidTo,
      qpmk.codegr9u   as lowerLimitDefCodeGrp,
      qpmk.code9u     as atLowerSpecificationLimit,
      qpmk.codegrqual as defectCodeGroupGenRejection,
      qpmk.codequal   as defectCode,
      qpmk.codegr9o   as upperLimitDefectGroup,
      qpmk.code9o     as atUpperSpecificationLimit,
      qpmk.eeantverf  as fractionCalculation,
      qpmk.loekz      as status,
      
      case left(steuerkz, 1 )
      when ' ' then 'X'
      else ' '
      end             as qualitative,

      case left(steuerkz, 1 )
      when 'X' then 'X'
      else ' '
      end             as quantitative,
      // Char 2
      case substring(steuerkz, 2, 1)
      when 'X' then 'X'
      else ' '
      end             as recordMeasured,
      // Char 3
      case substring(steuerkz, 3, 1)
      when 'X' then 'X'
      else ' '
      end             as characteristicAttributes,
      // Char 4
      case substring(steuerkz, 4, 1)
      when 'X' then 'X'
      else ' '
      end             as upperSpecificationLimit,
      // Char 5
      case substring(steuerkz, 5, 1)
      when 'X' then 'X'
      else ' '
      end             as lowerSpecificationLimit,
      // Char 6
      case substring(steuerkz, 6, 1)
      when 'X' then 'X'
      else ' '
      end             as checkTargetValue,
      // Char 7 - scope smaller
      case substring(steuerkz, 7, 1)
      when '<' then 'X'
      else ' '
      end             as smallerScope,
      // Char 7 - scope larger
      case substring(steuerkz, 7, 1)
      when '>' then 'X'
      else ' '
      end             as largerScope,
      // Char 7 - fixed scope
      case substring(steuerkz, 7, 1)
      when '=' then 'X'
      else ' '
      end             as fixedScope,
      // Char 7 - no scope
      case substring(steuerkz, 7, 1)
      when ' ' then 'X'
      else ' '
      end             as noScope,
      // Char 8 - long term inspection
      case substring(steuerkz, 8, 1)
      when 'X' then 'X'
      else ' '
      end             as longTermInspection,
      // Char 9 - Recording type Summarized
      case substring(steuerkz, 9, 1)
      when ' ' then 'X'
      else ' '
      end             as summarizedCharRecording,

      // Char 9 - Recording type Single
      case substring(steuerkz, 9, 1)
      when '+' then 'X'
      else ' '
      end             as singleCharRecording,

      // Char 9 - Recording type No Recording
      case substring(steuerkz, 9, 1)
      when '-' then 'X'
      else ' '
      end             as noCharRecording,

      // Char 9 - Recording type Classed Recording
      case substring(steuerkz, 9, 1)
      when '*' then 'X'
      else ' '
      end             as classedCharRecording,

      // Char 10 - Document Confirmation - No Document
      case substring(steuerkz, 10, 1)
      when ' ' then 'X'
      else ' '
      end             as noDocumentationRequired,

      // Char 10 - Document Confirmation - Required
      case substring(steuerkz, 10, 1)
      when '+' then 'X'
      else ' '
      end             as documentationRequired,

      // Char 10 - Document Confirmation - Rejected
      case substring(steuerkz, 10, 1)
      when '.' then 'X'
      else ' '
      end             as documentationRejected,

      // Char 11 - OptionalCharacteristic Category - Results Confirmation - OPTIONAL
      case substring(steuerkz, 11, 1)
      when ' ' then 'X'
      else ' '
      end             as optionalCharacteristic,

      // Char 11 - OptionalCharacteristic Category - Results Confirmation - REQUIRED
      case substring(steuerkz, 11, 1)
      when 'X' then 'X'
      else ' '
      end             as requiredCharacteristic,

      // Char 11 - OptionalCharacteristic Category - Results Confirmation - after acceptance
      case substring(steuerkz, 11, 1)
      when '+' then 'X'
      else ' '
      end             as conditionalCharAfterAcceptance,

      // Char 11 - OptionalCharacteristic Category - Results Confirmation - after rejection
      case substring(steuerkz, 11, 1)
      when '-' then 'X'
      else ' '
      end             as conditionalCharAfterRejection,

      // Char 12 - Synchronization is Active
      case substring(steuerkz, 12, 1)
      when 'X' then 'X'
      else ' '
      end             as synchronizationActive,

      // Char 13: Additive characteristic - Qualitative characteristic Additive Sample
      case substring(steuerkz, 13, 1)
      when 'X' then 'X'
      else ' '
      end             as additiveCharac,

      // Char 14: Destructive characteristic - Qualitative characteristic Destructive Sample
      case substring(steuerkz, 14, 1)
      when 'X' then 'X'
      else ' '
      end             as destructiveCharac,

      // Char 15: Formula - Quantitative characteristic Formula #NEED - No Formula
      case substring(steuerkz, 15, 1)
      when ' ' then 'X'
      else ' '
      end             as noFormula,

      // Char 15: Formula - Quantitative characteristic Formula #NEED - Calculated Charc
      case substring(steuerkz, 15, 1)
      when 'X' then 'X'
      else ' '
      end             as calculatedCharc,

      // Char 15: Formula - Quantitative characteristic Formula #NEED - No Formula
      case substring(steuerkz, 15, 1)
      when '1' then 'X'
      else ' '
      end             as inputProcessingIndicator,

      // Char 16: Sampling processing - Sample
      case substring(steuerkz, 16, 1)
      when 'X' then 'X'
      else ' '
      end             as samplingProcedure,

      // Char 17: Scrap Share/Q score - Miscellaneous-
      case substring(steuerkz, 17, 1)
      when 'X' then 'X'
      else ' '
      end             as scrapShare,
      // Char 18: Fixed - Control indicators can not be changed
      case substring(steuerkz, 18, 1)
      when 'X' then 'X'
      else ' '
      end             as fixed,

      // Char 19: Recording the Number of Defects
      case substring(steuerkz, 19, 1)
      when 'X' then 'X'
      else ' '
      end             as recordNumberDefects,

      // Char 20: Subsystem - For control stations – Not QM relevant
      case substring(steuerkz, 20, 1)
      when 'X' then 'X'
      else ' '
      end             as subSystem,


      // Char 21: Specifications - Can Change specs
      case substring(steuerkz, 21, 1)
      when 'X' then 'X'
      else ' '
      end             as specifications,

      // Char 22: Test Equipment - Miscellaneous-
      case substring(steuerkz, 22, 1)
      when 'X' then 'X'
      else ' '
      end             as testEquipment,

      // Char 23: Defects Recording - Sample
      case substring(steuerkz, 23, 1)
      when 'X' then 'X'
      else ' '
      end             as defectRecording,

      // Char 24: RR Change Docs - Sample -
      case substring(steuerkz, 24, 1)
      when 'X' then 'X'
      else ' '
      end             as rrChangeDocs,

      // Char 25: SPC charac - Sample
      case substring(steuerkz, 25, 1)
      when 'X' then 'X'
      else ' '
      end             as spcCharacteristic,

      // Char 26: Print #NEED
      case substring(steuerkz, 26, 1)
      when ' ' then 'X'
      else ' '
      end             as inspectionCharPrinted,

      // Char 26: Do not print #NEED
      case substring(steuerkz, 26, 1)
      when 'X' then 'X'
      else ' '
      end             as inspectionCharNotPrinted,

      // Char 26: Do not Print at Skip Stage #NEED
      case substring(steuerkz, 26, 1)
      when '*' then 'X'
      else ' '
      end             as inspCharNotPrintedSkipStage,

      // Char 27: Parameter Characteristic - Can be used as a Parameter characteristic
      case substring(steuerkz, 27, 1)
      when 'X' then 'X'
      else ' '
      end             as parameterCharacteristic,

      // Char 28: Parameter Characteristic - Characteristic of a the process
      case substring(steuerkz, 28, 1)
      when 'X' then 'X'
      else ' '
      end             as processCharacteristic,
      
      qpmz.pmethode   as inspectionMethod,
      qpmz.verspm     as inspectionMethodVersion,
      qpmz.werkpm     as inspectionMethodPlant,
      qpmz.katab1     as selectedSet1,
      qpmz.katalgart1 as catalogType1,
      qpmz.auswmenge1 as codeGroupSelectedSet1,
      qpmz.version1   as version1,
      qpmz.auswmgwrk1 as plant1,
      qpmz.katab2     as selectedSet2,
      qpmz.katalgart2 as catalogType2,
      qpmz.auswmenge2 as codeGroupSelectedSet2,
      qpmz.version2   as version2,
      qpmz.auswmgwrk2 as plant2,
      qpmz.katab3     as selectedSet3,
      qpmz.katalgart3 as catalogType3,
      qpmz.auswmenge3 as codeGroupSelectedSet3,
      qpmz.version3   as version3,
      qpmz.auswmgwrk3 as plant3,
      qpmz.katab4     as selectedSet4,
      qpmz.katalgart4 as catalogType4,
      qpmz.auswmenge4 as codeGroupSelectedSet4,
      qpmz.version4   as version4,
      qpmz.auswmgwrk4 as plant4,
      qpmz.katab5     as selectedSet5,
      qpmz.katalgart5 as catalogType5,
      qpmz.auswmenge5 as codeGroupSelectedSet5,
      qpmz.version5   as version5,
      qpmz.auswmgwrk5 as plant5   
      // JHOANG add fields for TaskList MIC - 5/5/2022 - start
}

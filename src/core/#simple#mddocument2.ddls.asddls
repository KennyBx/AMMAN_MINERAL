@AbapCatalog.sqlViewName: '/SIMPLE/MDDO2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Document Info Record'
define view /SIMPLE/MDDOCUMENT2 as select from /SIMPLE/MDDOCUMENT {
    key DocType as docType,
    key DocNumber as docNumber,
    key DocVersion as docVersion,
    key DocPart as docPart,
    key Locale as locale,
    Description as description
}

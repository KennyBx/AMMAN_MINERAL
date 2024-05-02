@AbapCatalog.sqlViewName: '/SIMPLE/IDIROT'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Document Info Record Object Link Text'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type : #INHERITED
@ObjectModel.representativeKey: 'LinkedSAPObject'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #M, dataClass: #CUSTOMIZING }

define view /SIMPLE/I_DocInfoRcdObjLinkT
  as select from tdwot

//  association [0..*] to /SIMPLE/I_DocInfoRcdObjLinkVH as _ObjLink  on $projection.LinkedSAPObject = _ObjLink.LinkedSAPObject

//  association [0..1] to /SIMPLE/I_Language            as _Language on $projection.Language = _Language.Language
{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key tdwot.langu as Language,
      @Consumption.valueHelpDefinition.association: '_ObjLink'
      @ObjectModel.text.element: 'ObjectDescription'
  key tdwot.dokob as LinkedSAPObject,
      @Semantics.text: true
      tdwot.ktxt  as ObjectDescription,
      tdwot.objab as ObjectType

      //Associations
//      _Language,
//      _ObjLink
}

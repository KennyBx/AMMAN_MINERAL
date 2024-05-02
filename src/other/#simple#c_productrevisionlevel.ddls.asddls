@AbapCatalog.sqlViewName: '/SIMPLE/CPRDAEOI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ProductRevisionLevel'
define view /SIMPLE/C_ProductRevisionLevel
  as select from aeoi as RevisionLevel
  association to parent /SIMPLE/C_Product as _Product on $projection.product = _Product.product
{
  key RevisionLevel.objkt                           as product,
  key RevisionLevel.aennr                           as engineeringChangeManagement,
      RevisionLevel.ccvms                           as indicatorPlannedRecord,
      RevisionLevel.oitxt                           as description,
      RevisionLevel.ltxsp                           as longText,
      RevisionLevel.aedat                           as lastChangedAt,
      RevisionLevel.aenam                           as lastChangedBy,
      RevisionLevel.andat                           as createdAt,
      RevisionLevel.annam                           as createdBy,
      RevisionLevel.objdt                           as objectLastChangedAt,
      RevisionLevel.objnm                           as objectLastChangeBy,
      RevisionLevel.cclck                           as objectLockedForChange,
      RevisionLevel.aeost                           as baselining,
      cast( RevisionLevel.revlv as abap.char( 2 ) ) as revisionLevel,
      RevisionLevel.aedtz                           as alternativeDate,
      RevisionLevel.ccsto                           as status,
      RevisionLevel.ccoaa                           as changeType,
      RevisionLevel.cont1                           as degitalSignature,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )                 as action,
      cast( '' as abap.char( 1333 ) )               as mdgMarkForChange,

      _Product
}
where
  RevisionLevel.aetyp = '41'

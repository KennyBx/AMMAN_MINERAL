@AbapCatalog.sqlViewName: '/SIMPLE/IPRDQM'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product QM active core entity'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_Productqm
  as select from mara

  association [0..1] to E_Product as _ProductExt on mara.matnr = _ProductExt.Product
{
  key mara.matnr as Product,
      mara.qmpur as QltyMgmtInProcmtIsActive,
      mara.begru as AuthorizationGroup,
      // new fields for unified api
      mara.rbnrm as CatalogProfile
}

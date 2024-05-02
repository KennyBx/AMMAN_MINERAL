@EndUserText.label: 'Settlement Type'
@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_MDSETTLEMENTTYPE'
define custom entity /SIMPLE/MDSettlementType
{
  key investmentMeasureProfile : im_profil;
  key settlementType           : perbz3;
  key locale                   : spras;
      description              : val_text;
}

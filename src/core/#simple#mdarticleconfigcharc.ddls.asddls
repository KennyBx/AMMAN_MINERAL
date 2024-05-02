@EndUserText.label: '/SIMPLE/MDArticleConfigCharc'
@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_ARTICLECONFIGCHARC'
define custom entity /SIMPLE/MDArticleConfigCharc
{
  key variantNumber    : matnr;
  key variantID        : numc04;
      class            : klasse_d;
      classType        : klassenart;
      characteristic_1 : atnam;
      value_1          : atwrt;
      characteristic_2 : atnam;
      value_2          : atwrt;
      characteristic_3 : atnam;
      value_3          : atwrt;

}

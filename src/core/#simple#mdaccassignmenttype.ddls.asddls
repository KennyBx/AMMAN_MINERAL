@EndUserText.label: 'Settlement Type'
@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_MDACCASSIGNMENTTYPE'
define custom entity /SIMPLE/MDAccAssignmentType
{
  key orderType             : aufart;
  key accountAssignmentType : abap.char( 2 );
  key locale                : spras;
      description           : j_text60;
}

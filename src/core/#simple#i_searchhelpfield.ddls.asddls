@EndUserText.label: '[MDG] F4 - Search Help Select Field'
define custom entity /SIMPLE/I_SearchHelpField
{
  key MultipleKey        : abap.char( 20 );
  key RequestKey         : abap.char( 20 );
  key DummyKey           : abap.char( 20 );
      TableName          : abap.string( 0 );
      TechnicalFieldName : abap.string( 0 );
      FieldName          : abap.string( 0 );
      FieldType          : abap.string( 0 );
      _SearchHelp        : association to parent /simple/i_searchhelp on  _SearchHelp.MultipleKey = $projection.MultipleKey
                                                                      and _SearchHelp.RequestKey  = $projection.RequestKey
                                                                      and _SearchHelp.DummyKey    = $projection.DummyKey;

}

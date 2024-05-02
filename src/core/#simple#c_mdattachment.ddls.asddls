@EndUserText.label: 'SimpleMDG MD Table to read Attachments'
define root custom entity /SIMPLE/C_MDATTACHMENT
{
  key uuid     : abap.string;
      @Semantics.largeObject:
      {    mimeType: 'mimeType',
        fileName : 'filename',
      contentDispositionPreference: #INLINE   }
      value    : abap.rawstring;
      @Semantics.mimeType: true
      mimeType : abap.string;
      filename : abap.string;
}

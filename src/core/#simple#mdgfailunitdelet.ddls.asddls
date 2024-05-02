@EndUserText.label: 'GFAILUNIT DELETE'
@ObjectModel.query.implementedBy: 'ABAP:/SIMPLE/Q_MDGFAILUNITDELET'
define custom entity /SIMPLE/MDGFAILUNITDELET
{
  key unitid        : bgrfc_unit_id;
      status        : char50;
      systemid      : char30;
      mdglogid      : char36;
      message       : bgrfc_exe_message;
      messageid     : symsgid;
      messagenumber : symsgno;
      messagev1     : symsgv;
      messagev2     : symsgv;
      messagev3     : symsgv;
      messagev4     : symsgv;
      queuename     : bgrfc_dest_name_inbound;
      programname   : program;
}

CLASS /simple/bp_c_event_mesh DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF /simple/c_event_mesh.
  PUBLIC SECTION.
    CLASS-METHODS:
      _send_event IMPORTING is_log TYPE /simple/api_log iv_status TYPE string.
ENDCLASS.

CLASS /simple/bp_c_event_mesh IMPLEMENTATION.
  METHOD _send_event.
    DATA:
      meth   TYPE string,
      ls_log TYPE /simple/abs_event_mesh.

*    ls_log-mdglogid            = is_log-mdglogid             .
    ls_log-crnumber            = is_log-cr_number            .
    ls_log-critem              = is_log-cr_item              .
    ls_log-objtype             = is_log-obj_type             .
    ls_log-mdgkey              = is_log-mdg_key              .
    ls_log-status              = is_log-status               .
    ls_log-step                = is_log-step                 .
    ls_log-messagelog          = is_log-message_log          .
    ls_log-additionalmessage   = is_log-additional_message   .
    ls_log-activateid          = is_log-activate_id          .
    ls_log-activateitemid      = is_log-activate_item_id     .
    ls_log-changedat           = is_log-changedat            .
    ls_log-changetim           = is_log-changetim            .
    ls_log-statuslog           = is_log-status_log           .
    ls_log-statuscode          = is_log-status_code          .
    ls_log-timerun             = is_log-time_run             .
    ls_log-messagingcore       = is_log-messaging_core       .
    ls_log-messagingobjecttype = is_log-messaging_object_type.
    ls_log-resonlog            = is_log-reson_log            .

    CASE iv_status.
      WHEN 'SAPTestRunPassed'.
        CASE is_log-messaging_core.
          WHEN 'messaging_core_2'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core2_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_3'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core3_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_4'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core4_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_5'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core5_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_6'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core6_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN OTHERS.
            RAISE ENTITY EVENT /simple/c_event_mesh~core1_saptestrunpassed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
        ENDCASE.
      WHEN 'SAPTestRunFailed'.
        CASE is_log-messaging_core.
          WHEN 'messaging_core_2'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core2_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_3'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core3_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_4'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core4_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_5'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core5_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_6'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core6_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN OTHERS.
            RAISE ENTITY EVENT /simple/c_event_mesh~core1_saptestrunfailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
        ENDCASE.
      WHEN 'SAPActivateFailed'.
        CASE is_log-messaging_core.
          WHEN 'messaging_core_2'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core2_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_3'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core3_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_4'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core4_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_5'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core5_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_6'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core6_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN OTHERS.
            RAISE ENTITY EVENT /simple/c_event_mesh~core1_sapactivatefailed
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
        ENDCASE.
      WHEN 'SAPActivated'.
        CASE is_log-messaging_core.
          WHEN 'messaging_core_2'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core2_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_3'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core3_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_4'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core4_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_5'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core5_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN 'messaging_core_6'.
            RAISE ENTITY EVENT /simple/c_event_mesh~core6_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
          WHEN OTHERS.
            RAISE ENTITY EVENT /simple/c_event_mesh~core1_sapactivated
            FROM VALUE #( ( mdglogid = is_log-mdglogid %param = CORRESPONDING #( ls_log ) ) ).
        ENDCASE.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.

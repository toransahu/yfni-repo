 FUNCTION CanadaMicro3 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro3
       --

		-- CanadaMicro3
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 5, to "0 "; (no decimal)
		-- •	(b) if 5 <= value > 50, then round to nearest 10; for example 5 rounds to 10, 25 rounds to 30 and 49 rounds to 50  (no decimal)                                                                                                                                                                                  
		-- •	(c) if 50 <= value > 250, then round to nearest 50; for example 62.4 rounds to 50, 62.5 rounds to 75, and 225 rounds to 250  (no decimal)
		-- •	(d) if value is=> 250, then round to nearest 100.  for example 250 rounds to 300, 349 rounds to 300, and 350 rounds to 400  (no decimal)

		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro3 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro3 ');

       SELECT
          CASE
             WHEN anvalue < 5 THEN 0
             WHEN (anvalue >= 5 AND anvalue < 50) 
             THEN RoundNear(anvalue, 10)
             WHEN (anvalue >= 50 AND anvalue < 250)
             THEN RoundNear(anvalue, 50)
             WHEN (anvalue >= 250)
             THEN RoundNear(anvalue, 100)
             ELSE
                anvalue
          END
          INTO lsoutval
          FROM DUAL;

       LSOUTVAL := TO_CHAR (LSOUTVAL);
       RETURN lsoutval;
    EXCEPTION
       WHEN OTHERS
       THEN
          aapigeneral.logerror (
             assource    => gssource,
             asmethod    => lsmethod,
             asmessage   => 'aapiSpecification.CanadaMicro3 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro3;
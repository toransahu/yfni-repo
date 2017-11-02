 FUNCTION CanadaMicro4 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro4
       --

		-- CanadaMicro4
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 0.1, to "0"; (no decimal)
		-- •	(b) if 0.1 <= value > 1, then round to nearest 0.2; for example 0.10 rounds to 0.2, 0.29 rounds to 2, and 0.30 rounds to 0.4. (one decimal)                                                                                                                                                                                 
		-- •	(c) if 1 <= value > 5, then round to nearest 0.5; for example 1.24 rounds to 1.0, 1.25 rounds to 1.5 and 3.9 rounds to 4.0.   (one decimal)                                                                                                                                                                 
		-- •	(d) if value is=> 5 or more then round to nearest 1. for example 5.49 rounds to 5, 5.50 rounds to 6 and 7.24 rounds to 7 (no decimal)                                                                                                                                                                                 


		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro4 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro4 ');

       SELECT
          CASE
             WHEN anvalue < 0.1 THEN 0
             WHEN (anvalue >= 0.1 AND anvalue < 1) 
             THEN RoundNear(anvalue, 0.2)
             WHEN (anvalue >= 1 AND anvalue < 5)
             THEN RoundNear(anvalue, 0.5)
             WHEN (anvalue >= 5)
             THEN RoundNear(anvalue, 1)
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
             asmessage   => 'aapiSpecification.CanadaMicro4 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro4;
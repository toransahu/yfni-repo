 FUNCTION CanadaMicro7 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro7
       --

		-- CanadaMicro7
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 0.01, to "0"; (no decimal)
		-- •	(b) if 0.01 <= value > 0.1, then round to nearest 0.02; for example 0.01 rounds to 0.02, 0.029 rounds to 0.02, and 0.030 rounds to 0.04. (two decimals)                                                                                                                                                                                 
		-- •	(c) if it is 0.1 <= value > 0.5, then round to nearest 0.05; for example 0.124 rounds to 0.1, 0.125 rounds to 0.15, and 0.36 rounds to 0.35. (two decimals)                                                                                                                                                                                 
		-- •	(d) if value is=> 0.5, then round to nearest 0.1.  for example 0.549 rounds to 0.5, 0.550 rounds to 0.6, and 0.667 rounds to 0.7. (one decimal)                                                                                                                                                                                 



		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro7 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro7 ');

       SELECT
          CASE
             WHEN anvalue < 0.01 THEN 0
             WHEN (anvalue >= 0.01 AND anvalue < 0.1) 
             THEN RoundNear(anvalue, 0.02)
             WHEN (anvalue >= 0.1 AND anvalue < 0.5)
             THEN RoundNear(anvalue, 0.05)
             WHEN (anvalue >= 0.5)
             THEN RoundNear(anvalue, 0.1)
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
             asmessage   => 'aapiSpecification.CanadaMicro7 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro7;
 FUNCTION CanadaMicro5 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro5
       --

		-- CanadaMicro5
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 0.005, to "0 "; (no decimal)
		-- •	(b) if 0.005 <= value > 0.05, then round to nearest 0.01; for example 0.005 rounds to 0.01, 0.014 rounds to 0.01, and 0.035 rounds to 0.04. (two decimals)                                                                                                                                                                                 
		-- •	(c) if 0.05 <= value > 0.25, then round to nearest 0.025; for example 0.0624 rounds to 0.050, 0.0625 rounds to 0.075, and 0.102 rounds to 0.100 (three decimals)                                                                                                                                                                                 
		-- •	(d) if value is=> 0.25, then round to nearest 0.05.  for example 0.274 rounds to 0.25, 0.275 rounds to 0.30, and 0.362 rounds to 0.35. (two decimals)                                                                                                                                                                                 



		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro5 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro5 ');

       SELECT
          CASE
             WHEN anvalue < 0.005 THEN 0
             WHEN (anvalue >= 0.005 AND anvalue < 0.05) 
             THEN RoundNear(anvalue, 0.01)
             WHEN (anvalue >= 0.05 AND anvalue < 0.25)
             THEN RoundNear(anvalue, 0.025)
             WHEN (anvalue >= 0.25)
             THEN RoundNear(anvalue, 0.05)
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
             asmessage   => 'aapiSpecification.CanadaMicro5 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro5;
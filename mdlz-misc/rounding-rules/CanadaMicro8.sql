 FUNCTION CanadaMicro8 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro8
       --

		-- CanadaMicro8
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 0.0015, to "0"; (no decimal)
		-- •	(b) if 0.0015 <= value > 0.025, then round to nearest 0.002; for example 0.0015 rounds to 0.002, 0.0029 rounds to 0.002, and 0.0030 rounds to 0.004. (three decimals)                                                                                                                                                                                 
		-- •	(c) if it is 0.025 <= value > 0.05, then round to nearest 0.005; for example 0.0274 rounds to 0.025, 0.0275 rounds to 0.030, and 0.0374 rounds to 0.035. (three decimals)                                                                                                                                                                                 
		-- •	(d) if value is=> 0.05, then round to nearest 0.01.  for example 0.054 rounds to 0.05, 0.055 rounds to 0.06, and 0.074 rounds to 0.07. (two decimals)                                                                                                                                                                                 



		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro8 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro8 ');

       SELECT
          CASE
             WHEN anvalue < 0.0015 THEN 0
             WHEN (anvalue >= 0.0015 AND anvalue < 0.025) 
             THEN RoundNear(anvalue, 0.002)
             WHEN (anvalue >= 0.025 AND anvalue < 0.05)
             THEN RoundNear(anvalue, 0.005)
             WHEN (anvalue >= 0.05)
             THEN RoundNear(anvalue, 0.01)
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
             asmessage   => 'aapiSpecification.CanadaMicro8 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro8;
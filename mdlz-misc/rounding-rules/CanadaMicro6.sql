 FUNCTION CanadaMicro6 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro6
       --

		-- CanadaMicro6
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 1, to "0"; (no decimal)
		-- •	(b) if 1 <= value > 10, then round to nearest 2; for example 1.05 rounds to 2, 2.99 rounds to 2 and 3.00 rounds 4. (no decimal)
		-- •	(c) if it is 10 <= value >  50, then round to nearest 5; and for example 12.4 rounds to 10, 12.5 rounds to 15 and 49 rounds 50. (no decimal)
		-- •	(d) if value is=> 50, then round to nearest 10.  for example 54.9 rounds to 50, 55.0 rounds to 60 and 74.9 rounds 70. (no decimal)



		---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro6 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro6 ');

       SELECT
          CASE
             WHEN anvalue < 1 THEN 0
             WHEN (anvalue >= 1 AND anvalue < 10) 
             THEN RoundNear(anvalue, 2)
             WHEN (anvalue >= 10 AND anvalue < 50)
             THEN RoundNear(anvalue, 5)
             WHEN (anvalue >= 50)
             THEN RoundNear(anvalue, 10)
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
             asmessage   => 'aapiSpecification.CanadaMicro6 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro6;
 FUNCTION CanadaMicro2 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro2
       --

		-- CanadaMicro2
		-- The rule rounds up.
		-- The amount is rounded off
		-- •	(a) if value < 0.05, to "0"; (no decimal)
		-- •	(b) if 0.05 <= value > 0.5, then round to nearest 0.1;  for example 0.05 rounds to 0.1, 0.15 rounds to 0.2, and 0.44 rounds to 0.4  (one decimal)
		-- •	(c) if 0.5 <= value > 2.5, then round to nearest 0.25; for example 0.624 rounds to 0.50, 0.625 rounds to 0.75, and 2.14 rounds to 2.25  (two decimal)
		-- •	(d) if value is=> 2.5, then round to nearest 0.5.  for example 2.74 rounds to 2.5, 2.75 rounds to 3.0, and 6.14 rounds to 6.0  (one decimal)





       ---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro2 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro2 ');

       SELECT
          CASE
             WHEN anvalue < 0.05 THEN 0
             WHEN (anvalue >= 0.05 AND anvalue < 0.5) 
             THEN RoundNear(anvalue, 0.1)
             WHEN (anvalue >= 0.5 AND anvalue < 2.5)
             THEN RoundNear(anvalue, 0.25)
             WHEN (anvalue >= 2.5)
             THEN RoundNear(anvalue, 0.5)
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
             asmessage   => 'aapiSpecification.CanadaMicro2 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro2;
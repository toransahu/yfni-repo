 FUNCTION CanadaMicro1 (anvalue IN NUMBER)
       RETURN iapitype.string_type
    IS
       ---------------------------------------------------------------------------
       --  Abstract:
       --           Kraft Custom Rounding Rule  CanadaMicro1
       --

       -- Canada Micro 1 
	   -- The rule rounds up.
       --Rounds the value to the nearest 10
       -- •    (a) if value < 5, round to “0”;  (no decimal)
       -- •    (b) if 5 <= value > 50, then round to nearest 10; for example 5 rounds to 10, 25 rounds to 30 and 49 rounds 50  (no decimal)
       -- •    (c) if 50 <= value > 250, then round to nearest 25; for example 62.4 rounds to 50, 62.5 rounds to 75, and 225.5 rounds to 250  (no decimal)
       -- •    (d) if value is=> 250, then round to nearest 50. For example 274 rounds to 250, 275 rounds to 300.  (no decimal)



       ---------------------------------------------------------------------------
       --  Arguments:
       --
       --  Return Values: iapiConstant.DBERR_SUCCESS
       --                 iapiConstant.DBERR_GENFAIL
       ---------------------------------------------------------------------------
       lsmethod   iapitype.method_type := ' CanadaMicro1 ';
       lsoutval   iapitype.string_type;
    BEGIN
       ------------------------------------------------------------------------
       -- Body of FUNCTION
       ------------------------------------------------------------------------
       aapigeneral.loginfo (
          assource    => gssource,
          asmethod    => lsmethod,
          asmessage   => ' Custom Rounding Rule for  CanadaMicro1 ');

       SELECT
          CASE
             WHEN anvalue < 5 THEN 0
             WHEN (anvalue >= 5 AND anvalue < 50) 
             THEN
                CASE
                   WHEN MOD (anvalue, 10) < 5
                   THEN
                      anvalue - MOD (anvalue, 10)
                   WHEN MOD (anvalue, 10) >= 5
                   THEN
                      anvalue - MOD (anvalue, 10) + 10
                END
             WHEN (anvalue >= 50 AND anvalue < 250)
             THEN
                CASE
                   WHEN MOD (anvalue, 25) < 12.5
                   THEN
                      anvalue - MOD (anvalue, 25)
                   WHEN MOD (anvalue, 25) >= 12.5
                   THEN
                      anvalue - MOD (anvalue, 25) + 25
                END
             WHEN (anvalue >= 250)
             THEN
                CASE
                   WHEN MOD (anvalue, 50) < 25
                   THEN
                      anvalue - MOD (anvalue, 50)
                   WHEN MOD (anvalue, 50) >= 25
                   THEN
                      anvalue - MOD (anvalue, 50) + 50
                END
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
             asmessage   => 'aapiSpecification.CanadaMicro1 = ' || SQLERRM);
          RETURN '0';
    END CanadaMicro1;
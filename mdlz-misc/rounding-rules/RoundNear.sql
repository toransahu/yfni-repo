FUNCTION RoundNear (anvalue IN NUMBER, annear IN NUMBER)
   RETURN NUMBER;

FUNCTION RoundNear (anvalue IN NUMBER, annear IN NUMBER)
   RETURN NUMBER
IS
   ---------------------------------------------------------------------------
   --  Abstract: anvalue is rounded near annear
   --  Author: Toran Sahu
   ---------------------------------------------------------------------------
   --  Arguments:
   --
   --  Return Values: iapiConstant.DBERR_SUCCESS
   --                 iapiConstant.DBERR_GENFAIL
   ---------------------------------------------------------------------------
   lsmethod   iapitype.method_type := ' RoundNear ';
   lsoutval   iapitype.string_type;
BEGIN
   ------------------------------------------------------------------------
   -- Body of FUNCTION
   ------------------------------------------------------------------------
   aapigeneral.loginfo (
      assource    => gssource,
      asmethod    => lsmethod,
      asmessage   => ' Custom Rounding Rule for  RoundNear ');

   SELECT CASE
             WHEN MOD (anvalue, annear) < annear / 2
             THEN
                anvalue - MOD (anvalue, annear)
             WHEN MOD (anvalue, annear) >= annear / 2
             THEN
                anvalue - MOD (anvalue, annear) + annear
             ELSE
                anvalue
          END
     INTO lsoutval
     FROM DUAL;

   RETURN lsoutval;
EXCEPTION
   WHEN OTHERS
   THEN
      aapigeneral.logerror (
         assource    => gssource,
         asmethod    => lsmethod,
         asmessage   => 'aapiSpecification.RoundNear = ' || SQLERRM);
      RETURN '0';
END RoundNear;
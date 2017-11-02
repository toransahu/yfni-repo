DECLARE
   STATUS             VARCHAR (10) := '';
   ERROR_MSG          CLOB := '';
   lnCounter          NUMBER;
   lsvalue            VARCHAR2 (3999);
   lssourcecolumn     VARCHAR2 (256);
   lstargetcolumn     VARCHAR2 (256);
   lsquery            VARCHAR2 (1000);
   lspartno           VARCHAR2 (25);
   lnrevision         NUMBER (4);
   lssourcecol        VARCHAR2 (256);
   lssourcecol_1      VARCHAR2 (256);
   lssection          VARCHAR2 (256);
   lssub_section      VARCHAR2 (256);
   lsproperty_group   VARCHAR2 (256);
   lsproperty         VARCHAR2 (256);
   lsattribute        VARCHAR2 (256);


   CURSOR c_source_cols
   IS
      SELECT SOURCE_COLUMN
        FROM INTERSPC.BEGA_SOURCE_COLUMN
       ;

BEGIN
   DELETE FROM INTERSPC.BEGA_SPECDATA;

   FOR r_source_cols IN c_source_cols
   LOOP
      BEGIN
         lssourcecol := r_source_cols.SOURCE_COLUMN;
         lssourcecol_1 := '''' || r_source_cols.SOURCE_COLUMN || '''';
         lspartno := '''17011289''';
         lnrevision := 7;
         lsquery :=
               'INSERT INTO INTERSPC.BEGA_SPECDATA
            SELECT DISTINCT PART_NO,
                  REVISION,
                  SECTION_ID,
                  SUB_SECTION_ID,
                  PROPERTY_GROUP,
                  PROPERTY,
                  ATTRIBUTE,
                  NULL , '
            || lssourcecol_1
            || ',
                  NUM_1, 
                  NULL,
                  UOM_ID,
                  TEST_METHOD,
                  SEQUENCE_NO
            FROM INTERSPC.SPECIFICATION_PROP
            WHERE PART_NO = '
            || lspartno
            || ' AND REVISION = '
            || lnrevision;

         EXECUTE IMMEDIATE lsquery;
      END;
   END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
END;

COMMIT;
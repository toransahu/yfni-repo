SELECT DISTINCT PART_NO,
                  REVISION,
                  SECTION_ID,
                  SUB_SECTION_ID,
                  PROPERTY_GROUP,
                  PROPERTY,
                  ATTRIBUTE,
                  UOM_ID,
                  'NUM_1' source_col,
                  NUM_1 VALUE,
                  TEST_METHOD,
                  SEQUENCE_NO
    FROM INTERSPC.SPECIFICATION_PROP
   WHERE PART_NO = '17011289' AND REVISION = 7
ORDER BY 1,
         2,
         3,
         4,
         5,
         6,
         7,
         8,
         9;	   

SELECT DISTINCT
       EF.PART_NO,
       EF.REVISION,
       EF.SECTION_ID,
       EF.SUB_SECTION_ID,
       EF.PROPERTY_GROUP,
       EF.PROPERTY,
       EF.ATTRIBUTE,
       EF.UOM_ID,
       EF.TEST_METHOD,
       EF.HEADER_ID,
       PL.FIELD_ID,
       DECODE (PL.FIELD_ID,
               1, 'NUM_1',
               2, 'NUM_2',
               3, 'NUM_3',
               4, 'NUM_4',
               5, 'NUM_5',
               6, 'NUM_6',
               7, 'NUM_7',
               8, 'NUM_8',
               9, 'NUM_9',
               10, 'NUM_10',
               11, 'CHAR_1',
               12, 'CHAR_2',
               13, 'CHAR_3',
               14, 'CHAR_4',
               15, 'CHAR_5',
               16, 'CHAR_6',
               17, 'BOOLEAN_1',
               18, 'BOOLEAN_2',
               19, 'BOOLEAN_3',
               20, 'BOOLEAN_4',
               21, 'DATE_1',
               22, 'DATE_2',
               23, 'UOM_ID',
               24, 'ATTRIBUTE',
               25, 'TEST_METHOD',
               26, 'CHARACTERISTIC',
               27, 'PROPERTY',
               30, 'CH_2',
               31, 'CH_3',
               'UNKNOWN')
          SOURCE_COL
  FROM (SELECT *
          FROM INTERSPC.specdata
         WHERE part_no = '17011289' AND revision = 7) EF,
       INTERSPC.FRAME_SECTION FS,
       (SELECT DISTINCT header_id,
                        layout_id,
                        revision,
                        field_id
          FROM INTERSPC.property_layout) PL
 WHERE     EF.SECTION_ID = FS.SECTION_ID
       AND EF.SUB_SECTION_ID = FS.SUB_SECTION_ID
       AND FS.REF_ID = EF.PROPERTY_GROUP
       ---take care of this condition (not worked for PROD,RMAT Anlytical Mapping
       -- AND FS.SECTION_SEQUENCE_NO = EF.SECTION_SEQUENCE_NO
       AND FS.DISPLAY_FORMAT = PL.LAYOUT_ID
       AND EF.HEADER_ID = PL.HEADER_ID
       AND FS.DISPLAY_FORMAT_REV = PL.REVISION
ORDER BY 1,
         2,
         3,
         4,
         5,
         6,
         7,
         8,
         9       		 
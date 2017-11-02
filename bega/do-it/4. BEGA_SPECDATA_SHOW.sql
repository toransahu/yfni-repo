SELECT PART_NO,
         REVISION,
         (SELECT DESCRIPTION
            FROM SECTION
           WHERE SECTION_ID = M.SECTION_ID)
            SECTION,
         (SELECT DESCRIPTION
            FROM SUB_SECTION
           WHERE SUB_SECTION_ID = M.SUB_SECTION_ID)
            SUB_SECTION,
         (SELECT DESCRIPTION
            FROM PROPERTY_GROUP
           WHERE PROPERTY_GROUP = M.PROPERTY_GROUP)
            PROPERTY_GROUP,
         (SELECT DESCRIPTION
            FROM PROPERTY
           WHERE PROPERTY = M.PROPERTY)
            PROPERTY,
         (SELECT DESCRIPTION
            FROM ATTRIBUTE
           WHERE ATTRIBUTE = M.ATTRIBUTE)
            ATTRIBUTE,
         (SELECT DESCRIPTION
            FROM HEADER
           WHERE HEADER_ID = M.HEADER_ID)
            HEADER,
         DECODE (SOURCE_COLUMN,
                 'CHARACTERISTIC', (SELECT DESCRIPTION
                                      FROM CHARACTERISTIC
                                     WHERE CHARACTERISTIC_ID = VALUE_S),
                 'CH_2', (SELECT DESCRIPTION
                            FROM CHARACTERISTIC
                           WHERE CHARACTERISTIC_ID = VALUE_S),
                 'CH_3', (SELECT DESCRIPTION
                            FROM CHARACTERISTIC
                           WHERE CHARACTERISTIC_ID = VALUE_S),
                 'PROPERTY', (SELECT DESCRIPTION
                                FROM PROPERTY
                               WHERE PROPERTY = VALUE_S),
                 'ATTRIBUTE', (SELECT DESCRIPTION
                                 FROM ATTRIBUTE
                                WHERE ATTRIBUTE = VALUE_S),
                 'TEST_METHOD', (SELECT DESCRIPTION
                                   FROM TEST_METHOD
                                  WHERE TEST_METHOD = VALUE_S),
                 VALUE_S)
            VALUE_S,
         M.SOURCE_COLUMN,
         M.SECTION_ID,
         M.SUB_SECTION_ID,
         M.PROPERTY_GROUP PROPERTY_GROUP_ID,
         M.PROPERTY PROPERTY_ID,
         M.ATTRIBUTE ATTRIBUTE_ID,
         M.HEADER_ID
    FROM INTERSPC.BEGA_SPECDATA M
   WHERE VALUE_S IS NOT NULL 
   --AND HEADER_ID IS NOT NULL
ORDER BY 1,
         2,
         3,
         4,
         5,
         6,
         7,
         8;
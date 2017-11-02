--[1]ingredient component list -RMAT

SELECT PART_NO,
       REVISION,
       'RMAT' SPEC_TYPE,
       (SELECT DESCRIPTION
          FROM SECTION
         WHERE SECTION_ID = I.SECTION_ID)
          AS SECTION,
       '(none)' AS SUB_SECTION,
       'Ingredient Component List' AS PROPERTY_GROUP,
       (SELECT DESCRIPTION
          FROM ITING
         WHERE INGREDIENT = I.INGREDIENT)
          INGREDIENT,
       (SELECT DESCRIPTION
          FROM ITINGCFG
         WHERE CID = I.ING_SYNONYM)
          "SYNONYM",
       QUANTITY,
       ING_LEVEL,
       ING_COMMENT
  FROM SPECIFICATION_ING I
 WHERE     SECTION_ID = 700515                         --and ingredient=700995
       AND (PART_NO, REVISION) IN
              ( ('10007108', 10),
               ('10039809', 2),
               ('10052345', 6),
               ('10055987', 5),
               ('10056733', 2),
               ('10065252', 3),
               ('10321032', 1),
               ('10321044', 1));
			   
--[2] technical name -RMAT
SELECT PART_NO,
       REVISION,
       'RMAT' SPEC_TYPE,
       (SELECT DESCRIPTION
          FROM SECTION
         WHERE SECTION_ID = ITSHBN.SECTION_ID)
          SECTION,
       (SELECT DESCRIPTION
          FROM SUB_SECTION
         WHERE SUB_SECTION_ID = ITSHBN.SUB_SECTION_ID)
          SUB_SECTION,
       (SELECT DESCRIPTION
          FROM ITING
         WHERE INGREDIENT = BASE_NAME_ID)
          "TECHNICAL_NAME"
  FROM ITSHBN
 WHERE (PART_NO, REVISION) IN
          ( ('10007108', 10),
           ('10039809', 2),
           ('10052345', 6),
           ('10055987', 5),
           ('10056733', 2),
           ('10065252', 3),
           ('10321032', 1),
           ('10321044', 1));

--[3] classification -ALL (minus PA, UL, PFORM, UA)
SELECT DISTINCT CL1.PART_NO,
                SL.REVISION,
                CL0.LONG_NAME AS CLS0,
                CL1.LONG_NAME AS CLS1,
                CL2.LONG_NAME AS CLS2,
                CL3.LONG_NAME AS CLS3
                  FROM (SELECT DISTINCT PR.PART_NO, CL.LONG_NAME
          FROM ITPRCL PR, MATERIAL_CLASS CL
         WHERE PR.MATL_CLASS_ID = CL.IDENTIFIER AND PR.HIER_LEVEL = 1) CL1,
       (SELECT DISTINCT PR.PART_NO, CL.LONG_NAME
          FROM ITPRCL PR, MATERIAL_CLASS CL
         WHERE PR.MATL_CLASS_ID = CL.IDENTIFIER AND PR.HIER_LEVEL = 2) CL2,
       (SELECT DISTINCT PR.PART_NO, CL.LONG_NAME
          FROM ITPRCL PR, MATERIAL_CLASS CL
         WHERE PR.MATL_CLASS_ID = CL.IDENTIFIER AND PR.HIER_LEVEL = 3) CL3,
         (SELECT DISTINCT PR.PART_NO, CL.LONG_NAME
          FROM ITPRCL PR, MATERIAL_CLASS CL
         WHERE PR.MATL_CLASS_ID = CL.IDENTIFIER AND PR.HIER_LEVEL = 0) CL0,
       (SELECT '10007108' PART_NO, 10 REVISION FROM DUAL
        UNION ALL
        SELECT '10039809', 2 FROM DUAL
        UNION ALL
        SELECT '10052345', 6 FROM DUAL
        UNION ALL
        SELECT '10055987', 5 FROM DUAL
        UNION ALL
        SELECT '10056733', 2 FROM DUAL
        UNION ALL
        SELECT '10065252', 3 FROM DUAL
        UNION ALL
        SELECT '10321032', 1 FROM DUAL
        UNION ALL
        SELECT '10321044', 1 FROM DUAL) SL
 WHERE     CL1.PART_NO = CL3.PART_NO(+)
       AND CL1.PART_NO = CL2.PART_NO(+)
       AND CL1.PART_NO = CL0.PART_NO(+)
       AND CL1.PART_NO = SL.PART_NO;
	   
--[4] Plants (Header) -ALL	   

SELECT DISTINCT PP.PART_NO,
                PP.PLANT,
                DESCRIPTION,
                RELEVENCY_TO_COSTING,
                BULK_MATERIAL,
                DECODE (OBSOLETE,  0, 'N',  1, 'Y') OBSOLETE
  FROM PART_PLANT PP, PLANT P
 WHERE     P.PLANT = PP.PLANT
       AND PART_NO IN (SELECT PART_NO
                         FROM (SELECT '10007108' PART_NO, 10 FROM DUAL
                               UNION ALL
                               SELECT '10039809', 2 FROM DUAL
                               UNION ALL
                               SELECT '10052345', 6 FROM DUAL
                               UNION ALL
                               SELECT '10055987', 5 FROM DUAL
                               UNION ALL
                               SELECT '10056733', 2 FROM DUAL
                               UNION ALL
                               SELECT '10065252', 3 FROM DUAL
                               UNION ALL
                               SELECT '10321032', 1 FROM DUAL
                               UNION ALL
                               SELECT '10321044', 1 FROM DUAL));

--[5] Material Code -ALL (minus PFORM)
SELECT *
  FROM INTERSPC.ATMATERIAL
 WHERE PART_NO IN (SELECT PART_NO
                     FROM (SELECT '10007108' PART_NO, 10 FROM DUAL
                           UNION ALL
                           SELECT '10039809', 2 FROM DUAL
                           UNION ALL
                           SELECT '10052345', 6 FROM DUAL
                           UNION ALL
                           SELECT '10055987', 5 FROM DUAL
                           UNION ALL
                           SELECT '10056733', 2 FROM DUAL
                           UNION ALL
                           SELECT '10065252', 3 FROM DUAL
                           UNION ALL
                           SELECT '10321032', 1 FROM DUAL
                           UNION ALL
                           SELECT '10321044', 1 FROM DUAL));

--[6] Reason for Issue - ALL

  SELECT DISTINCT PART_NO, REVISION, TEXT
    FROM INTERSPC.REASON
   WHERE     STATUS_TYPE = 'RI'
         AND (PART_NO, REVISION) IN
                ( ('10007108', 10),
                 ('10039809', 2),
                 ('10052345', 6),
                 ('10055987', 5),
                 ('10056733', 2),
                 ('10065252', 3),
                 ('10321032', 1),
                 ('10321044', 1))
ORDER BY PART_NO;


--[7]	Note (header) -ALL
  SELECT PART_NO, TEXT
    FROM INTERSPC.ITPRNOTE
   WHERE PART_NO IN (SELECT PART_NO
                       FROM (SELECT '10007108' PART_NO, 10 FROM DUAL
                             UNION ALL
                             SELECT '10039809', 2 FROM DUAL
                             UNION ALL
                             SELECT '10052345', 6 FROM DUAL
                             UNION ALL
                             SELECT '10055987', 5 FROM DUAL
                             UNION ALL
                             SELECT '10056733', 2 FROM DUAL
                             UNION ALL
                             SELECT '10065252', 3 FROM DUAL
                             UNION ALL
                             SELECT '10321032', 1 FROM DUAL
                             UNION ALL
                             SELECT '10321044', 1 FROM DUAL))
ORDER BY 1;

--[8] Attached SPECIFICATION -ALL
  SELECT A.PART_NO,
         A.REVISION,
         ATTACHED_PART_NO,
         DECODE (ATTACHED_REVISION, 0, MAX (SH.REVISION), ATTACHED_REVISION)
            ATTACHED_REVISION,
         (SELECT DESCRIPTION
            FROM SECTION
           WHERE SECTION_ID = A.SECTION_ID)
            SECTION,
         (SELECT DESCRIPTION
            FROM SUB_SECTION
           WHERE SUB_SECTION_ID = A.SUB_SECTION_ID)
            SUB_SECTION
    FROM INTERSPC.ATTACHED_SPECIFICATION A, INTERSPC.SPECIFICATION_HEADER SH
   WHERE     (A.PART_NO, A.REVISION) IN
                ( ('10007108', 10),
                 ('10039809', 2),
                 ('10052345', 6),
                 ('10055987', 5),
                 ('10056733', 2),
                 ('10065252', 3),
                 ('10321032', 1),
                 ('10321044', 1))
         AND SH.PART_NO = A.ATTACHED_PART_NO
GROUP BY A.PART_NO,
         A.REVISION,
         A.ATTACHED_PART_NO,
         A.ATTACHED_REVISION,
         A.SECTION_ID,
         A.SUB_SECTION_ID
ORDER BY 1,2;         
						   
--[9] Files/Images (Header) -ALL
SELECT DISTINCT PART_NO,
                FILE_NAME,
                D.REVISION FILE_REVISION,
                FILE_SIZE
  FROM INTERSPC.ITPROBJ P, INTERSPC.ITOID D
 WHERE     D.OBJECT_ID = P.OBJECT_ID
       AND PART_NO IN (SELECT PART_NO
                         FROM (SELECT '10007108' PART_NO, 10 FROM DUAL
                               UNION ALL
                               SELECT '10039809', 2 FROM DUAL
                               UNION ALL
                               SELECT '10052345', 6 FROM DUAL
                               UNION ALL
                               SELECT '10055987', 5 FROM DUAL
                               UNION ALL
                               SELECT '10056733', 2 FROM DUAL
                               UNION ALL
                               SELECT '10065252', 3 FROM DUAL
                               UNION ALL
                               SELECT '10321032', 1 FROM DUAL
                               UNION ALL
                               SELECT '10321044', 1 FROM DUAL))
                               order by 1;
							   
--[10] Specification_TEXT covers fields mentioned in attached excel file							   
  SELECT PART_NO,
         REVISION,
         -- 'SPECIFICATION_TEXT' TYPE,
         (SELECT DESCRIPTION
            FROM SECTION
           WHERE SECTION_ID = ST.SECTION_ID)
            SECTION,
         (SELECT DESCRIPTION
            FROM SUB_SECTION
           WHERE SUB_SECTION_ID = ST.SUB_SECTION_ID)
            SUB_SECTION,
         DESCRIPTION,
         TEXT
    FROM INTERSPC.SPECIFICATION_TEXT ST, INTERSPC.TEXT_TYPE TT
   WHERE     (PART_NO, REVISION) IN
                ( ('10007108', 10),
                 ('10039809', 2),
                 ('10052345', 6),
                 ('10055987', 5),
                 ('10056733', 2),
                 ('10065252', 3),
                 ('10321032', 1),
                 ('10321044', 1),
                 ('10004045',3))
         AND ST.TEXT_TYPE = TT.TEXT_TYPE
ORDER BY 1, 2, 3, 4, 5;
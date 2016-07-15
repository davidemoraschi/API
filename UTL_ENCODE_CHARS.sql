SET DEFINE OFF
--/* Formatted on 13/05/2013 8:25:08 (QP5 v5.163.1008.3004) */
--CREATE TABLE TWITTER.TWITTER.UTL_ENCODE_CHARS
--(
--   "Decimal"       BINARY_DOUBLE,
--   "Hex Value"     VARCHAR2 (255 BYTE),
--   "Char"          VARCHAR2 (255 BYTE),
--   "URL Encode"    VARCHAR2 (255 BYTE),
--   "Entity Name"   VARCHAR2 (255 BYTE),
--   "Description"   VARCHAR2 (255 BYTE)
--);
--
--ALTER TABLE TWITTER.TWITTER.UTL_ENCODE_CHARS ADD (
--  CONSTRAINT TWITTER.UTL_ENCODE_CHARS_PK
--  PRIMARY KEY
--  ("Hex Value")
--  USING INDEX
--    );
--
--ALTER TABLE TWITTER.TWITTER.UTL_ENCODE_CHARS ADD (
--  CONSTRAINT TWITTER.UTL_ENCODE_CHARS_U01
--  UNIQUE ("Char")
--  USING INDEX
--    );
--
--ALTER TABLE TWITTER.TWITTER.UTL_ENCODE_CHARS ADD (
--  CONSTRAINT TWITTER.UTL_ENCODE_CHARS_U02
--  UNIQUE ("URL Encode")
--  USING INDEX
--    );
--
--ALTER TABLE TWITTER.TWITTER.UTL_ENCODE_CHARS ADD (
--  CONSTRAINT TWITTER.UTL_ENCODE_CHARS_U03
--  UNIQUE ("Entity Name")
--  USING INDEX
--    );

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (NULL,
             '2b',
             '+',
             '%2b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (32,
             '20',
             'space',
             '%20',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (34,
             '22',
             '"',
             '%22',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (60,
             '3c',
             '<',
             '%3c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (62,
             '3e',
             '>',
             '%3e',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (35,
             '23',
             '#',
             '%23',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (37,
             '25',
             '%',
             '%25',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (123,
             '7b',
             '{',
             '%7b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (125,
             '7d',
             '}',
             '%7d',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (124,
             '7c',
             '|',
             '%7c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (92,
             '5c',
             '\',
             '%5c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (94,
             '5e',
             '^',
             '%5e',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (126,
             '7e',
             '~',
             '%7e',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (91,
             '5b',
             '[',
             '%5b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (93,
             '5d',
             ']',
             '%5d',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (96,
             '60',
             '`',
             '%60',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (36,
             '24',
             '$',
             '%24',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (38,
             '26',
             '&',
             '%26',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (44,
             '2c',
             ',',
             '%2c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (47,
             '2f',
             '/',
             '%2f',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (58,
             '3a',
             ':',
             '%3a',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (59,
             '3b',
             ';',
             '%3b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (61,
             '3d',
             '=',
             '%3d',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (63,
             '3f',
             '?',
             '%3f',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (64,
             '40',
             '@',
             '%40',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (128,
             '80',
             '�',
             '%80',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (129,
             '81',
             '�',
             '%81',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (130,
             '82',
             '�',
             '%82',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (131,
             '83',
             '�',
             '%83',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (132,
             '84',
             '�',
             '%84',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (133,
             '85',
             '�',
             '%85',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (134,
             '86',
             '�',
             '%86',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (135,
             '87',
             '�',
             '%87',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (136,
             '88',
             '�',
             '%88',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (137,
             '89',
             '�',
             '%89',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (138,
             '8a',
             '�',
             '%8a',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (139,
             '8b',
             '�',
             '%8b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (140,
             '8c',
             '�',
             '%8c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (141,
             '8d',
             '�',
             '%8d',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (142,
             '8e',
             '�',
             '%8e',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (143,
             '8f',
             '�',
             '%8f',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (144,
             '90',
             '�',
             '%90',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (145,
             '91',
             '�',
             '%91',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (146,
             '92',
             '�',
             '%92',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (147,
             '93',
             '�',
             '%93',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (148,
             '94',
             '�',
             '%94',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (149,
             '95',
             '�',
             '%95',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (150,
             '96',
             '�',
             '%96',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (151,
             '97',
             '�',
             '%97',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (152,
             '98',
             '�',
             '%98',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (153,
             '99',
             '�',
             '%99',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (154,
             '9a',
             '�',
             '%9a',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (155,
             '9b',
             '�',
             '%9b',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (156,
             '9c',
             '�',
             '%9c',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (157,
             '9d',
             '�',
             '%9d',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (158,
             '9e',
             '�',
             '%9e',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (159,
             '9f',
             '�',
             '%9f',
             NULL,
             NULL);

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (160,
             'a0',
             NULL,
             '%a0',
             '&nbsp;',
             'non-breaking space');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (161,
             'a1',
             '�',
             '%a1',
             '&iexcl;',
             'inverted exclamation mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (162,
             'a2',
             '�',
             '%a2',
             '&cent;',
             'cent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (163,
             'a3',
             '�',
             '%a3',
             '&pound;',
             'pound');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (164,
             'a4',
             '�',
             '%a4',
             '&curren;',
             'currency');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (165,
             'a5',
             '�',
             '%a5',
             '&yen;',
             'yen');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (166,
             'a6',
             '�',
             '%a6',
             '&brvbar;',
             'broken vertical bar');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (167,
             'a7',
             '�',
             '%a7',
             '&sect;',
             'section');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (168,
             'a8',
             '�',
             '%a8',
             '&uml;',
             'spacing diaeresis');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (169,
             'a9',
             '�',
             '%a9',
             '&copy;',
             'copyright');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (170,
             'aa',
             '�',
             '%aa',
             '&ordf;',
             'feminine ordinal indicator');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (171,
             'ab',
             '�',
             '%ab',
             '&laquo;',
             'angle quotation mark (left)');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (172,
             'ac',
             '�',
             '%ac',
             '&not;',
             'negation');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (173,
             'ad',
             '�',
             '%ad',
             '&shy;',
             'soft hyphen');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (174,
             'ae',
             '�',
             '%ae',
             '&reg;',
             'registered trademark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (175,
             'af',
             '�',
             '%af',
             '&macr;',
             'spacing macron');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (176,
             'b0',
             '�',
             '%b0',
             '&deg;',
             'degree');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (177,
             'b1',
             '�',
             '%b1',
             '&plusmn;',
             'plus-or-minus');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (178,
             'b2',
             '�',
             '%b2',
             '&sup2;',
             'superscript 2');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (179,
             'b3',
             '�',
             '%b3',
             '&sup3;',
             'superscript 3');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (180,
             'b4',
             '�',
             '%b4',
             '&acute;',
             'spacing acute');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (181,
             'b5',
             '�',
             '%b5',
             '&micro;',
             'micro');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (182,
             'b6',
             '�',
             '%b6',
             '&para;',
             'paragraph');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (183,
             'b7',
             '�',
             '%b7',
             '&middot;',
             'middle dot');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (184,
             'b8',
             '�',
             '%b8',
             '&cedil;',
             'spacing cedilla');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (185,
             'b9',
             '�',
             '%b9',
             '&sup1;',
             'superscript 1');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (186,
             'ba',
             '�',
             '%ba',
             '&ordm;',
             'masculine ordinal indicator');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (187,
             'bb',
             '�',
             '%bb',
             '&raquo;',
             'angle quotation mark (right)');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (188,
             'bc',
             '�',
             '%bc',
             '&frac14;',
             'fraction 1/4');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (189,
             'bd',
             '�',
             '%bd',
             '&frac12;',
             'fraction 1/2');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (190,
             'be',
             '�',
             '%be',
             '&frac34;',
             'fraction 3/4');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (191,
             'bf',
             '�',
             '%bf',
             '&iquest;',
             'inverted question mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (192,
             'c0',
             '�',
             '%c0',
             '&Agrave;',
             'capital a, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (193,
             'c1',
             '�',
             '%c1',
             '&Aacute;',
             'capital a, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (194,
             'c2',
             '�',
             '%c2',
             '&Acirc;',
             'capital a, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (195,
             'c3',
             '�',
             '%c3',
             '&Atilde;',
             'capital a, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (196,
             'c4',
             '�',
             '%c4',
             '&Auml;',
             'capital a, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (197,
             'c5',
             '�',
             '%c5',
             '&Aring;',
             'capital a, ring');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (198,
             'c6',
             '�',
             '%v6',
             '&AElig;',
             'capital ae');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (199,
             'c7',
             '�',
             '%c7',
             '&Ccedil;',
             'capital c, cedilla');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (200,
             'c8',
             '�',
             '%c8',
             '&Egrave;',
             'capital e, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (201,
             'c9',
             '�',
             '%c9',
             '&Eacute;',
             'capital e, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (202,
             'ca',
             '�',
             '%ca',
             '&Ecirc;',
             'capital e, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (203,
             'cb',
             '�',
             '%cb',
             '&Euml;',
             'capital e, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (204,
             'cc',
             '�',
             '%cc',
             '&Igrave;',
             'capital i, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (205,
             'cd',
             '�',
             '%cd',
             '&Iacute;',
             'capital i, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (206,
             'ce',
             '�',
             '%ce',
             '&Icirc;',
             'capital i, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (207,
             'cf',
             '�',
             '%cf',
             '&Iuml;',
             'capital i, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (208,
             'd0',
             '�',
             '%d0',
             '&ETH;',
             'capital eth, Icelandic');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (209,
             'd1',
             '�',
             '%d1',
             '&Ntilde;',
             'capital n, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (210,
             'd2',
             '�',
             '%d2',
             '&Ograve;',
             'capital o, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (211,
             'd3',
             '�',
             '%d3',
             '&Oacute;',
             'capital o, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (212,
             'd4',
             '�',
             '%d4',
             '&Ocirc;',
             'capital o, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (213,
             'd5',
             '�',
             '%d5',
             '&Otilde;',
             'capital o, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (214,
             'd6',
             '�',
             '%d6',
             '&Ouml;',
             'capital o, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (215,
             'd7',
             '�',
             '%d7',
             '&times;',
             'multiplication');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (216,
             'd8',
             '�',
             '%d8',
             '&Oslash;',
             'capital o, slash');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (217,
             'd9',
             '�',
             '%d9',
             '&Ugrave;',
             'capital u, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (218,
             'da',
             '�',
             '%da',
             '&Uacute;',
             'capital u, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (219,
             'db',
             '�',
             '%db',
             '&Ucirc;',
             'capital u, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (220,
             'dc',
             '�',
             '%dc',
             '&Uuml;',
             'capital u, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (221,
             'dd',
             '�',
             '%dd',
             '&Yacute;',
             'capital y, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (222,
             'de',
             '�',
             '%de',
             '&THORN;',
             'capital THORN, Icelandic');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (223,
             'df',
             '�',
             '%df',
             '&szlig;',
             'small sharp s, German');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (224,
             'e0',
             '�',
             '%e0',
             '&agrave;',
             'small a, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (225,
             'e1',
             '�',
             '%e1',
             '&aacute;',
             'small a, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (226,
             'e2',
             '�',
             '%e2',
             '&acirc;',
             'small a, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (227,
             'e3',
             '�',
             '%e3',
             '&atilde;',
             'small a, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (228,
             'e4',
             '�',
             '%e4',
             '&auml;',
             'small a, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (229,
             'e5',
             '�',
             '%e5',
             '&aring;',
             'small a, ring');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (230,
             'e6',
             '�',
             '%e6',
             '&aelig;',
             'small ae');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (231,
             'e7',
             '�',
             '%e7',
             '&ccedil;',
             'small c, cedilla');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (232,
             'e8',
             '�',
             '%e8',
             '&egrave;',
             'small e, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (233,
             'e9',
             '�',
             '%e9',
             '&eacute;',
             'small e, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (234,
             'ea',
             '�',
             '%ea',
             '&ecirc;',
             'small e, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (235,
             'eb',
             '�',
             '%eb',
             '&euml;',
             'small e, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (236,
             'ec',
             '�',
             '%ec',
             '&igrave;',
             'small i, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (237,
             'ed',
             '�',
             '%ed',
             '&iacute;',
             'small i, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (238,
             'ee',
             '�',
             '%ee',
             '&icirc;',
             'small i, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (239,
             'ef',
             '�',
             '%ef',
             '&iuml;',
             'small i, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (240,
             'f0',
             '�',
             '%f0',
             '&eth;',
             'small eth, Icelandic');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (241,
             'f1',
             '�',
             '%f1',
             '&ntilde;',
             'small n, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (242,
             'f2',
             '�',
             '%f2',
             '&ograve;',
             'small o, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (243,
             'f3',
             '�',
             '%f3',
             '&oacute;',
             'small o, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (244,
             'f4',
             '�',
             '%f4',
             '&ocirc;',
             'small o, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (245,
             'f5',
             '�',
             '%f5',
             '&otilde;',
             'small o, tilde');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (246,
             'f6',
             '�',
             '%f6',
             '&ouml;',
             'small o, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (247,
             'f7',
             '�',
             '%f7',
             '&divide;',
             'division');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (248,
             'f8',
             '�',
             '%f8',
             '&oslash;',
             'small o, slash');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (249,
             'f9',
             '�',
             '%f9',
             '&ugrave;',
             'small u, grave accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (250,
             'fa',
             '�',
             '%fa',
             '&uacute;',
             'small u, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (251,
             'fb',
             '�',
             '%fb',
             '&ucirc;',
             'small u, circumflex accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (252,
             'fc',
             '�',
             '%fc',
             '&uuml;',
             'small u, umlaut mark');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (253,
             'fd',
             '�',
             '%fd',
             '&yacute;',
             'small y, acute accent');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (254,
             'fe',
             '�',
             '%fe',
             '&thorn;',
             'small thorn, Icelandic');

INSERT INTO TWITTER.UTL_ENCODE_CHARS ("Decimal",
                              "Hex Value",
                              "Char",
                              "URL Encode",
                              "Entity Name",
                              "Description")
     VALUES (255,
             'ff',
             '�',
             '%ff',
             '&yuml;',
             'small y, umlaut mark');

COMMIT;
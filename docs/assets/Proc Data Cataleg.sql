SELECT * FROM(
with dimension_fechas as (
  SELECT
    to_date(19000101,'YYYYMMDD') + (LEVEL - 1) AS DT
  FROM DUAL
  CONNECT BY LEVEL <=
  /* End Date in here -> */ to_number(add_months(sysdate,36) - 1 -
  /* Start Date in here -> */ to_date(19000101,'YYYYMMDD')) +1
)
SELECT 
  to_number(to_char(DT,'YYYYMMDD')) as C_DATA,
  DT as D_DATA,
  TO_CHAR(DT,'DD') as C_DIA,
  TO_CHAR(DT,'DY','nls_date_language=CATALAN') as D_CURTA_DIA,
  TO_CHAR(DT,'DAY','nls_date_language=CATALAN') as D_LLARGA_DIA,
  1 + trunc(DT) - trunc (DT,'IW') as C_DIA_SETMANA,
  TO_CHAR(DT,'MM') as C_MES, 
  TO_CHAR(DT,'YYYYMM') as C_ANY_MES, 
  to_char(DT,'MON','nls_date_language=CATALAN') as D_CURTA_MES,
  to_char(DT,'month','nls_date_language=CATALAN') as D_LlARGA_MES,
  to_char(DT,'WW','nls_date_language=CATALAN') as C_SETMANA,
  TO_CHAR(DT,'YYYY') || 'T' ||
  case extract(month from DT)
    when 1 then 1
    when 2 then 1
    when 3 then 1
    when 4 then 2
    when 5 then 2
    when 6 then 2
    when 7 then 3
    when 8 then 3
    when 9 then 3
    else  4
  end  as C_TRIMESTRE,
  TO_CHAR(DT,'YYYY') || 'S' ||
  case 
    when extract(month from DT) < 7 then 1
    else  2
  end  as C_SEMESTRE,
  TO_CHAR(DT,'YYYY') as C_ANY,
  1 as C_DIA_NATURAL,
  DECODE (1 + trunc(DT) - trunc (DT,'IW'), 6, 1, 7, 1, 0) AS C_DIA_FESTIU,
  DECODE (1 + trunc(DT) - trunc (DT,'IW'), 6, 0, 7,0,1) AS C_DIA_FEINA,
  1 ID_CARREGA, 
  sysdate as FECHA_ACT
FROM dimension_fechas
ORDER BY 2 DESC)

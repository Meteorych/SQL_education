--first exercise
select student_group.id
from teacher_teaches_subjects_in_groups
join teacher on teacher_teaches_subjects_in_groups.personalid = teacher.id
join student_group on teacher_teaches_subjects_in_groups.id = student_group.id
where teacher.speciality like student_group.speciality
group by student_group.id
-----------------------------------------------------------------
---second exercise
SELECT *
FROM spj
--15
SELECT COUNT(DISTINCT j_id) AS Number_Project
FROM spj
WHERE p_id = 'П2';
--28
SELECT DISTINCT s.j_id
FROM SPJ s
JOIN DETAILS d ON s.d_id = d.id
JOIN POSTAVSHIKI p ON s.p_id = p.id
WHERE s.j_id NOT IN (
    SELECT s1.j_id
    FROM SPJ s1
    JOIN DETAILS d1 ON s1.d_id = d1.id
    JOIN POSTAVSHIKI p1 ON s1.p_id = p1.id
    WHERE d1.color = 'Красный' AND p1.city = 'Москва'
);
--36
WITH DetailSets AS (
    SELECT p_id, j_id, STRING_AGG(d_id, ',') AS detail_set
    FROM SPJ
    GROUP BY p_id, j_id
)
SELECT DISTINCT s1.p_id AS Пx, s2.p_id AS Пy
FROM DetailSets s1
JOIN DetailSets s2 ON s1.p_id < s2.p_id
   AND s1.detail_set = s2.detail_set;

--2
SELECT 
    pr.*,
    s.p_id AS Поставщик_ID,
    pst.name AS Поставщик_Имя,
    d.id AS Деталь_ID,
    d.name AS Деталь_Название,
    d.color AS Деталь_Цвет
FROM PROJECTS pr
JOIN SPJ s ON pr.id = s.j_id
JOIN POSTAVSHIKI pst ON s.p_id = pst.id
JOIN DETAILS d ON s.d_id = d.id
WHERE pr.city = 'Минск';
--7
SELECT s.p_id AS Номер_Поставщика, s.d_id AS Номер_Детали, s.j_id AS Номер_Проекта
FROM spj s
JOIN POSTAVSHIKI pst ON s.p_id = pst.id
JOIN PROJECTS pr ON s.j_id = pr.id
JOIN DETAILS d ON s.d_id = d.id
WHERE (d.city = pst.city AND d.city = pr.city AND pst.city = pr.city)
--18
SELECT DISTINCT s.d_id AS Номер_Детали
FROM SPJ s
JOIN (
    SELECT j_id, AVG(s) AS Среднее_Количество
    FROM SPJ
    GROUP BY j_id
    HAVING AVG(s) > 320
) avg_counts ON s.j_id = avg_counts.j_id;
--22
SELECT DISTINCT s.j_id AS Номер_Проекта
FROM SPJ s
WHERE s.d_id IN (
    SELECT DISTINCT d_id
    FROM SPJ
    WHERE p_id = 'П1'
);
--26
SELECT DISTINCT s.j_id AS Номер_Проекта
FROM SPJ s
JOIN DETAILS d ON s.d_id = d.id
WHERE d.name = 'Д1'
GROUP BY s.j_id
HAVING AVG(s.s) > (
    SELECT MAX(s1.s)
    FROM SPJ s1
    WHERE s1.j_id = 'ПР1'
);
--3
SELECT DISTINCT p_id FROM SPJ
WHERE j_id = 'ПР1';
--24
SELECT DISTINCT s.p_id AS Номер_Поставщика
FROM SPJ s
JOIN POSTAVSHIKI p ON s.p_id = p.id
WHERE p.status < (
    SELECT p1.status
    FROM POSTAVSHIKI p1
    WHERE p1.id = 'П1'
);
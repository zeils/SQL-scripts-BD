DROP VIEW IF EXISTS points;
DROP VIEW IF EXISTS v1;

CREATE OR REPLACE VIEW v1 AS(

SELECT Obj.idobject AS idobject, Obj.idparent, Obj.name AS name, Type.name AS type, Type.freedegree, E.layer, 
string_to_array(string_agg(DISTINCT Param."value"::text, ',')::text, ',') AS cords
FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN Objparam AS P ON P.idobject = Obj.idobject
JOIN Param as Param on P.idparam = Param.idparam
JOIN entity as E on Obj.idobject = E.identity

WHERE Type.freedegree = 2 
GROUP BY Obj.idobject, Obj.idparent, Type.name, Type.freedegree, E.layer
ORDER BY Obj.idobject

);


CREATE OR REPLACE VIEW points AS(
SELECT *, cords[1] AS X, cords[2] AS y FROM v1
);
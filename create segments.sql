DROP VIEW IF EXISTS segment;
DROP VIEW IF EXISTS v_segment;

CREATE OR REPLACE VIEW v_segment AS(
SELECT Obj.idobject AS idobject, Obj.name AS name, Type.name AS type, Type.freedegree, E.layer,
string_to_array(string_agg(Point.x::text, ',')::text, ',') AS X12,
string_to_array(string_agg(Point.y::text, ',')::text, ',') AS Y12
FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN entity as E on Obj.idobject = E.identity
JOIN points as Point on Obj.idobject = Point.idparent

WHERE Type.freedegree = 4
GROUP BY Obj.idobject, Obj.idparent, Type.name, Type.freedegree, E.layer
ORDER BY Obj.idobject

);

CREATE OR REPLACE VIEW segment AS(
SELECT *, x12[1] AS X1, y12[1] AS Y1, x12[2] AS X2, y12[2] AS Y2 FROM v_segment
);


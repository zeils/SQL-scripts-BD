
CREATE OR REPLACE VIEW arc AS(
SELECT Obj.idobject AS idobject, Obj.name AS name, Type.name AS type, Type.freedegree, E.layer,
(string_to_array(string_agg(Point.x::text, ',')::text, ','))[1] AS X1,
(string_to_array(string_agg(Point.y::text, ',')::text, ','))[1] AS Y1,
(string_to_array(string_agg(Point.x::text, ',')::text, ','))[2] AS X2,
(string_to_array(string_agg(Point.y::text, ',')::text, ','))[2] AS Y2,
(string_to_array(string_agg(Point.x::text, ',')::text, ','))[3] AS X3,
(string_to_array(string_agg(Point.y::text, ',')::text, ','))[3] AS Y3

FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN entity as E on Obj.idobject = E.identity
JOIN point as Point on Obj.idobject = Point.idparent

WHERE Type.freedegree = 5
GROUP BY Obj.idobject, Obj.idparent, Type.name, Type.freedegree, E.layer
ORDER BY Obj.idobject

);
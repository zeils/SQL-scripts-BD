CREATE OR REPLACE VIEW cicle AS(

SELECT Obj.idobject AS idobject, Obj.name AS name, Type.name AS type, E.layer, 
string_agg(DISTINCT Param."value"::text, ',') AS r, Point.x as X, Point.y as Y
FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN Objparam AS P ON P.idobject = Obj.idobject
JOIN Param as Param on P.idparam = Param.idparam
JOIN entity as E on Obj.idobject = E.identity
JOIN point as Point on Obj.idobject = Point.idparent 

WHERE Type.freedegree = 3 
GROUP BY Obj.idobject, Obj.idparent, Type.name, Type.freedegree, E.layer, Point.x, Point.y
ORDER BY Obj.idobject
	
);
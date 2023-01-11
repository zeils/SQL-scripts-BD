
CREATE OR REPLACE VIEW point AS(

SELECT Obj.idobject AS idobject, Obj.idparent, Obj.name AS name, Type.name AS type, Type.freedegree, E.layer, 
(string_to_array(string_agg(DISTINCT Param."value"::text, ',')::text, ','))[1] AS X,
(string_to_array(string_agg(DISTINCT Param."value"::text, ',')::text, ','))[2] AS Y	
FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN Objparam AS P ON P.idobject = Obj.idobject
JOIN Param as Param on P.idparam = Param.idparam
JOIN entity as E on Obj.idobject = E.identity

WHERE Type.freedegree = 2 
GROUP BY Obj.idobject, Obj.idparent, Type.name, Type.freedegree, E.layer
ORDER BY Obj.idobject

);



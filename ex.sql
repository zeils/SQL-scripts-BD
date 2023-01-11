SELECT Obj.idobject, Obj.name, Type.name, Type.freedegree, E.layer, 
string_agg(DISTINCT Param."value"::text, ','),
string_to_array(string_agg(DISTINCT Param."value"::text, ',')::text, ',')
FROM Object AS Obj
JOIN Objtype AS Type ON Obj.objtype = Type.idobjtype
JOIN Objparam AS P ON P.idobject = Obj.idobject
JOIN Param as Param on P.idparam = Param.idparam
Join entity as E on Obj.idobject = E.identity

WHERE Type.freedegree = 2 AND E.layer = 2
GROUP BY Obj.idobject, Type.name, Type.freedegree, E.layer
ORDER BY Obj.idobject



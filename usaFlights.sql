1. Quantitat de registres de la taula de vols.
    
    SELECT * 
    FROM USAirlineFlights2.Flights;

2. Retard promig de sortida i arribada segons l’aeroport origen.

    SELECT Origin, ArrDelay, DepDelay 
    FROM USAirlineFlights2.Flights;
    -- NOVA SOLUCIÓ --
    SELECT Origin, AVG(ArrDelay) AS promArribades, AVG(DepDelay) AS promSortides
    FROM Flights
    GROUP BY Origin

3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files):

    SELECT Origin, colYear, colMonth, ArrDelay 
    FROM USAirlineFlights2.Flights
    ORDER BY Origin ASC
    --NOVA SOLUCIÓ--
    SELECT Origin, colYear, colMonth, AVG(ArrDelay) AS promArribades
    FROM Flights
    GROUP BY Origin, colYear, colMonth
    ORDER BY Origin, colYear, colMonth


4. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen 
(mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que en comptes del codi de 
l’aeroport es mostri el nom de la ciutat.

    SELECT USAirports.City, Flights.colYear, Flights.colMonth, Flights.ArrDelay AVG(Flights.ArrDelay) AS PromDelay
    FROM Flights
    LEFT JOIN USAirports
    ON Flights.Origin = USAirports.IATA
    GROUP BY Flights.ArrDelay
    ORDER BY USAirports.City ASC
    --NOVA SOLUCIÓ--
    SELECT City, colYear, colMonth, AVG(ArrDelay) AS PromArribades
    FROM Flights
    LEFT JOIN USAirports
    ON IATA = Origin
    GROUP BY City, colYear, colMonth
    ORDER BY City, colYear, colMonth


5. Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades de forma que les 
companyies amb més cancel·lacions apareguin les primeres.

    SELECT UniqueCarrier, colYear, colMonth, SUM(Flights.Cancelled) AS totalCancelled
    FROM USAirlineFlights2.Flights
    LEFT JOIN Carriers
    ON Flights.UniqueCarrier = Carriers.CarrierCode
    GROUP BY Carriers.CarrierCode
    ORDER BY totalCancelled DESC
    --NOVA SOLUCIÓ--
    SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled) AS totalCancelled
    FROM Flights
    GROUP BY Unique Carrier, colYear, colMonth
    ORDER BY totalCancelled DESC

6. L’identificador dels 10 avions que més distància han recorregut fent vols.

    SELECT TailNum, SUM(Distance) AS totalDistance
    FROM Flights
    GROUP BY TailNum
    ORDER BY totalDistance DESC
    LIMIT 10

    Obviar el primer registre, perque hi ha entrades sense TailNum

7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí 
amb un retràs promig major de 10 minuts.

    SELECT UniqueCarrier, AVG(Flights.ArrDelay) AS avgDelay
    FROM Flights
    GROUP BY UniqueCarrier
    ORDER BY avgDelay DESC
    WHERE avgDelay > 10
    --NOVA SOLUCIÓ--
    SELECT UniqueCarrier, AVG(ArrDelay) AS avgDelay
    FROM Flights
    GROUP BY UniqueCarrier HAVING AVG(ArrDelay) > 10
    ORDER BY AvgDelay DESC

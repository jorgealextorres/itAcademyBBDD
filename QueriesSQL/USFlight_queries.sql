# 1. Quantitat de registres de la taula de vols
select count(*) as numFlights
from Flights;

# 2. Retard promig de sortida i arribada segons l’aeroport origen
select Dest, avg(DepDelay) as averageDepartureDelay, avg(ArrDelay) as averageArrivalDelay
from Flights
group by Dest;

# 3. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. A més, volen que els resultat es mostrin de la següent 
# forma (fixa’t en l’ordre de les files):
#   LAX, 2000, 01, 10
#   LAX, 2000, 02, 30
#   LAX, 2000, 03, 2
select Origin, colYear, lpad(colMonth, 2, '0') as month, avg(ArrDelay) as averageArrivalDelay
from Flights
group by Origin, colYear, colMonth
order by Origin, colYear, colMonth asc;

# to check some values
#select colMonth, arrDelay
#from Flights
#where Origin = "ABE" and colYear = 1990;

# 4. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa consulta que abans i amb el mateix ordre). 
# Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat.
#        Los Angeles, 2000, 01, retard
#        Los Angeles, 2000, 02, retard
select a.Airport, f.colYear, lpad(f.colMonth, 2, '0') as month, avg(f.ArrDelay) as averageArrivalDelay
from Flights f INNER JOIN USAirports a on a.IATA = f.Origin
group by f.Origin, f.colYear, f.colMonth
order by a.Airport, f.colYear, f.colMonth asc;

# 5. Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma que les companyies amb més cancel·lacions apareguin les primeres.
select c.Description as carrier, count(*) as numCancelledFights
from Flights f INNER JOIN Carriers c ON f.UniqueCarrier = c.CarrierCode
where f.Cancelled = 1 
group by f.UniqueCarrier
order by count(*)  desc, c.Description asc;

# 6. L’identificador dels 10 avions que més distància han recorregut fent vols.
select f.TailNum, sum(f.Distance) as milles
from Flights f
group by f.TailNum
order by sum(f.Distance) desc
limit 10;

# 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí amb un retràs promig major de 10 minuts.
select c.Description, avg(f.ArrDelay) as averageArrivalDelay
from Flights f INNER JOIN Carriers c ON f.UniqueCarrier = c.CarrierCode
group by f.UniqueCarrier
having avg(f.ArrDelay)  > 10
order by avg(f.ArrDelay) desc, c.Description asc;



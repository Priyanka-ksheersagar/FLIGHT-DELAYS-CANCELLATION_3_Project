Queried the following questions: 

Retrieve the Total Number of Flights per Airline:
select airline, count(*) as num_of_flights
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT
group by airline

Find the Average Departure Delay for Each Airline:
select airline, round(avg(departure_delay),2)
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT
group by airline

Identify the Airports with the Highest Number of Cancellations:
Select A.AIRLINE_FF, COUNT(F.CANCELLED) AS num_of_cancelations
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F
Join FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRLINE A ON F.AIRLINE = A.AIRLINE_ABBR
Where CANCELLED=1
Group by A.AIRLINE_FF
order by  num_of_cancelations desc
limit 5

Top 5 Busiest Routes (Origin-Destination Pairs):
Query: Find the top 5 busiest flight routes (origin to destination) based on the number of flights.
SELECT airport, SUM(total_flights) AS total_flights
FROM (
    SELECT f.ORIGIN_AIRPORT AS airport, COUNT(*) AS total_flights
    FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
    GROUP BY f.ORIGIN_AIRPORT
    UNION ALL
    SELECT f.DESTINATION_AIRPORT AS airport, COUNT(*) AS total_flights
    FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
    GROUP BY f.DESTINATION_AIRPORT
) AS combined
GROUP BY airport
order by total_flights desc
limit 5

-- Calculate the Total Distance Flown by Each Airline:
-- Query: What is the total distance flown by each airline?
SELECT AE.AIRLINE_FF, SUM(F.DISTANCE) as distance_traveled
FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRLINE AE
JOIN FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F ON =AE.AIRLINE_ABBR = F.AIRLINE
GROUP BY AE.AIRLINE_FF
order by distance_traveled desc

-- List of All Flights Diverted:
-- Query: Retrieve a list of all flights that were diverted.
SELECT F.FLIGHT_NUMBER
from  FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F 
join FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRLINE AE
where f.diverted = 1


-- Find the Longest Flight Based on Distance:
-- Query: Which flight had the longest distance?
 SELECT F.FLIGHT_NUMBER, SUM(F.DISTANCE) as distance_traveled
FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F
GROUP BY F.FLIGHT_NUMBER
ORDER BY distance_traveled DESC
LIMIT 1

-- Calculate Average Taxi Out Time by Airline:
-- Query: What is the average taxi-out time for each airline?
 SELECT AE.AIRLINE_FF, round(AVG(F.TAXI_OUT),2) as AvgTAXI_OUT_TIME
FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRLINE AE
JOIN FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F ON AE.AIRLINE_ABBR = F.AIRLINE
GROUP BY AE.AIRLINE_FF
order by AE.AIRLINE_FF

-- Find Flights Delayed More Than 2 Hours:
-- Query: List all flights that had a delay of more than 2 hours at arrival.
SELECT FLIGHT_NUMBER, ORIGIN_AIRPORT, DESTINATION_AIRPORT, ARRIVAL_DELAY
FROM FLIGHT
WHERE ARRIVAL_DELAY > 120
ORDER BY FLIGHT_NUMBER

-- Identify the Cities with the Longest Average Departure Delays:
-- Query: Which cities (based on ORIGIN_AIRPORT) have the longest average departure delays?
SELECT  apt.city, avg(f.departure_delay) as avg_Departure_delay
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRPORTS apt
join FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f on apt.iata_code = f.origin_airport
group by apt.city

-- Find the Top 3 Airlines with the Most Cancelled Flights and Cancellation Reasons:
-- Query: Which airlines have the most cancelled flights and what are the main reasons for these cancellations?
select a.airline_ff, f.cancellation_reason, count(cancelled) as num_of_cancelations
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
join FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRLINE a on f.airline = a.airline_abbr
where cancelled = 1
group by a.airline_ff, f.cancellation_reason
limit 3


-- Determine the Impact of Weather on Flight Delays Across States:
-- Query: What is the total weather-related delay time for flights originating from each state?
select apt.state,  sum(f.weather_delay)
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
join FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRPORTS apt on f.origin_airport=apt.iata_code
where weather_delay is not null and weather_delay!=0
group by   apt.state

-- Find Flights that Have Both Departure and Arrival Delays:
-- Query: List all flights that were delayed at both departure and arrival.
select f.flight_number
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
where f.departure_delay >0 and f.arrival_delay>0

-- Calculate the Average Total Time on the Ground (Taxi-In + Taxi-Out) for Each Airline:
-- Query: What is the average ground time (taxi-in + taxi-out) for each airline?
select airline, ROUND(avg(f.taxi_in+TAXI_OUT),2) AS Average_Total_Time
from FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT f
group by airline

-- Determine the Longest Delayed Flight in Each City:
-- Query: What is the longest delayed flight (based on ARRIVAL_DELAY) in each city?
SELECT APT.CITY,  MAX(F.ARRIVAL_DELAY) AS Longest_Delayed_Flight
FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.AIRPORTS APT
 JOIN FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F ON APT.IATA_CODE=F.ORIGIN_AIRPORT
WHERE f.ARRIVAL_DELAY IS NOT NULL
GROUP BY APT.CITY
ORDER BY Longest_Delayed_Flight DESC
LIMIT 1

-- Flights with Delays Over 1 Hour and Their Cancellation Status:
-- Query: Find flights with arrival delays over 1 hour and their corresponding cancellation status.
SELECT F.FLIGHT_NUMBER, SUM(DEPARTURE_DELAY+ AIRLINE_DELAY), F.CANCELLED
FROM FLIGHT_DELAYS_CANCELLATIONS_2_PROJECT.PUBLIC.FLIGHT F
WHERE F.ARRIVAL_DELAY>60
GROUP BY F.FLIGHT_NUMBER, F.CANCELLED



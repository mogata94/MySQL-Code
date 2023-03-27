load data local infile '/Users/marcusogata/Desktop/Analytics/Airline Passenger Project/airline_passenger_satisfaction.csv' into table satisfaction fields terminated by ',' ignore 1 rows;

-- Satisfaction percentages based on total_satisfaction  
SELECT 
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Satisfied_' THEN 1 END))* 100/COUNT(*),2) "Percent Satisfied",
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Neutral or Dissatisfied_' THEN 1 END))* 100/COUNT(*),2) "Percent Neutral or Dissatisfied"  
FROM satisfaction; 

-- Satisfaction percentages based on  customer_type 
SELECT customer_type, 
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Satisfied_' THEN 1 END))* 100/COUNT(*),2) "Satisfied",
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Neutral or Dissatisfied_' THEN 1 END))* 100/COUNT(*),2) "Percent Neutral or Dissatisfied"  
FROM satisfaction
GROUP BY customer_type;

-- Satisfaction percentages based on type_of_travel, **Business** 
SELECT type_of_travel, 
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Satisfied_' THEN 1 END))* 100/COUNT(*),2) "Satisfied",
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Neutral or Dissatisfied_' THEN 1 END))* 100/COUNT(*),2) "Percent Neutral or Dissatisfied"  
FROM satisfaction
GROUP BY type_of_travel;

-- creating the returning customer profile 
SELECT
ROUND((COUNT(CASE WHEN customer_type = 'Returning' THEN 1 END))* 100/COUNT(*),2) "Returning"
FROM satisfaction;

SELECT
ROUND((COUNT(CASE WHEN type_of_travel = 'Business' THEN 1 END))* 100/COUNT(*),2) "Business",
ROUND((COUNT(CASE WHEN type_of_travel = 'Personal' THEN 1 END))* 100/COUNT(*),2) "Personal" 
FROM satisfaction 
WHERE customer_type = 'Returning';

SELECT
ROUND((COUNT(CASE WHEN class = 'Business' THEN 1 END))* 100/COUNT(*),2) "Business",
ROUND((COUNT(CASE WHEN class = 'Economy' THEN 1 END))* 100/COUNT(*),2) "Economy",
ROUND((COUNT(CASE WHEN class = 'Economy Plus' THEN 1 END))* 100/COUNT(*),2) "Economy Plus" 
FROM satisfaction 
WHERE customer_type = 'Returning';

SELECT AVG(flight_distance) average_flight_distance 
FROM satisfaction 
WHERE customer_type = 'Returning';

SELECT
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Satisfied_' THEN 1 END))* 100/COUNT(*),2) "Satisfied",
ROUND((COUNT(CASE WHEN total_satisfaction LIKE 'Neutral or Dissatisfied_' THEN 1 END))* 100/COUNT(*),2) "Neutral or Dissatisfied"  
FROM satisfaction
WHERE customer_type = 'Returning'; 

-- averages 
SELECT ROUND(AVG(flight_distance),2) avg_flight_distance,
	ROUND(AVG(departure_delay),2) avg_departure_delay,
    ROUND(AVG(arrival_delay),2) avg_arrival_delay,
    ROUND(AVG(departure_and_arrival_time_convenience),2) avg_departure_and_arrival_time_convenience_score,
	ROUND(AVG(ease_of_online_booking),2) avg_online_booking_score,
	ROUND(AVG(check_in_service),2) avg_check_in_service_score,
    ROUND(AVG(online_boarding),2) avg_online_boarding_score,
    ROUND(AVG(gate_location),2) avg_gate_location_score,
    ROUND(AVG(on_board_service),2) avg_on_board_service_score, 
    ROUND(AVG(seat_comfort),2) avg_seat_comfort_score, 
    ROUND(AVG(leg_room_service),2) avg_leg_room_service_score, 
    ROUND(AVG(cleanliness),2) avg_cleanliness_score, 
    ROUND(AVG(food_and_drink),2) avg_food_and_drink_score,
    ROUND(AVG(in_flight_service),2) avg_in_flight_service_score,
    ROUND(AVG(in_flight_wifi_service),2) avg_in_flight_wifi_service_score,
    ROUND(AVG(in_flight_entertainment),2) avg_in_flight_entertainment_score,
    ROUND(AVG(baggage_handling),2) avg_baggage_handling_score
FROM satisfaction; 






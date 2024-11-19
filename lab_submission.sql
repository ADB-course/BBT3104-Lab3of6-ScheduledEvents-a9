-- CREATE EVN_average_customer_waiting_time_every_1_hour

DELIMITER //
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    DECLARE avg_waiting_time DECIMAL(10, 2);    
    SELECT AVG(TIMESTAMPDIFF(MINUTE, ticket_created_at, ticket_resolved_at)) INTO avg_waiting_time
    FROM customer_service_ticket
    WHERE ticket_created_at >= NOW() - INTERVAL 1 HOUR;
    INSERT INTO customer_service_kpi (kpi_name, kpi_value, recorded_at)
    VALUES ('Average Customer Waiting Time', avg_waiting_time, NOW());
END //
DELIMITER ;
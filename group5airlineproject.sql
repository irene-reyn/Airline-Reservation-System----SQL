-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 12, 2025 at 06:10 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `group5airlineproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `passenger_id` int NOT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('CONFIRMED','CANCELLED','PENDING') DEFAULT 'PENDING',
  `total_amount` decimal(8,2) NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `unique_passenger_flight` (`passenger_id`,`flight_id`),
  KEY `idx_flight` (`flight_id`),
  KEY `idx_passenger` (`passenger_id`),
  KEY `idx_status` (`status`),
  KEY `idx_booking_status` (`status`),
  KEY `idx_booking_composite` (`passenger_id`,`flight_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
CREATE TABLE IF NOT EXISTS `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(20) NOT NULL,
  `arrival_city` varchar(30) NOT NULL,
  `departure_city` varchar(30) NOT NULL,
  `arrival_time` datetime NOT NULL,
  `departure_time` datetime NOT NULL,
  `available_seats` int NOT NULL,
  `total_seats` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  PRIMARY KEY (`flight_id`),
  UNIQUE KEY `flight_number` (`flight_number`),
  KEY `idx_flight_number` (`flight_number`),
  KEY `idx_route` (`departure_city`,`arrival_city`),
  KEY `idx_departure_time` (`departure_time`),
  KEY `idx_composite_route` (`departure_city`,`arrival_city`,`departure_time`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`flight_id`, `flight_number`, `arrival_city`, `departure_city`, `arrival_time`, `departure_time`, `available_seats`, `total_seats`, `price`) VALUES
(1, 'BB101', 'Accra', 'Kumasi', '2025-11-08 11:30:00', '2025-11-08 08:00:00', 180, 180, 900.00),
(2, 'BB102', 'Kumasi', 'Accra', '2025-11-08 22:30:00', '2025-11-08 14:00:00', 175, 180, 900.00),
(3, 'UB201', 'Sunyani', 'Kumasi', '2025-11-08 10:45:00', '2025-11-08 09:15:00', 150, 150, 600.00),
(4, 'AA301', 'Cape Coast', 'Accra', '2025-11-08 08:15:00', '2025-11-08 07:00:00', 120, 120, 300.00);

-- --------------------------------------------------------

--
-- Table structure for table `flight_schedule`
--

DROP TABLE IF EXISTS `flight_schedule`;
CREATE TABLE IF NOT EXISTS `flight_schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(20) NOT NULL,
  `route_id` int NOT NULL,
  `aircraft_type` varchar(30) DEFAULT NULL,
  `monday` tinyint(1) DEFAULT '0',
  `tuesday` tinyint(1) DEFAULT '0',
  `wednesday` tinyint(1) DEFAULT '0',
  `thursday` tinyint(1) DEFAULT '0',
  `friday` tinyint(1) DEFAULT '0',
  `saturday` tinyint(1) DEFAULT '0',
  `sunday` tinyint(1) DEFAULT '0',
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `route_id` (`route_id`),
  KEY `idx_schedule_flight` (`flight_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
CREATE TABLE IF NOT EXISTS `passengers` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `email_address` (`email_address`),
  KEY `idx_email` (`email_address`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`passenger_id`, `first_name`, `last_name`, `email_address`, `phone`, `created_at`) VALUES
(1, 'Fred', 'Opoku', 'fred.opoku@bluecrest.com', '02441111', '2025-11-12 06:08:59'),
(2, 'Prince', 'Ashong', 'prince.ashong@bluecrest.com', '02442222', '2025-11-12 06:08:59'),
(3, 'Adjoa', 'Irene', 'adjoa.irene@bluecrest.com', '02443333', '2025-11-12 06:08:59'),
(4, 'Alex', 'Saidou', 'alex.saidou@bluecrest.com', '02444444', '2025-11-12 06:08:59');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(8,2) NOT NULL,
  `payment_method` enum('CREDIT_CARD','DEBIT_CARD','PAYPAL','BANK_TRANSFER') NOT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `status` enum('COMPLETED','FAILED','PENDING','REFUNDED') DEFAULT 'PENDING',
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `idx_booking` (`booking_id`),
  KEY `idx_transaction` (`transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
CREATE TABLE IF NOT EXISTS `routes` (
  `route_id` int NOT NULL AUTO_INCREMENT,
  `arrival_city` varchar(30) DEFAULT NULL,
  `departure_city` varchar(30) NOT NULL,
  `distance_miles` int DEFAULT NULL,
  `base_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `idx_route_cities` (`departure_city`,`arrival_city`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`route_id`, `arrival_city`, `departure_city`, `distance_miles`, `base_price`) VALUES
(1, 'Accra', 'Kumasi', 500, 900.00),
(2, 'Sunyani', 'Kumasi', 350, 600.00),
(3, 'Cape Coast', 'Accra', 200, 300.00),
(4, 'Winneba', 'Sunyani', 700, 950.00),
(5, 'Bolgatanga', 'Tamale', 300, 500.00);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

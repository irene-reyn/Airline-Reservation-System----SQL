

# Airline Reservation System Database

## Overview

This project implements a relational database for an Airline Reservation System designed to manage flights, passengers, bookings, and payments efficiently. The system focuses on data integrity, transactional reliability, and performance optimization using core database principles such as normalization, indexing, concurrency control, and ACID compliance.

The database is built using MySQL and models real world airline operations including seat allocation, booking validation, and payment tracking.

## Key Features

The system supports flight scheduling, passenger management, booking operations, and payment recording. All entities are connected through foreign key relationships to enforce referential integrity. The design follows Third Normal Form to eliminate redundancy and ensure consistency.

Transactions are handled atomically to prevent partial updates, especially during booking and payment operations. Concurrency control mechanisms prevent race conditions such as double booking of seats. Indexes are applied to frequently queried fields to improve query performance as the dataset grows.

## Database Design

The core entities in the system include Flights, Routes, Passengers, Bookings, and Payments.

A flight represents a scheduled journey between two cities with a defined departure time, arrival time, seat capacity, and price. Passengers store personal and contact information. Bookings link passengers to flights and record seat numbers and booking status. Payments record financial transactions associated with bookings.

The Entity Relationship Diagram illustrates these relationships and cardinalities. The Use Case Diagram shows how passengers and administrators interact with the system.

   ##Use Case Diagram

 ![Use Case Diagram](https://github.com/irene-reyn/Airline-Reservation-System----SQL/blob/Google-playstore-apps-analysis/Use%20case%20diagram.png)
  
  ##ERD 
 
 ![ERD](https://github.com/irene-reyn/Airline-Reservation-System----SQL/blob/Google-playstore-apps-analysis/ERD.png)
 

## Sample Schema Snippet

```sql
CREATE DATABASE AirlineReservation;
USE AirlineReservation;

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    departure_city VARCHAR(30) NOT NULL,
    arrival_city VARCHAR(30) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    available_seats INT NOT NULL,
    total_seats INT NOT NULL,
    price DECIMAL(8,2) NOT NULL
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seat_number VARCHAR(10),
    status ENUM('CONFIRMED','CANCELLED','PENDING') DEFAULT 'PENDING',
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id)
);
```

## ACID Compliance

Atomicity ensures that booking and payment operations either complete fully or fail without altering the database state. This is implemented using explicit transaction control statements.

Consistency guarantees that database rules are preserved, such as seat availability being reduced only when a booking is confirmed.

Isolation prevents concurrent transactions from interfering with each other. Row level locking ensures that two users cannot book the same seat simultaneously.

Durability ensures that committed transactions persist even in the event of a system failure.

## Stored Procedures and Concurrency Control

Stored procedures encapsulate complex operations such as booking validation, seat allocation, and cancellation. These procedures run within controlled transactions to enforce business rules consistently.

Concurrency control is achieved using locking mechanisms during seat availability checks. This prevents overbooking under high concurrent access scenarios.

## Performance Optimization

Indexes are created on commonly queried fields such as flight routes, booking status, and passenger identifiers. Query execution plans confirm reduced scan times after indexing.

Normalization minimizes redundancy while maintaining efficient joins across related tables.

## Project Structure

```
Airline-Reservation-System/
│
├── sql/
│   ├── schema.sql
│   ├── procedures.sql
│
├── images/
│   ├── erd.png
│   ├── use_case.png
│
├── README.md
```

## Requirements

MySQL Server
phpMyAdmin or any MySQL client
Basic understanding of SQL and relational databases

## Conclusion

This project demonstrates the practical application of relational database concepts in a transactional system. By combining strong schema design, ACID compliance, concurrency control, and performance optimization techniques, the Airline Reservation System provides a reliable and scalable foundation for managing airline operations.


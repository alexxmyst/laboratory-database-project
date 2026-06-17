# Environmental Analysis Laboratory Management System

## Project Overview
This project features a comprehensive relational database system designed to support the operations of an environmental analysis laboratory. The system manages the entire workflow of environmental testing—from initial client requests and field sample collection to multi-parameter laboratory analysis, and final report generation.

## Key Features & Business Logic
* **Client & Employee Management:** Tracks clients placing orders and laboratory personnel. Any employee can perform analyses and contribute to final reports.
* **Field Sampling Tracking:** Supports the logic where a single field trip yields multiple environmental samples, each tied to specific geographic locations and sample types.
* **Multi-Level Analysis:** Each collected sample can undergo multiple types of environmental tests based on standardized laboratory methodologies.
* **Collaborative Reporting:** Manages final certification reports delivered to clients, allowing multiple employees to collaborate on a single comprehensive report.

## Database Schema & Core Concepts
The database architecture enforces strong data integrity through constraints (Primary Keys, Foreign Keys, Unique, and Check constraints) to map out complex relations.

## Technical Stack
* **SQL / PL/SQL** (Oracle Database / PostgreSQL)
* **DDL Scripts:** Table creation, schema definition, and integrity constraints.
* **DML Scripts:** Mock data population for testing.
* **PL/SQL Programmability:** Custom procedures, functions, **cursors** for report compilation, and **triggers** for automated logging/validation.

## How to Run
1. Execute the `structure_ddl.sql` script to build the database schema and populate tables with sample laboratory data.
2. Check `triggers_and_cursors` and `analytical_queries.sql` to view sample procedures, cursors, and triggers in action.

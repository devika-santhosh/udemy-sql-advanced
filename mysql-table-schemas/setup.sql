-- MySQL Table Schemas Setup
-- Run this file to create all tables in the correct order

-- Create database (optional - uncomment if needed)
-- CREATE DATABASE IF NOT EXISTS maven_advanced_sql;
-- USE maven_advanced_sql;

-- Drop tables if they already exist (in reverse order of creation)
DROP TABLES IF EXISTS schools, school_details, salaries, players;

-- Create tables in order (dependencies first)
SOURCE schemas/school_details.sql;
SOURCE schemas/schools.sql;
SOURCE schemas/salaries.sql;
SOURCE schemas/players.sql;

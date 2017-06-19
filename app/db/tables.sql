DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS holidays;
DROP TABLE IF EXISTS travel_agents;
DROP TABLE IF EXISTS hotels;

-- database name: holiday_tracker

CREATE TABLE travel_agents(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  logo_url VARCHAR(255)
);

CREATE TABLE hotels(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  stars INT2,
  image_url VARCHAR(255)
);

CREATE TABLE holidays(
  id SERIAL4 PRIMARY KEY,
  travel_agent_id INT4 REFERENCES travel_agents(id),
  hotel_id INT4 REFERENCES hotels(id),
  cost_per_person INT2,
  nights INT2
);

CREATE TABLE deals(
  id SERIAL4 PRIMARY KEY,
  holiday_id INT4 REFERENCES holidays(id),
  percentage_off INT2 CHECK(percentage_off>0 AND percentage_off<100),
  start_date CHAR(10),
  end_date CHAR(10)
);

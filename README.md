# Flight Tracking App

A flight tracking application that allows a user to enter the airline, flight number, destination, and departure time for a flight.

## Outlne for the App

### Pages

Homepage
- Title
- Link to add a flight
- List of flights planned

Add a flight
- Form for each
  - Title
  - Airline
  - Flight number
  - Destination
  - Departure time
  - Inspo photo?

Flight details
- Title
- Info entered
- Edit button

Edit page
- Form for each
  - Title
  - Airline
  - Flight number
  - Destination
  - Departure time
  - Inspo photo?

### Background
Database to hold the info
- Airlines
  - Id
  - Name

- Flights
 - Id
 - Flight number
 - Destination
 - Departure time
 - Airline id

- Inspo photo held in the session via cookies?

## Details

Some things to think about:
- Store data in a user's session or a file
- Add validations to validate values submitted via forms (including flash messages)
- Keep shared content in a layout

Should be able to 
- write a Ruby application using Sinatra
- write enough ERB code to display your application in a browser.
- create Gemfile and Gemfile.lock files so your grader can run the code on their system
- provide the SQL needed to create and seed any databases you require.
- you do not need CSS if you do not want to use it. We do not require a pretty application for this project.
- save your project in a zip file and upload it after completing the project
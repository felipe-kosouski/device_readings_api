# Device Readings API

This is an in-memory API for receiving and processing readings from devices, designed to store readings temporarily in memory without persistent storage. The API supports storing readings, retrieving the latest reading timestamp, and calculating the cumulative count across all readings for a device.

## Project Structure

- `app/repositories/device_store.rb` - Repository responsible for managing device storage and retrieval.

- `app/services/device_service.rb` - Service object responsible for managing device operations, including adding readings, calculating cumulative count, and finding the latest timestamp.

- `app/models/device_data.rb` - Data model to hold individual device information in memory.

- `app/controllers/readings_controller.rb` - Controller for handling API requests and responses.


## Requirements
* Ruby 3.1.x
* Rails 7.2.x

## Installation

1. Clone the repository
```bash
git clone https://github.com/felipe-kosouski/device_readings_api.git
cd device_readings_api
```

2. Install dependencies
```bash
bundle install
```

3. Start the server
```bash
rails s
```

## Running tests
```bash
bundle exec rspec
```

## API Endpoints

1. Store Readings
```bash
POST /readings
Description: Accepts a device ID and an array of readings, storing them in memory.
Responses 
200: OK
422: Unprocessable Entity

Request Body:
{
  "id": "36d5658a-6908-479e-887e-a949ec199272",
  "readings": [
    {
      "timestamp": "2021-09-29T16:08:15+01:00",
      "count": 10
    },
    {
      "timestamp": "2021-09-29T16:09:15+01:00",
      "count": 5
    }
  ]
}
```

2. Get Latest Reading Timestamp
```bash
GET /latest_timestamp/:device_id
Description: Returns the latest timestamp of readings for a specific device.
Responses
200: OK
404: Not Found
Example Response:
{
  "latest_timestamp": "2021-09-29T16:09:15+01:00"
}
```

3. Get Cumulative Count
```bash
GET /cumulative_count/:device_id
Description: Returns the cumulative count of all readings for a specific device.
Responses
200: OK
404: Not Found
Example Response:
{
  "cumulative_count": 15
}
```

## Improvements and future work
- Add more tests to cover edge cases and improve test coverage.
- Add validations to the request body to ensure the data is in the correct format.
- Enhance the error handling to provide more detailed error messages.
- Pagination and filtering on readings to optimize performance for devices with high frequency data.
- Rate limiting to prevent abuse of the API.
- Add a persistent storage layer to store readings in a database for long-term storage.
- Containerize the application using Docker for easy deployment and scaling.
- Better documentation and API specification using Swagger or OpenAPI.

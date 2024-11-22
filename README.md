---

# Notifications Microservice

The **Notifications Microservice** is a part of a multi-service architecture designed to handle notifications related to task updates. It is developed using Ruby on Rails and communicates with other services such as the main application, scraping service, and authentication service. This microservice is fully containerized with Docker and is designed for seamless integration into the larger architecture.

---

## Features

- **Task Notifications**:
  - Sends notifications about task updates (e.g., status changes).
  - Integrates with other services for real-time updates.
- **RESTful API**:
  - Exposes endpoints for external services to interact with the notification system.
- **Dockerized Deployment**:
  - Fully containerized for easy setup and deployment using Docker Compose.

---

## Architecture

The Notifications Microservice works as part of a larger architecture:
- It listens for updates from the main application and scraping service.
- Updates the notification queue and responds to task status changes.

---

## Prerequisites

Before setting up the Notifications Microservice, ensure you have:

- [Docker](https://www.docker.com/get-started) installed (Version 20.10 or higher).
- [Docker Compose](https://docs.docker.com/compose/) installed (Version 2.x or higher).
- PostgreSQL (via Docker).
- Access to other repositories in the ecosystem:
  - [Main App](https://github.com/joaoguiIherme/main_app)
  - [Auth Service](https://github.com/joaoguiIherme/auth_service)
  - [Scraping Service](https://github.com/joaoguiIherme/scraping_service)

---

## Installation

### 1. Clone the Repository

Clone this repository into your workspace:
```bash
git clone https://github.com/joaoguiIherme/notifications_service.git
```

### 2. File Structure Adjustment

Ensure this microservice is placed in the same directory as the other services. The recommended directory structure is as follows:

```plaintext
Main-Root Dir/
├── auth_service/
├── main_app/
├── notifications_service/ (this repository)
├── scraping_service/
└── docker-compose.yml
```

Ensure the `docker-compose.yml` file is located in the root directory for multi-service orchestration.

### 3. Build and Start Services

Use Docker Compose to build and run all services:
```bash
docker-compose up --build
```

### 4. Access Notifications Service

The Notifications Microservice runs on [http://localhost:4001](http://localhost:4001).

---

## API Endpoints

The following endpoints are exposed by the Notifications Microservice:

### GET `/notifications`
- **Description**: Retrieves all notifications.
- **Response**:
  - `200 OK`: A list of notifications in JSON format.

### POST `/notifications/update_task_status`
- **Description**: Updates the status of a task based on incoming events.
- **Request**:
  - `task_id` (String): The ID of the task to update.
  - `event_type` (String): The type of event (`scrape_completed`, `scrape_failed`).
- **Response**:
  - `200 OK`: Success message.
  - `404 Not Found`: Task not found.
  - `422 Unprocessable Entity`: Invalid event type.

---

## Configuration

### Environment Variables

This service relies on environment variables, which are defined in the `docker-compose.yml` file:

- `DATABASE_URL`: Connection string for the PostgreSQL database.

### Network Configuration

The service uses the `app_network` Docker network to communicate with other services. Ensure that the service names in your code (e.g., `main_app`, `scraping_service`) match those defined in `docker-compose.yml`.

---

## Testing

Run the following commands to test the Notifications Microservice:

### 1. Access the Container

```bash
docker exec -it notifications_service bash
```

### 2. Run Tests

Run RSpec tests to validate functionality:
```bash
bundle exec rspec
```

---

## Troubleshooting

### Common Issues

1. **Database Connection Issues**:
   - Ensure the `db` service is running, and the `DATABASE_URL` is correctly set.

2. **Host Authorization Errors**:
   - Add `config.hosts << "notifications_service"` in `config/application.rb` if needed.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push to your fork.
4. Submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.

---

## Acknowledgments

This microservice is part of a larger architecture demonstrating the power of microservices with Docker and Ruby on Rails.

--- 

If you need additional details or want to customize specific sections, let me know!

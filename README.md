# CourseFlow

**Streamlined Course Registration System**

An intelligent course registration platform built with Java, Spring Boot, and AI-powered recommendations.

## 🎯 Features

### Core Functionality
- **Smart Course Catalog** - Search and filter courses with real-time availability
- **Intelligent Enrollment** - Automatic prerequisite validation and conflict detection
- **Waitlist Management** - Automated enrollment when seats become available
- **Schedule Builder** - Visual calendar with drag-and-drop interface

### AI-Powered Features
- **Course Recommendations** - Collaborative filtering based on enrollment patterns
- **Schedule Optimization** - Smart suggestions for optimal course combinations
- **Success Prediction** - Recommend courses based on student performance patterns

## 🏗️ Architecture

### Technology Stack
- **Backend:** Spring Boot 3.x, Java 17+
- **Database:** PostgreSQL 15+
- **ORM:** JPA/Hibernate
- **Frontend:** JavaFX (Desktop) / React (Web)
- **Build Tool:** Maven
- **AI/ML:** Custom collaborative filtering algorithm

### Design Patterns
- **Singleton:** Database connection management
- **Factory:** User type creation (Student, Admin, Faculty)
- **Strategy:** Enrollment policies
- **Observer:** Real-time seat availability updates
- **DAO:** Repository layer
- **MVC:** Layered architecture (Controller → Service → Repository)

## 📁 Project Structure

```
courseflow/
├── courseflow-backend/          # Spring Boot REST API
│   ├── src/main/java/com/courseflow/
│   │   ├── model/              # JPA entities
│   │   ├── repository/         # Data access layer
│   │   ├── service/            # Business logic
│   │   ├── controller/         # REST endpoints
│   │   ├── dto/                # Data transfer objects
│   │   ├── exception/          # Custom exceptions
│   │   └── ai/                 # Recommendation engine
│   └── src/main/resources/
│       ├── application.properties
│       └── data.sql            # Sample data
├── courseflow-frontend/         # UI (JavaFX or React)
├── courseflow-database/         # SQL scripts
│   ├── schema.sql
│   ├── sample-data.sql
│   └── indexes.sql
└── docs/                       # Documentation
    ├── api-docs.md
    ├── architecture.md
    └── user-guide.md
```

## 🚀 Quick Start

### Prerequisites
- Java 17 or higher
- PostgreSQL 15+
- Maven 3.8+
- Node.js 18+ (if using React frontend)

### Database Setup
```bash
# Create database
createdb courseflow_db

# Run schema
psql -d courseflow_db -f courseflow-database/schema.sql

# Load sample data
psql -d courseflow_db -f courseflow-database/sample-data.sql
```

### Backend Setup
```bash
cd courseflow-backend
mvn clean install
mvn spring-boot:run
```

### Frontend Setup
```bash
cd courseflow-frontend
# For JavaFX
mvn javafx:run

# For React
npm install
npm start
```

## 📊 Database Schema

### Core Tables
- `students` - Student information and academic records
- `courses` - Course catalog with descriptions
- `sections` - Course sections with schedules and capacity
- `enrollments` - Student enrollments with status
- `prerequisites` - Course prerequisite relationships
- `waitlist` - Waitlist queue management

## 🧪 Testing

```bash
# Run unit tests
mvn test

# Run integration tests
mvn verify

# Generate coverage report
mvn jacoco:report
```

## 👥 Team Members

- [Your Name] - Backend & Database Lead
- [Team Member 2] - Frontend & Integration
- [Team Member 3] - AI/ML & Testing

## 📝 License

Academic Project - [Your University Name] - [Year]

## 🙏 Acknowledgments

Built as part of [Course Name/Number] academic project.
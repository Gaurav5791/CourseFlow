# CourseFlow - Getting Started Guide

**Project Name:** CourseFlow  
**Tagline:** Streamlined Course Registration System  
**Team:** 2-3 members  
**Timeline:** 2-4 weeks  

---

## 📋 Prerequisites Checklist

Before starting, ensure you have:

- [ ] **Java 17 or higher** - `java -version`
- [ ] **PostgreSQL 15+** - `psql --version`
- [ ] **Maven 3.8+** - `mvn -version`
- [ ] **Git** - `git --version`
- [ ] **IDE** - IntelliJ IDEA (recommended) or Eclipse
- [ ] **Text Editor** - VS Code (optional, for frontend)
- [ ] **Node.js 18+** (if building React frontend)

---

## 🚀 Quick Setup (30 Minutes)

### Step 1: Clone/Create Project Directory

```bash
# Create project directory
mkdir courseflow
cd courseflow

# Initialize Git repository
git init
git remote add origin https://github.com/yourusername/courseflow.git
```

### Step 2: Database Setup

```bash
# Login to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE courseflow_db;

# Exit psql
\q

# Run schema creation
psql -U postgres -d courseflow_db -f courseflow-database/schema.sql

# Load sample data
psql -U postgres -d courseflow_db -f courseflow-database/sample-data.sql

# Verify installation
psql -U postgres -d courseflow_db -c "SELECT 'Students' as table_name, COUNT(*) FROM students;"
```

**Expected Output:**
```
 table_name | count 
------------+-------
 Students   |     8
```

### Step 3: Backend Setup

```bash
cd courseflow-backend

# Update database credentials
# Edit src/main/resources/application.properties
# Change: spring.datasource.password=your_password_here

# Install dependencies and run
mvn clean install
mvn spring-boot:run
```

**Expected Output:**
```
Started CourseFlowApplication in X.XXX seconds
```

**Test the API:**
```bash
curl http://localhost:8080/actuator/health
# Should return: {"status":"UP"}
```

### Step 4: Verify Everything Works

**Check database connection:**
```bash
# Open new terminal
psql -U postgres -d courseflow_db

# Run verification query
SELECT c.course_code, c.course_name, s.section_number, s.enrolled_count, s.capacity
FROM courses c
JOIN sections s ON c.course_id = s.course_id
WHERE s.semester = 'SPRING' AND s.year = 2026
LIMIT 5;
```

**You should see course sections with availability.**

---

## 👥 Team Member Setup Guide

### Person 1: Database + Backend Lead

**Your Responsibilities:**
- Database schema management
- Core business logic (enrollment, prerequisites, conflicts)
- REST API endpoints
- Transaction management

**Initial Tasks:**
```bash
# 1. Ensure database is running
psql -U postgres -d courseflow_db -c "\dt"

# 2. Create sample admin account
psql -U postgres -d courseflow_db <<EOF
INSERT INTO admins (username, password_hash, email, full_name, role) 
VALUES ('myteam', '\$2a\$10\$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 
        'myteam@courseflow.edu', 'My Team', 'ADMIN');
EOF

# 3. Test connection from Java
cd courseflow-backend/src/test/java/com/courseflow
# Create DatabaseConnectionTest.java (see below)
```

**DatabaseConnectionTest.java:**
```java
package com.courseflow;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import javax.sql.DataSource;
import java.sql.Connection;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class DatabaseConnectionTest {
    @Autowired
    private DataSource dataSource;
    
    @Test
    void testDatabaseConnection() throws Exception {
        try (Connection conn = dataSource.getConnection()) {
            assertNotNull(conn);
            assertTrue(conn.isValid(2));
        }
    }
}
```

---

### Person 2: Frontend + Integration Lead

**Your Responsibilities:**
- UI/UX design and implementation
- API integration
- User experience flows
- Frontend testing

**Initial Tasks:**
```bash
# Decision: JavaFX or React?
# Option A: JavaFX (Desktop App)
cd courseflow-frontend
# Create Maven project for JavaFX

# Option B: React (Web App)
cd courseflow-frontend
npx create-react-app courseflow-ui
cd courseflow-ui
npm install axios react-router-dom

# Test API connectivity
curl http://localhost:8080/actuator/health
```

**Sample API Test (React):**
```javascript
// src/services/api.js
import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080/api';

export const courseApi = {
    getAllCourses: () => axios.get(`${API_BASE_URL}/courses`),
    searchCourses: (query) => axios.get(`${API_BASE_URL}/courses/search?q=${query}`)
};

// Test in console:
// import { courseApi } from './services/api';
// courseApi.getAllCourses().then(console.log);
```

---

### Person 3: AI/ML + Testing Lead

**Your Responsibilities:**
- Recommendation algorithm implementation
- AI integration with backend
- Testing strategy
- Demo preparation

**Initial Tasks:**
```bash
# 1. Analyze sample data for patterns
psql -U postgres -d courseflow_db <<EOF
-- Find students who took similar courses
SELECT s1.student_id, s2.student_id, 
       COUNT(*) as common_courses
FROM enrollments e1
JOIN enrollments e2 ON e1.section_id = e2.section_id
JOIN students s1 ON e1.student_id = s1.student_id
JOIN students s2 ON e2.student_id = s2.student_id
WHERE s1.student_id < s2.student_id
  AND e1.status = 'COMPLETED'
  AND e2.status = 'COMPLETED'
GROUP BY s1.student_id, s2.student_id
HAVING COUNT(*) >= 2
ORDER BY common_courses DESC;
EOF

# 2. Create AI package structure
cd courseflow-backend/src/main/java/com/courseflow
mkdir -p ai/model ai/service ai/dto
```

---

## 📂 Project Structure Explained

```
courseflow/
├── README.md                           # Main documentation
├── courseflow-backend/                 # Spring Boot API
│   ├── pom.xml                        # Maven dependencies
│   └── src/
│       ├── main/
│       │   ├── java/com/courseflow/
│       │   │   ├── CourseFlowApplication.java    # Main entry point
│       │   │   ├── model/             # JPA Entities (Student, Course, etc.)
│       │   │   ├── repository/        # Database access (StudentRepo, CourseRepo)
│       │   │   ├── service/           # Business logic (EnrollmentService)
│       │   │   ├── controller/        # REST endpoints (StudentController)
│       │   │   ├── dto/               # Data transfer objects (StudentDTO)
│       │   │   ├── exception/         # Custom exceptions
│       │   │   ├── config/            # Spring configuration
│       │   │   └── ai/                # Recommendation engine
│       │   └── resources/
│       │       └── application.properties
│       └── test/                      # Unit and integration tests
├── courseflow-frontend/               # UI (JavaFX or React)
├── courseflow-database/               # SQL scripts
│   ├── schema.sql                     # Database structure
│   ├── sample-data.sql                # Test data
│   └── indexes.sql                    # Performance indexes
└── docs/                              # Documentation
```

---

## 🎯 Development Workflow

### Daily Workflow

**Morning Standup (5 min):**
- What did you do yesterday?
- What will you do today?
- Any blockers?

**Development Cycle:**
```bash
# 1. Pull latest changes
git pull origin main

# 2. Create feature branch
git checkout -b feature/enrollment-service

# 3. Make changes, test locally
mvn test  # Backend
npm test  # Frontend

# 4. Commit and push
git add .
git commit -m "feat: implement enrollment validation"
git push origin feature/enrollment-service

# 5. Create Pull Request (if using GitHub)
# 6. Team reviews, then merge to main
```

### Git Commit Convention

```
feat: Add course recommendation algorithm
fix: Resolve enrollment race condition
docs: Update API documentation
test: Add unit tests for prerequisite validation
refactor: Simplify enrollment service logic
```

---

## 🧪 Testing Strategy

### Backend Testing

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=EnrollmentServiceTest

# Generate coverage report
mvn jacoco:report
# Open: target/site/jacoco/index.html
```

**Test Coverage Goals:**
- Services: 80%+ coverage
- Controllers: 70%+ coverage
- Repositories: Basic integration tests

### Manual Testing Checklist

**Core Functionality:**
- [ ] Student can login
- [ ] Browse course catalog
- [ ] Search courses
- [ ] Add course to cart
- [ ] Prerequisite validation works
- [ ] Time conflict detection works
- [ ] Enrollment succeeds when seats available
- [ ] Waitlist adds when section full
- [ ] Student can drop course
- [ ] Admin can manage courses

**AI Features:**
- [ ] Recommendations appear
- [ ] Recommendations are relevant
- [ ] Explanation makes sense

---

## 🐛 Troubleshooting

### Common Issues

**Issue: "Port 8080 already in use"**
```bash
# Find process using port
lsof -i :8080
# Kill process
kill -9 <PID>
# Or change port in application.properties
```

**Issue: "Cannot connect to database"**
```bash
# Check PostgreSQL is running
pg_isready
# If not running:
sudo service postgresql start  # Linux
brew services start postgresql # Mac
```

**Issue: "Password authentication failed"**
```bash
# Update application.properties with correct password
spring.datasource.password=your_actual_password

# Or reset postgres password
sudo -u postgres psql
ALTER USER postgres PASSWORD 'newpassword';
```

**Issue: "Table doesn't exist"**
```bash
# Re-run schema
psql -U postgres -d courseflow_db -f courseflow-database/schema.sql
```

---

## 📊 Demo Preparation

### Week Before Demo

1. **Data Preparation:**
```bash
# Clean database
psql -U postgres -d courseflow_db -c "DELETE FROM enrollments WHERE status = 'ENROLLED';"
# Reset to clean state for demo
```

2. **Create Demo Scenarios:**
- Demo Account 1: New student browsing courses
- Demo Account 2: Student with prerequisites met
- Demo Account 3: Student getting recommendations

3. **Record Backup Video:**
```bash
# Use OBS Studio or similar
# Show: Login → Browse → Get Recommendations → Enroll → View Schedule
```

### Demo Script

**Opening (30 sec):**
"This is CourseFlow - a streamlined course registration system. We'll demo the core enrollment flow and our AI-powered recommendation engine."

**Core Features (2 min):**
1. Login as student
2. Browse course catalog
3. Show prerequisite validation
4. Show time conflict detection
5. Add course to cart
6. Submit enrollment

**AI Feature (1 min):**
1. Show recommendations panel
2. Explain: "Based on students with similar course history"
3. Click recommended course
4. Show it meets prerequisites

**Technical Highlights (30 sec):**
"Built with Spring Boot, PostgreSQL, and custom collaborative filtering. Implements Factory, Singleton, Strategy, and Observer patterns."

---

## 📝 Final Checklist

**Before Submission:**
- [ ] Code is on GitHub with proper commits
- [ ] README.md is complete
- [ ] Database schema documented
- [ ] API endpoints documented
- [ ] All tests passing
- [ ] Demo video recorded
- [ ] Project report written
- [ ] Design patterns highlighted in code comments

---

## 🆘 Need Help?

**Common Resources:**
- Spring Boot Docs: https://docs.spring.io/spring-boot/docs/current/reference/html/
- PostgreSQL Docs: https://www.postgresql.org/docs/
- JavaFX Tutorial: https://openjfx.io/openjfx-docs/
- React Tutorial: https://react.dev/learn

**Quick Commands Reference:**
```bash
# Database
psql -U postgres -d courseflow_db
\dt                           # List tables
\d students                   # Describe table
SELECT * FROM students;       # Query

# Backend
mvn clean install            # Build
mvn spring-boot:run          # Run
mvn test                     # Test
curl http://localhost:8080/api/courses  # Test API

# Frontend (React)
npm start                    # Run dev server
npm test                     # Run tests
npm run build                # Production build
```

---

## 🎉 Success Criteria

**Your project is ready when:**
1. ✅ Database has 50+ courses, 100+ students
2. ✅ Core enrollment flow works end-to-end
3. ✅ AI recommendations are relevant
4. ✅ All major features have tests
5. ✅ UI is polished and responsive
6. ✅ Demo runs smoothly without errors
7. ✅ Code demonstrates design patterns
8. ✅ Documentation is complete

**Good luck building CourseFlow! 🚀**
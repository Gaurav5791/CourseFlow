-- CourseFlow Database Schema
-- Streamlined Course Registration System
-- PostgreSQL 15+

-- Drop existing tables if they exist (for fresh setup)
DROP TABLE IF EXISTS waitlist CASCADE;
DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE IF EXISTS prerequisites CASCADE;
DROP TABLE IF EXISTS sections CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS admins CASCADE;

-- Students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    major VARCHAR(100),
    current_semester INTEGER DEFAULT 1,
    gpa DECIMAL(3,2) CHECK (gpa >= 0.0 AND gpa <= 4.0),
    max_credits INTEGER DEFAULT 18,
    status VARCHAR(20) DEFAULT 'ACTIVE', -- ACTIVE, INACTIVE, GRADUATED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admins Table
CREATE TABLE admins (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) DEFAULT 'ADMIN', -- ADMIN, REGISTRAR, SUPER_ADMIN
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    credits INTEGER NOT NULL CHECK (credits > 0),
    department VARCHAR(100) NOT NULL,
    difficulty_level VARCHAR(20), -- BEGINNER, INTERMEDIATE, ADVANCED
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sections Table (Multiple sections per course)
CREATE TABLE sections (
    section_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
    section_number VARCHAR(10) NOT NULL,
    semester VARCHAR(20) NOT NULL, -- FALL, SPRING, SUMMER
    year INTEGER NOT NULL,
    instructor VARCHAR(100),
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    enrolled_count INTEGER DEFAULT 0 CHECK (enrolled_count >= 0),
    waitlist_count INTEGER DEFAULT 0 CHECK (waitlist_count >= 0),
    schedule_days VARCHAR(20), -- e.g., "MWF", "TTh"
    start_time TIME,
    end_time TIME,
    location VARCHAR(100),
    status VARCHAR(20) DEFAULT 'OPEN', -- OPEN, CLOSED, CANCELLED
    CONSTRAINT unique_section UNIQUE (course_id, section_number, semester, year),
    CONSTRAINT check_capacity CHECK (enrolled_count <= capacity),
    CONSTRAINT check_times CHECK (start_time < end_time)
);

-- Prerequisites Table
CREATE TABLE prerequisites (
    prerequisite_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
    required_course_id INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
    minimum_grade VARCHAR(2) DEFAULT 'D', -- Minimum grade required
    CONSTRAINT unique_prerequisite UNIQUE (course_id, required_course_id),
    CONSTRAINT no_self_prerequisite CHECK (course_id != required_course_id)
);

-- Enrollments Table
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    section_id INTEGER NOT NULL REFERENCES sections(section_id) ON DELETE CASCADE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ENROLLED', -- ENROLLED, DROPPED, COMPLETED, WITHDRAWN
    grade VARCHAR(2), -- A, A-, B+, B, B-, C+, C, C-, D+, D, F
    drop_date TIMESTAMP,
    completion_date TIMESTAMP,
    CONSTRAINT unique_enrollment UNIQUE (student_id, section_id)
);

-- Waitlist Table
CREATE TABLE waitlist (
    waitlist_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    section_id INTEGER NOT NULL REFERENCES sections(section_id) ON DELETE CASCADE,
    position INTEGER NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notified BOOLEAN DEFAULT FALSE,
    CONSTRAINT unique_waitlist UNIQUE (student_id, section_id)
);

-- Indexes for Performance
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
CREATE INDEX idx_enrollments_section ON enrollments(section_id);
CREATE INDEX idx_enrollments_status ON enrollments(status);
CREATE INDEX idx_sections_course ON sections(course_id);
CREATE INDEX idx_sections_semester ON sections(semester, year);
CREATE INDEX idx_waitlist_section ON waitlist(section_id);
CREATE INDEX idx_waitlist_position ON waitlist(section_id, position);
CREATE INDEX idx_prerequisites_course ON prerequisites(course_id);
CREATE INDEX idx_students_username ON students(username);
CREATE INDEX idx_courses_department ON courses(department);

-- Triggers for automatic updates

-- Update enrolled_count when enrollment changes
CREATE OR REPLACE FUNCTION update_section_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.status = 'ENROLLED' THEN
        UPDATE sections 
        SET enrolled_count = enrolled_count + 1 
        WHERE section_id = NEW.section_id;
    ELSIF TG_OP = 'UPDATE' THEN
        IF OLD.status = 'ENROLLED' AND NEW.status != 'ENROLLED' THEN
            UPDATE sections 
            SET enrolled_count = enrolled_count - 1 
            WHERE section_id = OLD.section_id;
        ELSIF OLD.status != 'ENROLLED' AND NEW.status = 'ENROLLED' THEN
            UPDATE sections 
            SET enrolled_count = enrolled_count + 1 
            WHERE section_id = NEW.section_id;
        END IF;
    ELSIF TG_OP = 'DELETE' AND OLD.status = 'ENROLLED' THEN
        UPDATE sections 
        SET enrolled_count = enrolled_count - 1 
        WHERE section_id = OLD.section_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollment_count_trigger
AFTER INSERT OR UPDATE OR DELETE ON enrollments
FOR EACH ROW EXECUTE FUNCTION update_section_count();

-- Update waitlist_count when waitlist changes
CREATE OR REPLACE FUNCTION update_waitlist_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE sections 
        SET waitlist_count = waitlist_count + 1 
        WHERE section_id = NEW.section_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE sections 
        SET waitlist_count = waitlist_count - 1 
        WHERE section_id = OLD.section_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER waitlist_count_trigger
AFTER INSERT OR DELETE ON waitlist
FOR EACH ROW EXECUTE FUNCTION update_waitlist_count();

-- Update student updated_at timestamp
CREATE OR REPLACE FUNCTION update_modified_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER student_update_trigger
BEFORE UPDATE ON students
FOR EACH ROW EXECUTE FUNCTION update_modified_timestamp();

-- Comments for documentation
COMMENT ON TABLE students IS 'Student accounts and academic information';
COMMENT ON TABLE courses IS 'Course catalog with all available courses';
COMMENT ON TABLE sections IS 'Course sections offered in specific semesters';
COMMENT ON TABLE enrollments IS 'Student enrollments in course sections';
COMMENT ON TABLE prerequisites IS 'Course prerequisite requirements';
COMMENT ON TABLE waitlist IS 'Waitlist queue for full course sections';

-- Grant permissions (adjust based on your user setup)
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO courseflow_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO courseflow_user;
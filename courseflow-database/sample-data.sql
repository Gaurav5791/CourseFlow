-- CourseFlow Sample Data
-- Realistic test data for development and demo

-- Insert Admin Accounts
INSERT INTO admins (username, password_hash, email, full_name, role) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'admin@courseflow.edu', 'System Administrator', 'SUPER_ADMIN'),
('registrar', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'registrar@courseflow.edu', 'Jane Smith', 'REGISTRAR');
-- Password for all accounts: password123

-- Insert Students
INSERT INTO students (username, password_hash, email, first_name, last_name, major, current_semester, gpa, status) VALUES
('jdoe', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'jdoe@student.edu', 'John', 'Doe', 'Computer Science', 5, 3.45, 'ACTIVE'),
('asmith', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'asmith@student.edu', 'Alice', 'Smith', 'Computer Science', 5, 3.78, 'ACTIVE'),
('bwilson', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'bwilson@student.edu', 'Bob', 'Wilson', 'Mathematics', 3, 3.21, 'ACTIVE'),
('cjones', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'cjones@student.edu', 'Carol', 'Jones', 'Computer Science', 7, 3.92, 'ACTIVE'),
('dlee', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'dlee@student.edu', 'David', 'Lee', 'Engineering', 4, 3.55, 'ACTIVE'),
('ebrown', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'ebrown@student.edu', 'Emma', 'Brown', 'Computer Science', 2, 3.67, 'ACTIVE'),
('fmiller', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'fmiller@student.edu', 'Frank', 'Miller', 'Mathematics', 6, 3.33, 'ACTIVE'),
('gwilliams', '$2a$10$N9qo8uLOickgx2ZMRZoMye1O7ZAKjL7bXZwL8wqOaKSLLY6T0K/J2', 'gwilliams@student.edu', 'Grace', 'Williams', 'Computer Science', 3, 3.89, 'ACTIVE');

-- Insert Courses (Computer Science)
INSERT INTO courses (course_code, course_name, description, credits, department, difficulty_level) VALUES
('CS101', 'Introduction to Programming', 'Fundamentals of programming using Java. Variables, control structures, functions, and basic OOP.', 3, 'Computer Science', 'BEGINNER'),
('CS102', 'Data Structures', 'Arrays, linked lists, stacks, queues, trees, and graphs. Algorithm analysis.', 3, 'Computer Science', 'INTERMEDIATE'),
('CS201', 'Algorithms', 'Design and analysis of algorithms. Sorting, searching, dynamic programming, greedy algorithms.', 3, 'Computer Science', 'INTERMEDIATE'),
('CS301', 'Database Systems', 'Relational databases, SQL, normalization, transactions, and database design.', 3, 'Computer Science', 'INTERMEDIATE'),
('CS302', 'Operating Systems', 'Process management, memory management, file systems, and concurrency.', 3, 'Computer Science', 'ADVANCED'),
('CS401', 'Machine Learning', 'Supervised and unsupervised learning, neural networks, and deep learning fundamentals.', 3, 'Computer Science', 'ADVANCED'),
('CS402', 'Computer Networks', 'Network protocols, TCP/IP, routing, and network security.', 3, 'Computer Science', 'ADVANCED'),
('CS403', 'Software Engineering', 'Software development lifecycle, design patterns, testing, and project management.', 3, 'Computer Science', 'ADVANCED');

-- Insert Courses (Mathematics)
INSERT INTO courses (course_code, course_name, description, credits, department, difficulty_level) VALUES
('MATH101', 'Calculus I', 'Limits, derivatives, and applications of differentiation.', 4, 'Mathematics', 'BEGINNER'),
('MATH102', 'Calculus II', 'Integration techniques, sequences, and series.', 4, 'Mathematics', 'INTERMEDIATE'),
('MATH201', 'Linear Algebra', 'Matrices, vector spaces, eigenvalues, and linear transformations.', 3, 'Mathematics', 'INTERMEDIATE'),
('MATH301', 'Discrete Mathematics', 'Logic, sets, relations, combinatorics, and graph theory.', 3, 'Mathematics', 'INTERMEDIATE'),
('MATH401', 'Probability and Statistics', 'Probability theory, distributions, hypothesis testing, and regression.', 3, 'Mathematics', 'ADVANCED');

-- Insert Courses (General Education)
INSERT INTO courses (course_code, course_name, description, credits, department, difficulty_level) VALUES
('ENG101', 'English Composition', 'Academic writing, research, and critical analysis.', 3, 'English', 'BEGINNER'),
('ENG201', 'Literature Survey', 'Survey of world literature from ancient to modern times.', 3, 'English', 'INTERMEDIATE'),
('HIST101', 'World History I', 'World history from ancient civilizations to 1500.', 3, 'History', 'BEGINNER'),
('HIST201', 'American History', 'American history from colonial period to present.', 3, 'History', 'INTERMEDIATE'),
('PHYS101', 'Physics I', 'Mechanics, waves, and thermodynamics.', 4, 'Physics', 'INTERMEDIATE'),
('CHEM101', 'General Chemistry', 'Atomic structure, bonding, reactions, and stoichiometry.', 4, 'Chemistry', 'BEGINNER');

-- Insert Prerequisites
INSERT INTO prerequisites (course_id, required_course_id, minimum_grade) VALUES
-- CS Prerequisites
((SELECT course_id FROM courses WHERE course_code = 'CS102'), (SELECT course_id FROM courses WHERE course_code = 'CS101'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'CS201'), (SELECT course_id FROM courses WHERE course_code = 'CS102'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'CS301'), (SELECT course_id FROM courses WHERE course_code = 'CS102'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'CS302'), (SELECT course_id FROM courses WHERE course_code = 'CS201'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'CS401'), (SELECT course_id FROM courses WHERE course_code = 'CS201'), 'B'),
((SELECT course_id FROM courses WHERE course_code = 'CS401'), (SELECT course_id FROM courses WHERE course_code = 'MATH201'), 'B'),
((SELECT course_id FROM courses WHERE course_code = 'CS402'), (SELECT course_id FROM courses WHERE course_code = 'CS201'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'CS403'), (SELECT course_id FROM courses WHERE course_code = 'CS301'), 'C'),
-- Math Prerequisites
((SELECT course_id FROM courses WHERE course_code = 'MATH102'), (SELECT course_id FROM courses WHERE course_code = 'MATH101'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'MATH201'), (SELECT course_id FROM courses WHERE course_code = 'MATH102'), 'C'),
((SELECT course_id FROM courses WHERE course_code = 'MATH401'), (SELECT course_id FROM courses WHERE course_code = 'MATH201'), 'C');

-- Insert Sections for Spring 2026
INSERT INTO sections (course_id, section_number, semester, year, instructor, capacity, schedule_days, start_time, end_time, location, status) VALUES
-- CS101 - Multiple sections (popular course)
((SELECT course_id FROM courses WHERE course_code = 'CS101'), '001', 'SPRING', 2026, 'Dr. Sarah Johnson', 40, 'MWF', '09:00', '09:50', 'CS Building 101', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CS101'), '002', 'SPRING', 2026, 'Dr. Michael Chen', 40, 'MWF', '11:00', '11:50', 'CS Building 102', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CS101'), '003', 'SPRING', 2026, 'Dr. Sarah Johnson', 40, 'TTh', '14:00', '15:15', 'CS Building 101', 'OPEN'),

-- CS102
((SELECT course_id FROM courses WHERE course_code = 'CS102'), '001', 'SPRING', 2026, 'Dr. Robert Martinez', 35, 'MWF', '10:00', '10:50', 'CS Building 201', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CS102'), '002', 'SPRING', 2026, 'Dr. Emily Davis', 35, 'TTh', '09:30', '10:45', 'CS Building 202', 'OPEN'),

-- CS201
((SELECT course_id FROM courses WHERE course_code = 'CS201'), '001', 'SPRING', 2026, 'Dr. David Thompson', 30, 'MWF', '13:00', '13:50', 'CS Building 301', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CS201'), '002', 'SPRING', 2026, 'Dr. Lisa Anderson', 30, 'TTh', '11:00', '12:15', 'CS Building 302', 'OPEN'),

-- CS301
((SELECT course_id FROM courses WHERE course_code = 'CS301'), '001', 'SPRING', 2026, 'Dr. James Wilson', 25, 'MWF', '14:00', '14:50', 'CS Building 401', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CS301'), '002', 'SPRING', 2026, 'Dr. Maria Garcia', 25, 'TTh', '14:00', '15:15', 'CS Building 402', 'OPEN'),

-- CS302
((SELECT course_id FROM courses WHERE course_code = 'CS302'), '001', 'SPRING', 2026, 'Dr. Steven Brown', 25, 'MWF', '11:00', '11:50', 'CS Building 501', 'OPEN'),

-- CS401 (Advanced - smaller class)
((SELECT course_id FROM courses WHERE course_code = 'CS401'), '001', 'SPRING', 2026, 'Dr. Jennifer Lee', 20, 'TTh', '13:00', '14:15', 'CS Building 601', 'OPEN'),

-- CS402
((SELECT course_id FROM courses WHERE course_code = 'CS402'), '001', 'SPRING', 2026, 'Dr. Thomas White', 25, 'MWF', '15:00', '15:50', 'CS Building 602', 'OPEN'),

-- CS403
((SELECT course_id FROM courses WHERE course_code = 'CS403'), '001', 'SPRING', 2026, 'Dr. Patricia Taylor', 25, 'TTh', '15:30', '16:45', 'CS Building 603', 'OPEN'),

-- Math Courses
((SELECT course_id FROM courses WHERE course_code = 'MATH101'), '001', 'SPRING', 2026, 'Dr. Christopher Moore', 45, 'MWF', '08:00', '08:50', 'Math Building 101', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH101'), '002', 'SPRING', 2026, 'Dr. Amanda Clark', 45, 'TTh', '09:30', '10:45', 'Math Building 102', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH102'), '001', 'SPRING', 2026, 'Dr. Richard Harris', 40, 'MWF', '09:00', '09:50', 'Math Building 201', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH201'), '001', 'SPRING', 2026, 'Dr. Nancy Lewis', 35, 'MWF', '10:00', '10:50', 'Math Building 301', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH201'), '002', 'SPRING', 2026, 'Dr. Kevin Walker', 35, 'TTh', '11:00', '12:15', 'Math Building 302', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH301'), '001', 'SPRING', 2026, 'Dr. Barbara Hall', 30, 'MWF', '13:00', '13:50', 'Math Building 401', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'MATH401'), '001', 'SPRING', 2026, 'Dr. Daniel Allen', 25, 'TTh', '14:00', '15:15', 'Math Building 501', 'OPEN'),

-- General Education
((SELECT course_id FROM courses WHERE course_code = 'ENG101'), '001', 'SPRING', 2026, 'Prof. Susan Young', 30, 'MWF', '09:00', '09:50', 'Humanities 101', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'ENG201'), '001', 'SPRING', 2026, 'Prof. Mark King', 25, 'TTh', '11:00', '12:15', 'Humanities 201', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'HIST101'), '001', 'SPRING', 2026, 'Prof. Linda Wright', 35, 'MWF', '10:00', '10:50', 'Humanities 301', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'HIST201'), '001', 'SPRING', 2026, 'Prof. George Scott', 30, 'TTh', '13:00', '14:15', 'Humanities 302', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'PHYS101'), '001', 'SPRING', 2026, 'Dr. Michelle Green', 30, 'MWF', '14:00', '14:50', 'Science Building 101', 'OPEN'),
((SELECT course_id FROM courses WHERE course_code = 'CHEM101'), '001', 'SPRING', 2026, 'Dr. Paul Adams', 35, 'TTh', '09:30', '10:45', 'Science Building 201', 'OPEN');

-- Insert Historical Enrollments (for AI recommendation engine)
-- These are COMPLETED enrollments from previous semesters

-- Student 1 (jdoe) - CS Major, completed foundational courses
INSERT INTO enrollments (student_id, section_id, enrollment_date, status, grade, completion_date) VALUES
(1, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101') AND section_number = '001' LIMIT 1), '2024-01-15', 'COMPLETED', 'A-', '2024-05-15'),
(1, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS102') AND section_number = '001' LIMIT 1), '2024-08-20', 'COMPLETED', 'B+', '2024-12-15'),
(1, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH101') AND section_number = '001' LIMIT 1), '2024-01-15', 'COMPLETED', 'B', '2024-05-15'),
(1, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201') AND section_number = '001' LIMIT 1), '2024-08-20', 'COMPLETED', 'B+', '2024-12-15');

-- Student 2 (asmith) - CS Major, advanced student
INSERT INTO enrollments (student_id, section_id, enrollment_date, status, grade, completion_date) VALUES
(2, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101') AND section_number = '001' LIMIT 1), '2023-08-15', 'COMPLETED', 'A', '2023-12-15'),
(2, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS102') AND section_number = '001' LIMIT 1), '2024-01-15', 'COMPLETED', 'A', '2024-05-15'),
(2, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS201') AND section_number = '001' LIMIT 1), '2024-08-20', 'COMPLETED', 'A-', '2024-12-15'),
(2, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201') AND section_number = '001' LIMIT 1), '2024-01-15', 'COMPLETED', 'A', '2024-05-15');

-- Student 4 (cjones) - CS Major, senior
INSERT INTO enrollments (student_id, section_id, enrollment_date, status, grade, completion_date) VALUES
(4, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101') AND section_number = '001' LIMIT 1), '2022-08-15', 'COMPLETED', 'A', '2022-12-15'),
(4, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS102') AND section_number = '001' LIMIT 1), '2023-01-15', 'COMPLETED', 'A', '2023-05-15'),
(4, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS201') AND section_number = '001' LIMIT 1), '2023-08-20', 'COMPLETED', 'A', '2023-12-15'),
(4, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS301') AND section_number = '001' LIMIT 1), '2024-01-15', 'COMPLETED', 'A-', '2024-05-15'),
(4, (SELECT section_id FROM sections WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS302') AND section_number = '001' LIMIT 1), '2024-08-20', 'COMPLETED', 'B+', '2024-12-15');

-- Current enrollments for Spring 2026 (to show in demo)
-- Student 1 (jdoe) enrolling in CS201 and CS301
INSERT INTO enrollments (student_id, section_id, status) VALUES
(1, (SELECT section_id FROM sections s JOIN courses c ON s.course_id = c.course_id WHERE c.course_code = 'CS201' AND s.section_number = '001' AND s.semester = 'SPRING' AND s.year = 2026), 'ENROLLED'),
(1, (SELECT section_id FROM sections s JOIN courses c ON s.course_id = c.course_id WHERE c.course_code = 'CS301' AND s.section_number = '001' AND s.semester = 'SPRING' AND s.year = 2026), 'ENROLLED');

-- Sample waitlist entry (for demo)
INSERT INTO waitlist (student_id, section_id, position) VALUES
(6, (SELECT section_id FROM sections s JOIN courses c ON s.course_id = c.course_id WHERE c.course_code = 'CS401' AND s.section_number = '001' AND s.semester = 'SPRING' AND s.year = 2026), 1);

-- Verification queries
SELECT 'Students' as table_name, COUNT(*) as count FROM students
UNION ALL
SELECT 'Courses', COUNT(*) FROM courses
UNION ALL
SELECT 'Sections', COUNT(*) FROM sections
UNION ALL
SELECT 'Prerequisites', COUNT(*) FROM prerequisites
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'Waitlist', COUNT(*) FROM waitlist;
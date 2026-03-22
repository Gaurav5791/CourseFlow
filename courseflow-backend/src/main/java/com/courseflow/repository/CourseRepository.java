package com.courseflow.repository;

import com.courseflow.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Course Repository
 * Data access layer for Course entity
 */
@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    
    Optional<Course> findByCourseCode(String courseCode);
    
    List<Course> findByDepartment(String department);
    
    List<Course> findByIsActive(Boolean isActive);
    
    List<Course> findByCourseNameContainingIgnoreCase(String courseName);
    
    boolean existsByCourseCode(String courseCode);
}
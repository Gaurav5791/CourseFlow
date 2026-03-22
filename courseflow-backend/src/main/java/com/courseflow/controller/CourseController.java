package com.courseflow.controller;

import com.courseflow.model.Course;
import com.courseflow.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Course Controller
 * REST API endpoints for course operations
 */
@RestController
@RequestMapping("/api/courses")
@CrossOrigin(origins = "*")
public class CourseController {

    @Autowired
    private CourseRepository courseRepository;

    /**
     * Get all courses
     * GET /api/courses
     */
    @GetMapping
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = courseRepository.findAll();
        return ResponseEntity.ok(courses);
    }

    /**
     * Get course by ID
     * GET /api/courses/{id}
     */
    @GetMapping("/{id}")
    public ResponseEntity<Course> getCourseById(@PathVariable Long id) {
        return courseRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Get courses by department
     * GET /api/courses/department/{department}
     */
    @GetMapping("/department/{department}")
    public ResponseEntity<List<Course>> getCoursesByDepartment(@PathVariable String department) {
        List<Course> courses = courseRepository.findByDepartment(department);
        return ResponseEntity.ok(courses);
    }

    /**
     * Search courses by name
     * GET /api/courses/search?q=programming
     */
    @GetMapping("/search")
    public ResponseEntity<List<Course>> searchCourses(@RequestParam String q) {
        List<Course> courses = courseRepository.findByCourseNameContainingIgnoreCase(q);
        return ResponseEntity.ok(courses);
    }

    /**
     * Get course by code
     * GET /api/courses/code/CS101
     */
    @GetMapping("/code/{courseCode}")
    public ResponseEntity<Course> getCourseByCode(@PathVariable String courseCode) {
        return courseRepository.findByCourseCode(courseCode)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
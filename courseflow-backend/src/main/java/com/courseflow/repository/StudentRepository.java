package com.courseflow.repository;

import com.courseflow.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Student Repository
 * Data access layer for Student entity
 */
@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    
    Optional<Student> findByUsername(String username);
    
    Optional<Student> findByEmail(String email);
    
    List<Student> findByMajor(String major);
    
    List<Student> findByStatus(String status);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
}
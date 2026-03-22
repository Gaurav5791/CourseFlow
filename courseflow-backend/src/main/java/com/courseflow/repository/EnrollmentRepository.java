package com.courseflow.repository;

import com.courseflow.model.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Enrollment Repository
 * Data access layer for Enrollment entity
 */
@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {
    
    List<Enrollment> findByStudent_StudentId(Long studentId);
    
    List<Enrollment> findBySection_SectionId(Long sectionId);
    
    List<Enrollment> findByStatus(String status);
    
    @Query("SELECT e FROM Enrollment e WHERE e.student.studentId = :studentId AND e.status = :status")
    List<Enrollment> findByStudentAndStatus(@Param("studentId") Long studentId, @Param("status") String status);
    
    @Query("SELECT e FROM Enrollment e WHERE e.student.studentId = :studentId AND e.section.sectionId = :sectionId")
    Optional<Enrollment> findByStudentAndSection(@Param("studentId") Long studentId, @Param("sectionId") Long sectionId);
    
    @Query("SELECT COUNT(e) FROM Enrollment e WHERE e.student.studentId = :studentId AND e.status = 'ENROLLED'")
    long countActiveEnrollmentsByStudent(@Param("studentId") Long studentId);
    
    boolean existsByStudent_StudentIdAndSection_SectionId(Long studentId, Long sectionId);
}
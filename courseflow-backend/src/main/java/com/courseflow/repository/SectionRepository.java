package com.courseflow.repository;

import com.courseflow.model.Section;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Section Repository
 * Data access layer for Section entity
 */
@Repository
public interface SectionRepository extends JpaRepository<Section, Long> {
    
    List<Section> findByCourse_CourseId(Long courseId);
    
    List<Section> findBySemesterAndYear(String semester, Integer year);
    
    List<Section> findByInstructor(String instructor);
    
    @Query("SELECT s FROM Section s WHERE s.semester = :semester AND s.year = :year AND s.status = 'OPEN'")
    List<Section> findOpenSections(@Param("semester") String semester, @Param("year") Integer year);
    
    @Query("SELECT s FROM Section s WHERE s.enrolledCount < s.capacity AND s.status = 'OPEN'")
    List<Section> findAvailableSections();
}
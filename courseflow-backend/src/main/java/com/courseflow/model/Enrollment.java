package com.courseflow.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

/**
 * Enrollment Entity
 * Represents a student's enrollment in a course section
 */
@Entity
@Table(name = "enrollments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Enrollment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "enrollment_id")
    private Long enrollmentId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "section_id", nullable = false)
    private Section section;

    @CreationTimestamp
    @Column(name = "enrollment_date", updatable = false)
    private LocalDateTime enrollmentDate;

    @Column(length = 20)
    private String status = "ENROLLED";

    @Column(length = 2)
    private String grade;

    @Column(name = "drop_date")
    private LocalDateTime dropDate;

    @Column(name = "completion_date")
    private LocalDateTime completionDate;

    public boolean isActive() {
        return "ENROLLED".equals(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equals(status);
    }

    public boolean isDropped() {
        return "DROPPED".equals(status);
    }
}
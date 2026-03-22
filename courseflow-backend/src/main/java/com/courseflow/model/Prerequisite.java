package com.courseflow.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Prerequisite Entity
 * Represents prerequisite requirements for courses
 */
@Entity
@Table(name = "prerequisites")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Prerequisite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "prerequisite_id")
    private Long prerequisiteId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "required_course_id", nullable = false)
    private Course requiredCourse;

    @Column(name = "minimum_grade", length = 2)
    private String minimumGrade = "D";

    public boolean meetsRequirement(String studentGrade) {
        if (studentGrade == null) return false;
        return gradeValue(studentGrade) >= gradeValue(minimumGrade);
    }

    private int gradeValue(String grade) {
        return switch (grade.toUpperCase()) {
            case "A" -> 12;
            case "A-" -> 11;
            case "B+" -> 10;
            case "B" -> 9;
            case "B-" -> 8;
            case "C+" -> 7;
            case "C" -> 6;
            case "C-" -> 5;
            case "D+" -> 4;
            case "D" -> 3;
            case "F" -> 0;
            default -> 0;
        };
    }
}
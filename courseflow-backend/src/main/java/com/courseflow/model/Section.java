package com.courseflow.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Section Entity
 * Represents a specific section of a course offered in a semester
 */
@Entity
@Table(name = "sections")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Section {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "section_id")
    private Long sectionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(name = "section_number", nullable = false, length = 10)
    private String sectionNumber;

    @Column(nullable = false, length = 20)
    private String semester;

    @Column(nullable = false)
    private Integer year;

    @Column(length = 100)
    private String instructor;

    @Column(nullable = false)
    private Integer capacity;

    @Column(name = "enrolled_count")
    private Integer enrolledCount = 0;

    @Column(name = "waitlist_count")
    private Integer waitlistCount = 0;

    @Column(name = "schedule_days", length = 20)
    private String scheduleDays;

    @Column(name = "start_time")
    private LocalTime startTime;

    @Column(name = "end_time")
    private LocalTime endTime;

    @Column(length = 100)
    private String location;

    @Column(length = 20)
    private String status = "OPEN";

    @OneToMany(mappedBy = "section", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Enrollment> enrollments = new ArrayList<>();

    @OneToMany(mappedBy = "section", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Waitlist> waitlist = new ArrayList<>();

    public boolean isFull() {
        return enrolledCount >= capacity;
    }

    public boolean hasSeatsAvailable() {
        return enrolledCount < capacity;
    }

    public int getAvailableSeats() {
        return capacity - enrolledCount;
    }

    public boolean isOpen() {
        return "OPEN".equals(status);
    }

    public String getSectionDisplay() {
        return course.getCourseCode() + "-" + sectionNumber;
    }
}
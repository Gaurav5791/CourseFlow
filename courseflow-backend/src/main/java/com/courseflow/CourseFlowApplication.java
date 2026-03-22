package com.courseflow;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * CourseFlow - Streamlined Course Registration System
 * Main application entry point
 * 
 * @author CourseFlow Team
 * @version 1.0.0
 */
@SpringBootApplication
public class CourseFlowApplication {

    public static void main(String[] args) {
        SpringApplication.run(CourseFlowApplication.class, args);
        System.out.println("\n=================================================");
        System.out.println("   CourseFlow Backend Started Successfully!");
        System.out.println("   Access API at: http://localhost:8080");
        System.out.println("   API Docs: http://localhost:8080/swagger-ui.html");
        System.out.println("=================================================\n");
    }
}
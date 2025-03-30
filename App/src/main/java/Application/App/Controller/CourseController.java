package Application.App.Controller;

import Application.App.Model.User;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.*;
import Application.App.Model.Course;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/courses")
public class CourseController {
    private List<Course> courses = new ArrayList<>();

    @GetMapping
    public List<Course> getCourses(){
        return courses;
    }

    @GetMapping("/{id}")
    public Course getCourseById(@PathVariable int id){
        return courses.stream()
                .filter(course -> course.getId() == id)
                .findFirst()
                .orElse(null);
    }

    @PostMapping
    public Course createCourse(@RequestBody Course course) {
        courses.add(course);
        return course;
    }

    @PutMapping("/{id}")
    public Course updateUser(@PathVariable int id, @RequestBody Course updatedCourse) {
        for (Course course : courses) {
            if (course.getId() == id) {
                course.setName(updatedCourse.getName());
                return course;
            }
        }
        return null;
    }

    @DeleteMapping("/{id}")
    public String deleteCourse(@PathVariable int id) {
        courses.removeIf(course -> course.getId() == id);
        return "Course deleted";
    }
}

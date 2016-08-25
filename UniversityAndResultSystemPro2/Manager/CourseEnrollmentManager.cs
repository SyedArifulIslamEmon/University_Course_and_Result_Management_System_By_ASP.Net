using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Gateway;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Manager
{
    public class CourseEnrollmentManager
    {
        private CourseEnrollmentGateway aCourseEnrollmentGateway = new CourseEnrollmentGateway();
        public string SaveCourseEnrollment(CourseEnrollment courseEnrollment)
        {
            if (aCourseEnrollmentGateway.AlreadyEnrolledInCourse(courseEnrollment))
                return "conflict";
            int rowAffected = aCourseEnrollmentGateway.SaveCourseEnrollment(courseEnrollment);
            if (rowAffected > 0)
                return "yes";
            else
            {
                return "no";
            }
        }

        public List<Course> GetAllCoursesTakenByStudentId(int studentId)
        {
            return aCourseEnrollmentGateway.GetAllCoursesTakenByStudentId(studentId);
        }

        public List<SelectListItem> GetAllGradesSelectListItem()
        {
            return aCourseEnrollmentGateway.GetAllGradesSelectListItem();
        }

        public string SaveCourseResult(CourseEnrollment courseEnrollment)
        {
            
            int rowAffected = aCourseEnrollmentGateway.SaveCourseResult(courseEnrollment);
            if (rowAffected > 0)
                return "yes";
            else
                return "no";
        }

        public List<CourseTakenByStudent> GetCourseResultByStudentId(int studentId)
        {
            return aCourseEnrollmentGateway.GetCourseResultByStudentId(studentId);
        }
    }
}
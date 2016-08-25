using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Gateway;
using UniversityAndResultSystemPro2.Models;

namespace UniversityAndResultSystemPro2.Manager
{
    
    public class TeacherManager
    {
        TeacherGateway aTeacherGateway = new TeacherGateway();

        public List<SelectListItem> GetAllDesignation()
        {
            return aTeacherGateway.GetAllDesignation();
        }

        public string SaveTeacher(Teacher aTeacher)
        {
            if (aTeacherGateway.IsUniqeEmail(aTeacher.Email) != null)
            {
                return "Email Not Unique";
            }

            

            int rowAffected = aTeacherGateway.SaveTeacher(aTeacher);
            if (rowAffected > 0)
            {
                return "yes";
            }
            else
            {
                return "no";
            }
        }

        public List<Teacher> GetAllTeachers()
        {
            return aTeacherGateway.GetAllTeachers();
        }

        public string AssignCourseToTeacher(CourseAssignment courseAssignment)
        {
            if (aTeacherGateway.IsCourseAlreadyAssigned(courseAssignment))
            {
                return "Course Already Assigned";
            }
            int rowAffected = aTeacherGateway.AssignCourseToTeacher(courseAssignment);
            if (rowAffected > 0)
                return "yes";
            else
            {
                return "no";
            }
        }
    }
}
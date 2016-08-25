using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UniversityAndResultSystemPro2.Gateway;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Manager
{
    public class CourseManager
    {
        CourseGateway aCourseGateway = new CourseGateway();
        public string SaveCourse(Course aCourse)
        {
            if (aCourseGateway.IsUniqeCode(aCourse.Code) != null)
            {
                return "Code Not Unique";
            }

            if (aCourseGateway.IsUniqeName(aCourse.Name) != null)
            {
                return "Name Not Unique";
            }


            int rowAffected = aCourseGateway.SaveCourse(aCourse);
            if (rowAffected > 0)
            {
                return "yes";
            }
            else
            {
                return "no";
            }
        }

        public List<Course> GetAllCourses()
        {
            return  aCourseGateway.GetAllCourses();
        }


        public List<CourseStatistics> GetAllCourseStatisticesByDeptId(int deptId)
        {
            return aCourseGateway.GetAllCourseStatisticesByDeptId(deptId);
        }

        public string UnAssignAllCourse()
        {
            string str = "";
            int rowAffected = aCourseGateway.UnAssignAllCourse();
            if (rowAffected > 0)
                str = "yes";
            else
            {
                str = "no";
            }
            return str;
        }
    }
}
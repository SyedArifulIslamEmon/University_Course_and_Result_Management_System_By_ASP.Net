using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models.ViewModels
{
    public class CourseStatistics
    {
        public string CourseCode { get; set; }
        public string  CourseName { get; set; }
        public string TeacherName { get; set; }
        public int Semester { get; set; }
    }
}
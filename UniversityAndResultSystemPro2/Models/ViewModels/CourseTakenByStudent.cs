using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models.ViewModels
{
    public class CourseTakenByStudent
    {
        public int StudentId { get; set; }
        public string StudentName { get; set; }
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public string CourseCode { get; set; }
        public string Grade { get; set; }
        public string Valid { get; set; }
    }
}
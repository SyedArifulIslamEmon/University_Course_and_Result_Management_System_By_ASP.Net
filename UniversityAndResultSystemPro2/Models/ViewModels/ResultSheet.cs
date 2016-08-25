using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models.ViewModels
{
    public class ResultSheet
    {
        public string Name { get; set; }
        public string RegNo { get; set; }
        public string Email { get; set; }
        public string DeptName { get; set; }
        public List<CourseResult> CourseResults;

        public ResultSheet()
        {
            CourseResults = new List<CourseResult>();
        }
    }
}
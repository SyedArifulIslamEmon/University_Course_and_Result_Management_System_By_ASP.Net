using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models
{
    public class CourseAssignment
    {
        public int Id { get; set; }
        public int TeacherId { get; set; }
        public int  CourseId { get; set; }
        public string Valid { get; set; }
    }
}
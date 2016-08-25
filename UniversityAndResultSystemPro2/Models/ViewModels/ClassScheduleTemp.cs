using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models.ViewModels
{
    public class ClassScheduleTemp
    {
        public string CourseCode { get; set; }
        public string CourseName { get; set; }
        public string RoomNo { get; set; }
        public string Day { get; set; }
        public int From { get; set; }
        public int To { get; set; }
        public string Valid { get; set; }
    }
}
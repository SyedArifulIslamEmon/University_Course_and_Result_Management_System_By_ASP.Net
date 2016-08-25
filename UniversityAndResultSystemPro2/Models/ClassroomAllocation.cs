using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models
{
    public class ClassroomAllocation
    {
        public int Id { get; set; }

        [Required]

        [DisplayName("Department Name")]
        public int DepartmentId { get; set; }

        [Required]
        public int CourseId { get; set; }

        [Required]
        [DisplayName("Room No")]
        public string RoomNo { get; set; }

        [Required]
        public string Day { get; set; }
        public int From { get; set; }
        public int To { get; set; }
        public string Valid { get; set; }

    }
}
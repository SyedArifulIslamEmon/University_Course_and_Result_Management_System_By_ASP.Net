using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityAndResultSystemPro2.Models
{
    public class Teacher
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please Provide a Name")]
        [DisplayName("Name :")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please Provide a Address")]
        [DisplayName("Address :")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Please Provide a Email")]
        [DisplayName("Email :")]
        [RegularExpression(@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", ErrorMessage = "Input a valid email address")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Please Provide a Contact Number")]
        [DisplayName("Contact No :")]
   
        [RegularExpression(@"^(\d{11})$", ErrorMessage = "Enter a valid 11 digit Number")]
        public string ContactNo { get; set; }

        [Required(ErrorMessage = "Select a Designation")]
        [DisplayName("Designation :")]
        public string Designation { get; set; }

        [Required(ErrorMessage = "Select a Department")]
        [DisplayName("Department :")]
        public int DepartmentId { get; set; }


        [Required(ErrorMessage = "Please Provide a Cradit Limit")]
        [DisplayName("Credit :")]
        [Range(typeof(double), "0.0", "99.0", ErrorMessage = "Cradit range must be 0.0 to 99.0")]
        public double CreditLimit { get; set; }
        public double RemainingCredit { get; set; }
    }
}


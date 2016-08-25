using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Gateway;
using UniversityAndResultSystemPro2.Models;

namespace UniversityAndResultSystemPro2.Manager
{
    public class DepartmentManager
    {
        DepartmentGateway aDepartmentGateway = new DepartmentGateway();
        public string Save(Department aDepartment)
        {
            if (aDepartmentGateway.IsUniqeCode(aDepartment.Code) != null)
            {
                return "Code Not Unique";
            }

            if (aDepartmentGateway.IsUniqeName(aDepartment.Name) != null)
            {
                return "Name Not Unique";
            }

            int rowAffected =  aDepartmentGateway.Save(aDepartment) ;
            if (rowAffected>0)
            {
                
                return "yes";
                
            }
            else
            {
                return "no";
            }
        }

        public List<Department> GetAll()
        {
            return aDepartmentGateway.GetAll();
        }
        public List<SelectListItem> GetAllDepartment()
        {
            return aDepartmentGateway.GetAllDepartment();
        }

        public List<SelectListItem> GetAllSemester()
        {
            return aDepartmentGateway.GetAllSemester();
        }

        public List<Department> GetAllDepartmentsInfo()
        {
            return aDepartmentGateway.GetAllDepartmentsInfo();
        }
    }
}
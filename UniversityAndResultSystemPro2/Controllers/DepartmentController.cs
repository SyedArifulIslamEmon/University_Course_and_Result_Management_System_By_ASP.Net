using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Manager;
using UniversityAndResultSystemPro2.Models;

namespace UniversityAndResultSystemPro2.Controllers
{
    public class DepartmentController : Controller
    {
        DepartmentManager aDepartmentManager = new DepartmentManager();
        //
        // GET: /Department/
        public ActionResult Index()
        {


            return View();
        }

        public ActionResult Save()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Save(Department aDepartment)
        {
            
            ViewBag.message = aDepartmentManager.Save(aDepartment);
            ViewBag.code = aDepartment.Code;
            ViewBag.name = aDepartment.Name;

            if (ViewBag.message == "yes")
            {
                ModelState.Clear(); //clear after submiting
            }
            
            return View();
        }

        public ActionResult ShowDepartment()
        {
            List<Department> aDepartments = aDepartmentManager.GetAll();
            ViewBag.departments = aDepartments;
            return View();
        }
	}
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Manager;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Controllers
{
    public class CourseController : Controller
    {
        DepartmentManager aDepartmentManager = new DepartmentManager();
        private CourseManager aCourseManager = new CourseManager();
        //
        // GET: /Course/
        //public ActionResult Index()
        //{
        //    return View();
        //}

        public ActionResult Save()
        {
            //List<Department> aDepartments = aDepartmentManager.GetAll();
            //ViewBag.departments = aDepartments;

            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;


            List<SelectListItem> aSemesters = aDepartmentManager.GetAllSemester();
            ViewBag.semesters = aSemesters;


            return View();
        }

        [HttpPost]
        public ActionResult Save(Course aCourse)
        {
            //List<Department> aDepartments = aDepartmentManager.GetAll();
            //ViewBag.departments = aDepartments;

            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aSemesters = aDepartmentManager.GetAllSemester();
            ViewBag.semesters = aSemesters;

            ViewBag.message = aCourseManager.SaveCourse(aCourse);

            ViewBag.code = aCourse.Code;
            ViewBag.name = aCourse.Name;


            if (ViewBag.message == "yes")
            {
                ModelState.Clear(); //clear after submiting
            }

            return View();
        }

        

        public JsonResult GetCoursesByDepartmentId(int departmentId)
        {
            List<Course> courses = aCourseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.DepartmentId == departmentId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetCourseInfoByCourseId(int courseId)
        {
            List<Course> courses = aCourseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.Id == courseId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);

        }

        public ActionResult CourseStatistics()
        {
            List<Department> departments = aDepartmentManager.GetAllDepartmentsInfo();
            ViewBag.Departments = departments;
            return View();
        }




        public JsonResult GetCourseStatisticsByDeptId(int departmentId)
        {
            List<CourseStatistics> statisticses = aCourseManager.GetAllCourseStatisticesByDeptId(departmentId);
            //double CreditLimit = aTeacher.CreditLimit;
            return Json(statisticses, JsonRequestBehavior.AllowGet);
        }


        public ActionResult UnAssignAllCourse()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UnAssignAllCourse(int ?id)
        {
            ViewBag.message = aCourseManager.UnAssignAllCourse();
            return View();
        }
    }
}
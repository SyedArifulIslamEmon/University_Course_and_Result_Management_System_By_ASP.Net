using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Rotativa;

using UniversityAndResultSystemPro2.Manager;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Controllers
{
    public class StudentController : Controller
    {
        //private int id;
        DepartmentManager aDepartmentManager = new DepartmentManager();
        StudentManager aStudentManager = new StudentManager();
        private CourseManager aCourseManager = new CourseManager();
        private CourseEnrollmentManager aCourseEnrollmentManager = new CourseEnrollmentManager();
        //
        // GET: /Student/

        public ActionResult Register()
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            return View();
        }

        [HttpPost]
        public ActionResult Register(Student student)
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            ViewBag.message = aStudentManager.SaveStudent(student);

            ViewBag.RegNo = student.RegNo;
            ViewBag.name = student.Name;
            ViewBag.Email = student.Email;
            ViewBag.ContactNo = student.ContactNo;
            ViewBag.Address = student.Address;
            ViewBag.RegDate = student.RegDate.ToString("dd-MM-yyyy");
            ViewBag.DeptName = student.DeptName;

            if (ViewBag.message == "yes")
            {
                ModelState.Clear(); //clear after submiting
            }
            return View();

        }

        public ActionResult EnrollInCourse()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            return View();
        }

        [HttpPost]
        public ActionResult EnrollInCourse(CourseEnrollment courseEnrollment)
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            string message = aCourseEnrollmentManager.SaveCourseEnrollment(courseEnrollment);
            if (message == "yes" || message == "conflict")
            {
                ModelState.Clear();
            }
            ViewBag.message = message;
            return View();
        }

        public JsonResult GetStudentById(int studentId)
        {
            List<Student> students = aStudentManager.GetStudentById(studentId);

            return Json(students, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseThatCanBeTakenByStudentId(int studentId)
        {
            List<Student> students = aStudentManager.GetStudentById(studentId);
            int deptId = students[0].DepartmentId;
            List<Course> courses = aCourseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.DepartmentId == deptId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseThatAreTakenByStudentId(int studentId)
        {

            List<Course> courses = aCourseEnrollmentManager.GetAllCoursesTakenByStudentId(studentId);
            //List<Course> courseList = courses.Where(a => a.DepartmentId == deptId).ToList();
            return Json(courses, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveResult()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;

            List<SelectListItem> grades = aCourseEnrollmentManager.GetAllGradesSelectListItem();
            ViewBag.Grades = grades;

            return View();
        }

        [HttpPost]
        public ActionResult SaveResult(CourseEnrollment courseEnrollment)
        {
            string msg = aCourseEnrollmentManager.SaveCourseResult(courseEnrollment);
            ViewBag.message = msg;

            if (msg == "yes")
            {
                ModelState.Clear();
            }

            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;

            List<SelectListItem> grades = aCourseEnrollmentManager.GetAllGradesSelectListItem();
            ViewBag.Grades = grades;

            return View();
        }
        
        public ActionResult ViewResult()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            return View();
        }

        [HttpPost]
        public ActionResult ViewResult(int studentId)
        {

            //List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            //ViewBag.Students = studentListItem;
            //return View();
            Global.Id = studentId;
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            //return GeneratePdf();
            return RedirectToAction("GeneratePdfPreview", "Student", null);
        }
        
        public JsonResult GetCourseResultByStudentId(int studentId)
        {

            List<CourseTakenByStudent> results = aCourseEnrollmentManager.GetCourseResultByStudentId(studentId);
            return Json(results, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GeneratePdfPreview()
        {
            int studentId = Global.Id;
            ResultSheet aResultSheet = aStudentManager.GenerateResultForStudentId(studentId);
            //int id = (int)TempData["id"];
            ViewBag.ResultSheet = aResultSheet;
            
            return View();
        }

        public ActionResult GeneratePdf()
        {
            return new Rotativa.ActionAsPdf("GeneratePdfPreview");
        }
    }
}
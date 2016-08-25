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
    public class ClassRoomController : Controller
    {
        DepartmentManager aDepartmentManager = new DepartmentManager();
        TeacherManager aTeacherManager = new TeacherManager();
        RoomNoManager aRoomNoManager = new RoomNoManager();
        //
        // GET: /ClassRoom/
        public ActionResult AllocateClassrooms()
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aRoomNos = aRoomNoManager.GetAllRoomNos();
            ViewBag.RoomNo = aRoomNos;

            List<SelectListItem> DaysListItems = aRoomNoManager.GetAllDays();
            ViewBag.Day = DaysListItems;

            return View();
        }

        [HttpPost]
        public ActionResult AllocateClassrooms(ClassroomAllocation classroomAllocation, int FromHour, int FromMin, string FromAmPm, int ToHour, int ToMin, string ToAmPm)
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aRoomNos = aRoomNoManager.GetAllRoomNos();
            ViewBag.RoomNo = aRoomNos;

            List<SelectListItem> DaysListItems = aRoomNoManager.GetAllDays();
            ViewBag.Day = DaysListItems;

            classroomAllocation.From = ConvertHrMinAmPmToMin(FromHour, FromMin, FromAmPm);
            classroomAllocation.To = ConvertHrMinAmPmToMin(ToHour, ToMin, ToAmPm);

            string message = aRoomNoManager.SaveClassroomAllocationInfo(classroomAllocation);
            ViewBag.message = message;

            //if (ViewBag.message == "yes" || ViewBag.message == "conflict" || ViewBag.message == "invalid time")
            //{
                if (ViewBag.message == "invalid time")
                {
                    ViewBag.From = GetTimeString(classroomAllocation.From);
                    ViewBag.To = GetTimeString(classroomAllocation.To);
                }
                ModelState.Clear(); //clear after submiting
            //}
            
            return View();
        }

        private string GetTimeString(int minuteTime)
        {
            string str = "";
            int hour = minuteTime / 60;
            string division = "";
            if (hour >= 12)
            {
                division = "pm";
                if (hour > 12)
                    hour -= 12;
            }
            else
            {
                division = "am";
                if (hour == 0)
                    hour = 12;
            }

            int min = minuteTime % 60;
            if (hour < 10)
                str += "0";
            str += hour + ":";
            if (min < 10)
                str += "0";
            str += min;
            str += " " + division;
            return str;

        }

        public ActionResult CompleteClassSchedule()
        {
            List<Department> departments = aDepartmentManager.GetAllDepartmentsInfo();
            ViewBag.Departments = departments;
            return View();
        }

        public JsonResult GetTeachersByDepartmentId(int departmentId)
        {
            List<Teacher> teachers = aTeacherManager.GetAllTeachers();
            List<Teacher> teacherList = teachers.Where(a => a.DepartmentId == departmentId).ToList();
            return Json(teacherList, JsonRequestBehavior.AllowGet);
        }

        public int ConvertHrMinAmPmToMin(int hr, int min, string ampm)
        {
            if (ampm == "pm")
            {
                if(hr!=12)
                    hr += 12;
                hr *= 60;
                min += hr;
                return min;
            }
            if (hr == 12)
                hr = 0;
            hr *= 60;
            min += hr;
            return min;

        }

        public JsonResult GetClassScheduleByDeptId(int departmentId)
        {
            List<ClassScheduleFinal> classScheduleTemps = aRoomNoManager.GetClassScheduleByDeptId(departmentId);
            //double CreditLimit = aTeacher.CreditLimit;
            return Json(classScheduleTemps, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UnallocateClassRoom()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UnallocateClassRoom(int ?id)
        {
            ViewBag.message = aRoomNoManager.UnallocateClassRoom();
            return View();
        }
	}
}
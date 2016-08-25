using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Gateway
{
    public class CourseEnrollmentGateway : Gateway
    {
        public int SaveCourseEnrollment(CourseEnrollment courseEnrollment)
        {
            Query = "Insert Into CourseEnrollment Values ('" + courseEnrollment.StudentId + "','" + courseEnrollment.CourseId + "','" + courseEnrollment.EnrollDate.Date.ToString("yyyy-MM-dd") + "','Not Graded Yet','true') ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();

            return rowAffected;
        }

        public bool AlreadyEnrolledInCourse(CourseEnrollment courseEnrollment)
        {
            Query = "Select * From CourseEnrollment Where StudentId = '" + courseEnrollment.StudentId + "' And CourseId = '" + courseEnrollment.CourseId + "' And Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            bool hasRows = Reader.HasRows;

            Reader.Close();
            Connection.Close();
            return hasRows;
        }

        public List<Course> GetAllCoursesTakenByStudentId(int studentId)
        {
            Query = "Select * From CourseTakenByStudentView Where StudentId = '" + studentId + "' And Valid = 'true' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<Course> courses = new List<Course>();
            while (Reader.Read())
            {
                Course aCourse = new Course();
                aCourse.Id = (int)Reader["CourseId"];
                aCourse.Name = Reader["CourseName"].ToString();
                aCourse.Code = Reader["CourseCode"].ToString();
                courses.Add(aCourse);
            }

            Reader.Close();
            Connection.Close();
            return courses;
        }

        public List<SelectListItem> GetAllGradesSelectListItem()
        {
            Query = "Select * From Grade";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> grades = new List<SelectListItem>();
            while (Reader.Read())
            {
                grades.Add(
                    new SelectListItem()
                    {
                        Value = Reader["LetterGrade"].ToString(),
                        Text = Reader["LetterGrade"].ToString()
                    });
            }

            Reader.Close();
            Connection.Close();
            return grades;

        }

        public int SaveCourseResult(CourseEnrollment courseEnrollment)
        {
            int rowAffected = 0;

            Query = "Update CourseEnrollment set Grade = '" + courseEnrollment.Grade + "' Where StudentId = '" + courseEnrollment.StudentId + "' And CourseId = '" + courseEnrollment.CourseId + "' And Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public List<CourseTakenByStudent> GetCourseResultByStudentId(int studentId)
        {
            Query = "Select * From CourseTakenByStudentView Where StudentId = '" + studentId + "' And Valid = 'true' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<CourseTakenByStudent> results = new List<CourseTakenByStudent>();
            while (Reader.Read())
            {
                CourseTakenByStudent aResult = new CourseTakenByStudent();
                aResult.CourseCode = Reader["CourseCode"].ToString();
                aResult.CourseName = Reader["CourseName"].ToString();
                aResult.Grade = Reader["Grade"].ToString();
                results.Add(aResult);
            }

            Reader.Close();
            Connection.Close();
            return results;
        }
    }
}
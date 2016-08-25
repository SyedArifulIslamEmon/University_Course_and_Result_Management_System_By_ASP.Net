using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Gateway
{
    public class CourseGateway : Gateway
    {
        public int SaveCourse(Course aCourse)
        {
            Query = "Insert INTO Course VALUES('" + aCourse.Code + "','" + aCourse.Name + "','" + aCourse.Cradit + "','" + aCourse.Description + "','" + aCourse.DepartmentId + "','" + aCourse.SemesterId + "')";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();

            return rowAffected;
        }

        public Course IsUniqeCode(string code)
        {
            Query = "SELECT * FROM Course WHERE Code = '" + code + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Course aCourse = new Course();

            if (!Reader.HasRows)
            {

                aCourse = null;


            }

            Reader.Close();
            Connection.Close();
            return aCourse;
        }

        public Course IsUniqeName(string name)
        {
            Query = "SELECT * FROM Course WHERE Name = '" + name + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Course aCourse = new Course();

            if (!Reader.HasRows)
            {

                aCourse = null;


            }

            Reader.Close();
            Connection.Close();
            return aCourse;
        }

        public List<Course> GetAllCourses()
        {
            Query = "Select * From Course";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            List<Course> courses = new List<Course>();
            while (Reader.Read())
            {
                Course aCourse = new Course();
                aCourse.Id = (int)Reader["Id"];
                aCourse.Code = Reader["Code"].ToString();
                aCourse.Name = Reader["Name"].ToString();
                aCourse.Cradit = Convert.ToDouble(Reader["Cradit"]);
                aCourse.Description = Reader["Description"].ToString();
                aCourse.DepartmentId = (int)Reader["DepartmentId"];
                aCourse.SemesterId = (int)Reader["SemesterId"];
                courses.Add(aCourse);
            }
            Reader.Close();
            Connection.Close();
            return courses;
        }


        public List<CourseStatistics> GetAllCourseStatisticesByDeptId(int deptId)
        {
            Query = "Select * From CourseStatisticsView Where DeptId = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            List<CourseStatistics> statisticses = new List<CourseStatistics>();
            while (Reader.Read())
            {
                
                CourseStatistics aStatistics = new CourseStatistics();
                aStatistics.CourseCode = Reader["Code"].ToString();
                aStatistics.CourseName = Reader["Title"].ToString();
                aStatistics.Semester = (int) Reader["Semester"];
                statisticses.RemoveAll(x => x.CourseCode == aStatistics.CourseCode);
                if (Reader["Valid"].ToString() == "true")
                {
                    
                    aStatistics.TeacherName = Reader["AssignedTo"].ToString();
                }
                else
                {
                    aStatistics.TeacherName = "Not Assigned Yet";
                }
                statisticses.Add(aStatistics);
            }
            Reader.Close();
            Connection.Close();
            return statisticses;
        }

        public int UpdateForUnAssignAllCourse(string str)
        {
            Query = str;
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public int UnAssignAllCourse()
        {
            if (UpdateForUnAssignAllCourse("Update CourseEnrollment Set Valid = 'false'") == 0)
                return 0;
            if (UpdateForUnAssignAllCourse("Update CourseAssignment Set Valid = 'false'") == 0)
                return 0;
            if (UpdateForUnAssignAllCourse("Update Teacher Set RemainingCredit = CreditLimit") == 0)
                return 0;
            return 1;
        }
    }
}
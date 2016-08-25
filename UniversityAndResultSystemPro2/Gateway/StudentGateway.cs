using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Gateway
{
    public class StudentGateway : Gateway
    {
        public int SaveStudent(Student student)
        {

            Query = "Insert INTO Student VALUES(@name, @regNo , @email, @contactNo, @regDate, @address, @deptId)";

            Command = new SqlCommand(Query, Connection);

            Command.Parameters.Clear();

            Command.Parameters.Add("name", SqlDbType.VarChar);
            Command.Parameters["name"].Value = student.Name;

            Command.Parameters.Add("regNo", SqlDbType.NVarChar);

            Command.Parameters["regNo"].Value = "0";
            //Command.Parameters["regNo"].Value = student.DepartmentId + " - " + student.RegDate.Year;

            Command.Parameters.Add("email", SqlDbType.VarChar);
            Command.Parameters["email"].Value = student.Email;

            Command.Parameters.Add("contactNo", SqlDbType.VarChar);
            Command.Parameters["contactNo"].Value = student.ContactNo;



            Command.Parameters.Add("regDate", SqlDbType.Date);
            Command.Parameters["regDate"].Value = student.RegDate;

            Command.Parameters.Add("address", SqlDbType.NVarChar);
            Command.Parameters["address"].Value = student.Address;

            Command.Parameters.Add("deptId", SqlDbType.Int);
            Command.Parameters["deptId"].Value = student.DepartmentId;

            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();

            GenerateRegistrationNumber(student);

            int deptId = student.DepartmentId;
            Query = "Select Name From Department Where Id = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                student.DeptName = Reader["Name"].ToString();
            }
            Reader.Close();
            Connection.Close();
           

            return rowAffected;

        }

        public Student IsUniqeEmail(string email)
        {
            Query = "SELECT * FROM Student WHERE Email = '" + email + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Student aStudent = new Student();

            if (!Reader.HasRows)
            {

                aStudent = null;


            }

            Reader.Close();
            Connection.Close();
            return aStudent;
        }

        public string GenerateRegistrationNumber(Student student)
        {
            string regNo = "";
            Query = "SELECT Code From Department Where id = " + student.DepartmentId;
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                regNo = Reader["Code"].ToString();
            }
            Reader.Close();
            Connection.Close();
            regNo += "-";
            regNo += student.RegDate.Year;
            regNo += "-";
            string pattern = "%" + regNo + "%";
            Query = "Select Count(RegNo) AS total From Student Where RegNo Like '" + pattern + "'";
            int total = 0;
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                total = (int)Reader["total"];
            }
            Reader.Close();
            Connection.Close();
            total++;
            string num = total.ToString();

            int diff = 3 - num.Length;
            for (int i = 1; i <= diff; i++)
                num = "0" + num;
            regNo += num;

            //Query = "Select Id from Student Where Email = " + student.Email;
            //Command = new SqlCommand(Query, Connection);
            //Connection.Open();
            //Reader = Command.ExecuteReader();
            //if (Reader.HasRows)
            //{
            //    Reader.Read();
            //    student.Id = (int)Reader["Id"];
            //}
            //Reader.Close();
            //Connection.Close();


            Query = "Update Student Set RegNo = '" + regNo + "' Where Email = '" + student.Email + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            student.RegNo = regNo;
            if (rowAffected > 0)
                return regNo;
            else
            {
                return "Problem in generating registration number";
            }

        }

        public List<SelectListItem> GetAllStudentsSelectListItem()
        {
            Query = "Select * From Student";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> items = new List<SelectListItem>();
            while (Reader.Read())
            {

                items.Add(new SelectListItem()
                {
                    Value = Reader["Id"].ToString(),
                    Text = Reader["RegNo"].ToString()


                });

            }

            Reader.Close();
            Connection.Close();

            return items;
        }

        public List<Student> GetStudentById(int studentId)
        {
            Query = "Select * from Student where Id = '" + studentId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<Student> students = new List<Student>();
            while (Reader.Read())
            {
                Student aStudent = new Student();
                aStudent.Id = (int)Reader["Id"];
                aStudent.Name = Reader["Name"].ToString();
                aStudent.Email = Reader["Email"].ToString();
                aStudent.RegNo = Reader["RegNo"].ToString();
                aStudent.ContactNo = Reader["ContactNo"].ToString();
                aStudent.DepartmentId = (int)Reader["DeptId"];
                students.Add(aStudent);
            }

            Reader.Close();
            Connection.Close();

            for (int i = 0; i < students.Count; i++)
            {
                int deptId = students[i].DepartmentId;
                Query = "Select Name From Department Where Id = '" + deptId + "'";
                Command = new SqlCommand(Query, Connection);
                Connection.Open();
                Reader = Command.ExecuteReader();
                while (Reader.Read())
                {
                    students[i].DeptName = Reader["Name"].ToString();
                }
                Reader.Close();
                Connection.Close();
                
            }

            return students;
        }

        public ResultSheet GenerateResultForStudentId(int  studentId)
        {
            ResultSheet aResultSheet = new ResultSheet();
            Query = "Select Name, RegNo, Email, DeptId From Student Where Id = '" + studentId + "' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            int deptId = 0;
            while (Reader.Read())
            {
                aResultSheet.Name = Reader["Name"].ToString();
                aResultSheet.RegNo = Reader["RegNo"].ToString();
                aResultSheet.Email = Reader["Email"].ToString();
                deptId = (int) Reader["DeptId"];
            }

            Reader.Close();
            Connection.Close();

           
            Query = "Select Name From Department Where Id = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                aResultSheet.DeptName = Reader["Name"].ToString();
            }
            Reader.Close();
            Connection.Close();
            

            Query = "Select * From CourseTakenByStudentView Where StudentId = '" + studentId + "' And Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            while (Reader.Read())
            {
                CourseResult aCourseResult = new CourseResult();
                aCourseResult.CourseCode = Reader["CourseCode"].ToString();
                aCourseResult.CourseName = Reader["CourseName"].ToString();
                aCourseResult.Grade = Reader["Grade"].ToString();
                aResultSheet.CourseResults.Add(aCourseResult);
            }


            Reader.Close();
            Connection.Close();
            return aResultSheet;
        }
    }
}
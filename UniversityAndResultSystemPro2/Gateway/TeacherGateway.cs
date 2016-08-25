using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Models;

namespace UniversityAndResultSystemPro2.Gateway
{
    public class TeacherGateway : Gateway
    {
        public List<SelectListItem> GetAllDesignation()
        {
            Query = "SELECT * FROM Designation";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<SelectListItem> designations = new List<SelectListItem>();

            while (Reader.Read())
            {

                designations.Add(new SelectListItem()
                {
                    Value = Reader["Name"].ToString(),
                    Text = Reader["Name"].ToString()
                });

            }

            Reader.Close();
            Connection.Close();

            return designations;
        }

        public int SaveTeacher(Teacher aTeacher)
        {
            Query = "Insert INTO Teacher VALUES(@name, @address , @email, @contactNo, @designation, @departmentId, @creditLimit, @remainingCredit)";

            Command = new SqlCommand(Query, Connection);

            Command.Parameters.Clear();

            Command.Parameters.Add("name", SqlDbType.VarChar);
            Command.Parameters["name"].Value = aTeacher.Name;

            Command.Parameters.Add("address", SqlDbType.NVarChar);
            Command.Parameters["address"].Value = aTeacher.Address;

            Command.Parameters.Add("email", SqlDbType.VarChar);
            Command.Parameters["email"].Value = aTeacher.Email;

            Command.Parameters.Add("contactNo", SqlDbType.VarChar);
            Command.Parameters["contactNo"].Value = aTeacher.ContactNo;

            Command.Parameters.Add("designation", SqlDbType.VarChar);
            Command.Parameters["designation"].Value = aTeacher.Designation;

            Command.Parameters.Add("departmentId", SqlDbType.Int);
            Command.Parameters["departmentId"].Value = aTeacher.DepartmentId;

            Command.Parameters.Add("creditLimit", SqlDbType.Decimal);
            Command.Parameters["creditLimit"].Value = aTeacher.CreditLimit;

            Command.Parameters.Add("remainingCredit", SqlDbType.Decimal);
            Command.Parameters["remainingCredit"].Value = aTeacher.CreditLimit;

            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();

            return rowAffected;
        }

        public Teacher IsUniqeEmail(string email)
        {
            Query = "SELECT * FROM Teacher WHERE Email = '" + email + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Teacher aTeacher = new Teacher();

            if (!Reader.HasRows)
            {

                aTeacher = null;


            }

            Reader.Close();
            Connection.Close();
            return aTeacher;
        }

        public List<Teacher> GetAllTeachers()
        {
            Query = "SELECT * FROM Teacher";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            List<Teacher> teachers = new List<Teacher>();

            while (Reader.Read())
            {
                Teacher aTeacher = new Teacher();

                aTeacher.Id = (int)Reader["Id"];
                aTeacher.Name = Reader["Name"].ToString();
                aTeacher.Address = Reader["Address"].ToString();
                aTeacher.ContactNo = Reader["ContactNo"].ToString();
                aTeacher.Email = Reader["Email"].ToString();
                aTeacher.Designation = Reader["Designation"].ToString();
                aTeacher.DepartmentId = (int)Reader["DepartmentId"];

                aTeacher.CreditLimit = Convert.ToDouble(Reader["CreditLimit"]);
                aTeacher.RemainingCredit = Convert.ToDouble(Reader["RemainingCredit"]);
                teachers.Add(aTeacher);
            }
            Reader.Close();
            Connection.Close();
            return teachers;
        }

        public int AssignCourseToTeacher(CourseAssignment courseAssignment)
        {
            Query = "Insert into CourseAssignment Values ('" + courseAssignment.CourseId + "','" + courseAssignment.TeacherId + "','true')";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();

            UpdateTeacherRemainingCredit(courseAssignment);

            return rowAffected;

        }

        public int UpdateTeacherRemainingCredit(CourseAssignment courseAssignment)
        {
            double courseCredit = 0;
            Query = "SELECT Cradit FROM Course Where Id = '" + courseAssignment.CourseId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                courseCredit = Convert.ToDouble(Reader["Cradit"]);
            }
            Reader.Close();
            Connection.Close();

            Query = "Update Teacher Set RemainingCredit = RemainingCredit - '" + courseCredit + "' Where Id = '" + courseAssignment.TeacherId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }
        public bool IsCourseAlreadyAssigned(CourseAssignment courseAssignment)
        {
            Query = "SELECT * FROM CourseAssignment Where CourseId = '" + courseAssignment.CourseId + "' AND Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool result = Reader.HasRows;
            Reader.Close();
            Connection.Close();
            return result;
        }
    }
}
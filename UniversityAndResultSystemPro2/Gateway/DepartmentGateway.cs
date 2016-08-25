using System; 
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Models;

namespace UniversityAndResultSystemPro2.Gateway
{
    public class DepartmentGateway:Gateway
    {
        public int Save(Department aDepartment)
        {
            Query = "Insert INTO Department VALUES('" + aDepartment.Code + "','" + aDepartment.Name + "')";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            int rowAffested= Command.ExecuteNonQuery();

            Connection.Close();

            return rowAffested;

          
        }

        public List<Department> GetAll()
        {
            Query = "SELECT * FROM Department";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<Department> departments = new List<Department>();
            while (Reader.Read())
            {
                Department aDepartment = new Department()
                {
                    Id = (int)Reader["Id"],
                    Code = Reader["Code"].ToString(),
                    Name  =Reader["Name"].ToString()
                };

                departments.Add(aDepartment);
            }
            Reader.Close();
            Connection.Close();


            return departments;
        }
        public List<SelectListItem> GetAllDepartment()
        {
            Query = "SELECT * FROM Department";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<SelectListItem> items = new List<SelectListItem>();
            while (Reader.Read())
            {
                //Department aDepartment = new Department()
                //{
                //    Id = (int)Reader["Id"],
                //    Code = Reader["Code"].ToString(),
                //    Name = Reader["Name"].ToString()
                //};

                items.Add(new SelectListItem()
                {
                    Value = Reader["Id"].ToString(),
                    Text = Reader["Code"].ToString()

                });
                //items.Add(aDepartment);
            }
            Reader.Close();
            Connection.Close();


            return items;
        }

        public List<SelectListItem> GetAllSemester()
        {
            Query = "SELECT * FROM Semester";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<SelectListItem> semesters = new List<SelectListItem>();
            while (Reader.Read())
            {
                semesters.Add(new SelectListItem()
                {
                    Value = Reader["Id"].ToString(),
                    Text = Reader["Name"].ToString()
                });
            }
            Reader.Close();
            Connection.Close();


            return semesters;
        }

        public Department IsUniqeCode(string code)
        {
            Query = "SELECT * FROM Department WHERE Code = '" + code + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Department aDepartment = new Department();

            if (!Reader.HasRows)
            {

                aDepartment = null;


            }

            Reader.Close();
            Connection.Close();
            return aDepartment;
        }

        public Department IsUniqeName(string name)
        {
            Query = "SELECT * FROM Department WHERE Name = '" + name + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Department aDepartment = new Department();

            if (!Reader.HasRows)
            {

                aDepartment = null;


            }

            Reader.Close();
            Connection.Close();
            return aDepartment;
        }

        public List<Department> GetAllDepartmentsInfo()
        {
            Query = "SELECT * FROM Department";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<Department> items = new List<Department>();
            while (Reader.Read())
            {
                Department aDepartment = new Department()
                {
                    Id = (int)Reader["Id"],
                    Code = Reader["Code"].ToString(),
                    Name = Reader["Name"].ToString()
                };

                //items.Add(new SelectListItem()
                //{
                //    Value = Reader["Id"].ToString(),
                //    Text = Reader["Code"].ToString()

                //});
                items.Add(aDepartment);
            }
            Reader.Close();
            Connection.Close();


            return items;
        }
    }
}
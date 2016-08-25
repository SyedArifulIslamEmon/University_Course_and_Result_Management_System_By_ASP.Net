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
    public class RoomNoGateway : Gateway
    {
        public List<SelectListItem> GetAllRoomNos()
        {
            Query = "SELECT * FROM Room";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> roomNoListItems = new List<SelectListItem>();

            while (Reader.Read())
            {
                roomNoListItems.Add(new SelectListItem()
                {
                    Value = Reader["RoomNo"].ToString(),
                    Text = Reader["RoomNo"].ToString()
                });
            }
            Reader.Close();
            Connection.Close();


            return roomNoListItems;
        }

        public List<SelectListItem> GetAllDays()
        {
            Query = "SELECT * FROM Day";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> dayListItems = new List<SelectListItem>();

            while (Reader.Read())
            {
                dayListItems.Add(new SelectListItem()
                {
                    Value = Reader["Name"].ToString(),
                    Text = Reader["Name"].ToString()
                });
            }
            Reader.Close();
            Connection.Close();


            return dayListItems;
        }

        public int SaveClassroomAllocationInfo(ClassroomAllocation classroomAllocation)
        {
            Query = "Insert Into ClassRoomAllocation Values ('" + classroomAllocation.DepartmentId + "','" + classroomAllocation.CourseId + "','" + classroomAllocation.RoomNo + "','" + classroomAllocation.Day + "','" + classroomAllocation.From + "','" + classroomAllocation.To + "','true')";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public bool ClassRoomConflict(ClassroomAllocation classroomAllocation)
        {
            //Query = "select * from ClassRoomAllocation Where Day = '" + classroomAllocation.Day + "' And RoomNo='" +
            //        classroomAllocation.RoomNo + "' And (('" + classroomAllocation.From + "'>=FromTime AND '" +
            //        classroomAllocation.From + "'<ToTime) OR ('" + classroomAllocation.To + "'>FromTime AND '" +
            //        classroomAllocation.To + "'<=ToTime)) And Valid = 'true'";
            Query = "select * from ClassRoomAllocation Where Day = '" + classroomAllocation.Day + "' And RoomNo='" +
                    classroomAllocation.RoomNo + "' And (('" + classroomAllocation.From + "'>=FromTime AND '" +
                    classroomAllocation.From + "'<ToTime) OR ('" + classroomAllocation.To + "'>FromTime AND '" +
                    classroomAllocation.To + "'<=ToTime)  OR ('" + classroomAllocation.From + "'<=FromTime AND '" +
                    classroomAllocation.To + "'>=ToTime)) And Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool result = Reader.HasRows;
            Connection.Close();
            
            //comment from line 94 to 105
            //if(result == true)
            //    return result;
            //Query = "select * from ClassRoomAllocation Where Day = '" + classroomAllocation.Day + "' And CourseId ='" +
            //        classroomAllocation.CourseId + "' And (('" + classroomAllocation.From + "'>=FromTime AND '" +
            //        classroomAllocation.From + "'<ToTime) OR ('" + classroomAllocation.To + "'>FromTime AND '" +
            //        classroomAllocation.To + "'<=ToTime)  OR ('" + classroomAllocation.From + "'<=FromTime AND '" +
            //        classroomAllocation.To + "'>=ToTime)) And Valid = 'true'";
            //Command = new SqlCommand(Query, Connection);
            //Connection.Open();
            //Reader = Command.ExecuteReader();
            //result = Reader.HasRows;
            //Connection.Close();
            
            
            return result;
        }

        public List<ClassScheduleTemp> GenerateTemporaryClassScheduleByDeptId(int deptId)
        {
            List<ClassScheduleTemp> classScheduleTemps = new List<ClassScheduleTemp>();
            Query = "Select * From ClassScheduleView Where DeptId = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            while (Reader.Read())
            {
                ClassScheduleTemp aClassScheduleTemp = new ClassScheduleTemp();
                aClassScheduleTemp.CourseCode = Reader["CourseCode"].ToString();
                aClassScheduleTemp.CourseName = Reader["CourseName"].ToString();
                aClassScheduleTemp.Day = Reader["Day"].ToString();
                aClassScheduleTemp.RoomNo = Reader["RoomNo"].ToString();
                if (Reader["FromTime"] != System.DBNull.Value)
                    aClassScheduleTemp.From = (int)Reader["FromTime"];
                else
                {
                    aClassScheduleTemp.From = -1;
                }
                if (Reader["ToTime"] != System.DBNull.Value)
                    aClassScheduleTemp.To = (int)Reader["ToTime"];
                else
                {
                    aClassScheduleTemp.To = -1;
                }
                aClassScheduleTemp.Valid = Reader["Valid"].ToString();
                classScheduleTemps.Add(aClassScheduleTemp);
            }

            Reader.Close();
            Connection.Close();
            return classScheduleTemps;
        }

        public string GenerateInfoString(ClassScheduleTemp aClassScheduleTemp)
        {
            string str = "";
            if (aClassScheduleTemp.Valid != "true")
                return str;
            str += "Room No.: " + aClassScheduleTemp.RoomNo + ", Day : " + aClassScheduleTemp.Day + ", ";
            str += " Time : " + GetTimeString(aClassScheduleTemp.From);
           
            str += " - " + GetTimeString(aClassScheduleTemp.To);
            str += ";<br/><br/>";
            return str;
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

        public int DayIndex(string str)
        {
            if (str == "Saturday")
                return 1;
            else if (str == "Sunday")
                return 2;
            else if (str == "Monday")
                return 3;
            else if (str == "Tuesday")
                return 4;
            else if (str == "Wednesday")
                return 5;
            else if (str == "Thursday")
                return 6;
            else 
                return 7;

        }

        public List<ClassScheduleFinal> GenerateFinalClassScheduleByDeptId(int deptId)
        {
            List<ClassScheduleTemp> classScheduleTemps = GenerateTemporaryClassScheduleByDeptId(deptId).OrderBy(a => a.CourseCode).ThenBy(a=>DayIndex(a.Day)).ThenBy(a=>a.From).ToList();
            //List<ClassScheduleTemp> classScheduleTemps = GenerateTemporaryClassScheduleByDeptId(deptId).OrderBy(a => a.CourseCode).ToList();
            List<ClassScheduleFinal> classScheduleFinals = new List<ClassScheduleFinal>();
            if (classScheduleTemps.Count == 0)
                return classScheduleFinals;
            string code, name, info, prev;
            info = "";

            code = classScheduleTemps[0].CourseCode;
            name = classScheduleTemps[0].CourseName;
            info += GenerateInfoString(classScheduleTemps[0]);
            prev = code;

            for (int i = 1; i < classScheduleTemps.Count; i++)
            {
                ClassScheduleTemp aClassScheduleTemp = classScheduleTemps[i];
                if (aClassScheduleTemp.CourseCode != prev)
                {
                    ClassScheduleFinal aClassScheduleFinal = new ClassScheduleFinal();
                    aClassScheduleFinal.CourseCode = code;
                    aClassScheduleFinal.CourseName = name;
                    if (info == "")
                        aClassScheduleFinal.Info = "not scheduled yet";
                    else
                    {
                        aClassScheduleFinal.Info = info;
                    }
                    classScheduleFinals.Add(aClassScheduleFinal);
                    code = aClassScheduleTemp.CourseCode;
                    name = aClassScheduleTemp.CourseName;
                    info = "";
                }
                info += GenerateInfoString(aClassScheduleTemp);
                prev = aClassScheduleTemp.CourseCode;
            }
            ClassScheduleFinal aClassScheduleFinal2 = new ClassScheduleFinal();
            aClassScheduleFinal2.CourseCode = code;
            aClassScheduleFinal2.CourseName = name;
            if (info == "")
                aClassScheduleFinal2.Info = "not scheduled yet";
            else
            {
                aClassScheduleFinal2.Info = info;
            }
            classScheduleFinals.Add(aClassScheduleFinal2);
            return classScheduleFinals;

        }

        public int UnallocateClassRoom()
        {
            Query = "Update ClassRoomAllocation Set Valid = 'false' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public bool ClassRoomConflictType2(ClassroomAllocation classroomAllocation)
        {
            
                
            Query = "select * from ClassRoomAllocation Where Day = '" + classroomAllocation.Day + "' And CourseId ='" +
                    classroomAllocation.CourseId + "' And (('" + classroomAllocation.From + "'>=FromTime AND '" +
                    classroomAllocation.From + "'<ToTime) OR ('" + classroomAllocation.To + "'>FromTime AND '" +
                    classroomAllocation.To + "'<=ToTime)  OR ('" + classroomAllocation.From + "'<=FromTime AND '" +
                    classroomAllocation.To + "'>=ToTime)) And Valid = 'true'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool result = Reader.HasRows;
            Connection.Close();
            return result;
        }
    }
}
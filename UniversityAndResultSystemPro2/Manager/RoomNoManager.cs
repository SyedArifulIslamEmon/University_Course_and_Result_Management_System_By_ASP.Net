using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityAndResultSystemPro2.Gateway;
using UniversityAndResultSystemPro2.Models;
using UniversityAndResultSystemPro2.Models.ViewModels;

namespace UniversityAndResultSystemPro2.Manager
{
    public class RoomNoManager
    {
        RoomNoGateway aRoomNoGateway = new RoomNoGateway();
        public List<SelectListItem> GetAllRoomNos()
        {
            return aRoomNoGateway.GetAllRoomNos();            
        }

        public List<SelectListItem> GetAllDays()
        {
            return aRoomNoGateway.GetAllDays();
        }


        public string SaveClassroomAllocationInfo(ClassroomAllocation classroomAllocation)
        {
            if (aRoomNoGateway.ClassRoomConflict(classroomAllocation))
                return "conflict";
            if (aRoomNoGateway.ClassRoomConflictType2(classroomAllocation))
                return "conflict2";
            if (classroomAllocation.To < classroomAllocation.From)
                return "invalid time";
            int rowAffected = aRoomNoGateway.SaveClassroomAllocationInfo(classroomAllocation);
            if (rowAffected > 0)
                return "yes";
            else
            {
                return "no";
            }
        }

        public List<ClassScheduleFinal> GetClassScheduleByDeptId(int departmentId)
        {
            return aRoomNoGateway.GenerateFinalClassScheduleByDeptId(departmentId);
        }

        public object UnallocateClassRoom()
        {
            int rowAffected = aRoomNoGateway.UnallocateClassRoom();
            if (rowAffected > 0)
                return "yes";
            else
                return "no";
        }
    }
}
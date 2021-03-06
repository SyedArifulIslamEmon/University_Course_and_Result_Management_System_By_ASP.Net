USE [master]
GO
/****** Object:  Database [Project2]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE DATABASE [Project2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Project2', FILENAME = N'H:\BITM-DotNet\Practise\Project 2\Project2.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Project2_log', FILENAME = N'H:\BITM-DotNet\Practise\Project 2\Project2_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Project2] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Project2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Project2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Project2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Project2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Project2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Project2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Project2] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Project2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Project2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Project2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Project2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Project2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Project2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Project2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Project2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Project2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Project2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Project2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Project2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Project2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Project2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Project2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Project2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Project2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Project2] SET  MULTI_USER 
GO
ALTER DATABASE [Project2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Project2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Project2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Project2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Project2]
GO
/****** Object:  Table [dbo].[ClassRoomAllocation]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClassRoomAllocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeptId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[RoomNo] [varchar](50) NOT NULL,
	[Day] [varchar](50) NOT NULL,
	[FromTime] [int] NOT NULL,
	[ToTime] [int] NOT NULL,
	[Valid] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ClassRoomAllocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Course]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Cradit] [decimal](3, 2) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[SemesterId] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseAssignment]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseAssignment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
	[Valid] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CourseAssignment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourseEnrollment]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourseEnrollment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[EnrollDate] [date] NOT NULL,
	[Grade] [varchar](50) NOT NULL,
	[Valid] [varchar](10) NOT NULL,
 CONSTRAINT [PK_CourseEnrollment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Day]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Day](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Day] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Designation]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Designation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LetterGrade] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Room]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomNo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Semester]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Semester](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RegNo] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ContactNo] [varchar](50) NOT NULL,
	[RegDate] [date] NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[DeptId] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ContactNo] [varchar](50) NOT NULL,
	[Designation] [varchar](100) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CreditLimit] [decimal](18, 2) NOT NULL,
	[RemainingCredit] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[ClassScheduleView]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[ClassScheduleView] As
Select Course.Code as CourseCode, Course.Name as CourseName, Course.DepartmentId as DeptId,
ClassRoomAllocation.Day as Day, ClassRoomAllocation.RoomNo as RoomNo, ClassRoomAllocation.FromTime as FromTime,
ClassRoomAllocation.ToTime as ToTime, ClassRoomAllocation.Valid as Valid
from Course Left Join ClassRoomAllocation on Course.Id = ClassRoomAllocation.CourseId 






GO
/****** Object:  View [dbo].[CourseStatisticsView]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View  [dbo].[CourseStatisticsView] As
select Course.Code As Code, Course.Name As Title, Course.SemesterId As Semester, Teacher.Name As AssignedTo, Course.DepartmentId As DeptId, CourseAssignment.Valid As Valid
From Course 
Left Join CourseAssignment on Course.Id = CourseAssignment.CourseId
Left Join Teacher on CourseAssignment.TeacherId = Teacher.Id








GO
/****** Object:  View [dbo].[CourseTakenByStudentView]    Script Date: 10/08/2016 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[CourseTakenByStudentView] as
Select Student.Id as StudentId, Student.Name as StudentName, Course.Id as CourseId, Course.Name as CourseName, Course.Code as CourseCode, 
CourseEnrollment.Grade as Grade ,CourseEnrollment.Valid as Valid
From Student 
inner join CourseEnrollment on student.Id = CourseEnrollment.StudentId
inner join Course on CourseEnrollment.CourseId = Course.Id







GO
SET IDENTITY_INSERT [dbo].[ClassRoomAllocation] ON 

INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (1, 1, 1, N'101', N'Saturday', 480, 600, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (2, 1, 1, N'101', N'Sunday', 540, 600, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (3, 1, 2, N'201', N'Saturday', 570, 682, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (4, 1, 3, N'202', N'Saturday', 570, 720, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (5, 2, 9, N'201', N'Monday', 480, 540, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (6, 3, 14, N'101', N'Monday', 1428, 1439, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (7, 2, 10, N'101', N'Tuesday', 1230, 1260, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (8, 2, 13, N'102', N'Tuesday', 1230, 1260, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (9, 3, 15, N'201', N'Tuesday', 720, 780, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (10, 3, 7, N'301', N'Saturday', 1200, 1439, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (11, 4, 20, N'101', N'Wednesday', 1230, 1319, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (12, 4, 21, N'103', N'Wednesday', 1200, 1282, N'true')
INSERT [dbo].[ClassRoomAllocation] ([Id], [DeptId], [CourseId], [RoomNo], [Day], [FromTime], [ToTime], [Valid]) VALUES (13, 4, 22, N'103', N'Wednesday', 540, 622, N'true')
SET IDENTITY_INSERT [dbo].[ClassRoomAllocation] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (1, N'CSE-101', N'C Programming', CAST(3.00 AS Decimal(3, 2)), N'C (/''si?/, as in the letter c) is a general-purpose, imperative computer programming language, supporting structured programming, lexical variable scope and recursion, while a static type system prevents many unintended operations. By design, C provides constructs that map efficiently to typical machine instructions, and therefore it has found lasting use in applications that had formerly been coded in assembly language, including operating systems, as well as various application software for computers ranging from supercomputers to embedded systems.', 1, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (2, N'CSE-201', N'Object Oriented Programming I', CAST(3.50 AS Decimal(3, 2)), N'Object-oriented programming (OOP) is a programming paradigm based on the concept of "objects", which may contain data, in the form of fields, often known as attributes; and code, in the form of procedures, often known as methods.', 1, 2)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (3, N'CSE-301', N'Object Oriented Programming II', CAST(3.00 AS Decimal(3, 2)), N'Object-oriented programming (OOP) refers to a type of computer programming (software design) in which programmers define not only the data type of a data structure, but also the types of operations (functions) that can be applied to the data structure.', 1, 3)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (4, N'CSE-202', N'Data Structures', CAST(2.50 AS Decimal(3, 2)), N'In computer science, a data structure is a particular way of organizing data in a computer so that it can be used efficiently.', 1, 2)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (5, N'CSE-801', N'Project / Thesis', CAST(5.00 AS Decimal(3, 2)), N'Final dissertation', 1, 8)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (6, N'AE-801', N'AE Project', CAST(5.00 AS Decimal(3, 2)), N'Final dissertation', 2, 8)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (7, N'ME-801', N'ME Project', CAST(5.00 AS Decimal(3, 2)), N'Final Dissertation', 3, 8)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (8, N'RE-801', N'RE Project', CAST(5.00 AS Decimal(3, 2)), N'Final Dissertation', 5, 8)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (9, N'AEROSP 101', N'Introduction to Aerospace Engineering', CAST(2.00 AS Decimal(3, 2)), N'Introduction to Aerospace Engineering. Flight vehicles in the atmosphere and in space. Flight technologies, including structures, materials, propulsion, aerodynamics, vehicle dynamics, flight control, flight information systems and systems integration. An overview of aeronautics. Steady aircraft flight and performance. An overview of astronautics.', 2, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (10, N'AEROSP 201', N'Aerodynamics', CAST(2.50 AS Decimal(3, 2)), N'Fundamental concepts in aerodynamics. Students learn how airfoils produce lift and how the pressure distribution about an airfoil can be calculated. Introduces the boundary-layer concept, how boundary layers lead to drag and what makes them prone to instability and turbulence or separation. Effects of the wing planform shape on lift and drag. Introduction to airfoil design, high-lift devices and high-speed aerodynamics.', 2, 2)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (11, N'AEROSP 301', N'Aircraft Dynamics and Control', CAST(3.00 AS Decimal(3, 2)), N'Introduction to the dynamics and control of atmospheric flight vehicles. Nonlinear equations of motion. Stability derivatives and linearized equations for longitudinal and lateral flight dynamics. Concepts from linear systems: state equations, transfer functions, stability, time response, frequency response. Fundamentals of feedback control, including root locus and Nyquist analysis applied to flight control.', 2, 3)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (12, N'AEROSP 401', N'Engineering Aerodynamics', CAST(3.50 AS Decimal(3, 2)), N'This course teaches contemporary aerodynamic analysis and design of aerospace vehicles and other systems. Topics include: review of theoretical concepts and methods, computer-based CFD tools, experimental methods and wind tunnel testing. Case studies are discussed to illustrate the combined use of advanced aerodynamic design methods. A team project is required.', 2, 4)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (13, N'AEROSP 535', N'Rocket Propulsion ', CAST(4.00 AS Decimal(3, 2)), N'Analysis of liquid and solid propellant rocket power plants; propellant thermochemistry, heat transfer, system considerations. Low-thrust rockets, multi-stage rockets, trajectories in powered flight, electric propulsion.', 2, 5)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (14, N'ENGG1100', N'Engineering Design', CAST(2.00 AS Decimal(3, 2)), N'Basics about Engineering Design', 3, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (15, N'ENGG1200', N'Engineering Modelling & Problem Solving', CAST(3.50 AS Decimal(3, 2)), N'In this groundbreaking new text, Jay Brockman helps students acquire the engineering mindset, providing them with the core knowledge and skills all engineers need to succeed.', 3, 2)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (17, N'MECH2410', N'Fundamentals of Fluid Mechanics', CAST(3.00 AS Decimal(3, 2)), N'Basics about Fundamentals of Fluid Mechanics', 3, 3)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (18, N'MECH3250', N'Engineering Acoustics', CAST(3.50 AS Decimal(3, 2)), N'Acoustical engineering (also known as acoustic engineering) is the branch of engineering dealing with sound and vibration. It is the application of acoustics, the science of sound and vibration, in technology. Acoustical engineers are typically concerned with the design, analysis and control of sound.', 3, 4)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (19, N'MECH4470', N'Hypersonics & Rarefied Gas Dynamics', CAST(4.00 AS Decimal(3, 2)), N'Hypersonic gas dynamics including: hypersonic equivalence, small perturbation, blunt body analysis, viscous flows, non-equilibrium flows, rarefied gas dynamics, satellite drag.', 3, 5)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (20, N'CL102', N'Mechanics of Solids', CAST(3.00 AS Decimal(3, 2)), N'Solid mechanics is the branch of continuum mechanics that studies the behavior of solid materials, especially their motion and deformation under the action of forces, temperature changes, phase changes, and other external or internal agents.', 4, 1)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (21, N'EE101', N'Elements of Electrical Engineering', CAST(3.50 AS Decimal(3, 2)), N'Electrical engineering is a field of engineering that generally deals with the study and ..... Telecommunications engineering focuses on the transmission of information.', 4, 2)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (22, N'EC302', N'Digital Circuits', CAST(3.00 AS Decimal(3, 2)), N'A digital circuit is typically constructed from small electronic circuits called logic gates that can be used to create combinational logic. Each logic gate is designed to perform a function of boolean logic when acting on logic signals.', 4, 3)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (23, N'EC503', N'Microprocessor and Computer Architecture', CAST(4.00 AS Decimal(3, 2)), N'A high-performance microprocessor is at the heart of every general-purpose computer, from servers, to desktop and laptop PCs, to open cell-phone platforms such as the iPhone. Its job is to execute software programs correctly and as quickly as possible, within challenging cost and power constraints.', 4, 5)
INSERT [dbo].[Course] ([Id], [Code], [Name], [Cradit], [Description], [DepartmentId], [SemesterId]) VALUES (24, N'EC801', N'Major Project', CAST(5.00 AS Decimal(3, 2)), N'Final dissertation', 4, 8)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[CourseAssignment] ON 

INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (1, 5, 4, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (2, 4, 1, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (3, 1, 2, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (4, 6, 12, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (5, 9, 9, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (6, 10, 10, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (7, 11, 11, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (8, 7, 5, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (9, 14, 6, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (10, 15, 7, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (11, 17, 8, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (12, 20, 13, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (13, 21, 14, N'true')
INSERT [dbo].[CourseAssignment] ([Id], [CourseId], [TeacherId], [Valid]) VALUES (14, 23, 15, N'true')
SET IDENTITY_INSERT [dbo].[CourseAssignment] OFF
SET IDENTITY_INSERT [dbo].[CourseEnrollment] ON 

INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (1, 1, 1, CAST(0x033B0B00 AS Date), N'A+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (2, 1, 2, CAST(0xB93B0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (3, 1, 3, CAST(0x363A0B00 AS Date), N'A+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (4, 2, 3, CAST(0xAE3A0B00 AS Date), N'A-', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (5, 2, 5, CAST(0xAF3A0B00 AS Date), N'A+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (6, 2, 4, CAST(0x303A0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (7, 4, 4, CAST(0x703C0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (8, 5, 7, CAST(0x923C0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (9, 5, 14, CAST(0x683A0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (10, 5, 17, CAST(0x763A0B00 AS Date), N'B+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (11, 6, 22, CAST(0x653B0B00 AS Date), N'A-', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (12, 8, 11, CAST(0xB93B0B00 AS Date), N'D-', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (13, 8, 12, CAST(0xB93B0B00 AS Date), N'C', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (14, 10, 20, CAST(0xB93B0B00 AS Date), N'B+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (15, 10, 24, CAST(0x693A0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (16, 9, 17, CAST(0x5A3C0B00 AS Date), N'Not Graded Yet', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (17, 12, 10, CAST(0xB93B0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (18, 9, 18, CAST(0xF83B0B00 AS Date), N'Not Graded Yet', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (19, 12, 6, CAST(0x533C0B00 AS Date), N'B+', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (20, 12, 9, CAST(0xA73A0B00 AS Date), N'A-', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (21, 12, 11, CAST(0x253B0B00 AS Date), N'A', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (22, 12, 12, CAST(0xB93B0B00 AS Date), N'A-', N'true')
INSERT [dbo].[CourseEnrollment] ([Id], [StudentId], [CourseId], [EnrollDate], [Grade], [Valid]) VALUES (23, 12, 13, CAST(0xCB3A0B00 AS Date), N'A+', N'true')
SET IDENTITY_INSERT [dbo].[CourseEnrollment] OFF
SET IDENTITY_INSERT [dbo].[Day] ON 

INSERT [dbo].[Day] ([Id], [Name]) VALUES (1, N'Saturday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (2, N'Sunday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (3, N'Monday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (4, N'Tuesday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (5, N'Wednesday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (6, N'Thursday')
INSERT [dbo].[Day] ([Id], [Name]) VALUES (7, N'Friday')
SET IDENTITY_INSERT [dbo].[Day] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (1, N'CSE', N'Computer Science and Engineering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (2, N'AE', N'Aerospace Engineering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (3, N'ME', N'Mechanical Engineering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (4, N'ECE', N'Electronic and Communications Engineering')
INSERT [dbo].[Department] ([Id], [Code], [Name]) VALUES (5, N'RE', N'Robotics Engineering')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Designation] ON 

INSERT [dbo].[Designation] ([Id], [Name]) VALUES (2, N'Assistant Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (3, N'Associate Professor')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (1, N'Lecturer')
INSERT [dbo].[Designation] ([Id], [Name]) VALUES (4, N'Professor')
SET IDENTITY_INSERT [dbo].[Designation] OFF
SET IDENTITY_INSERT [dbo].[Grade] ON 

INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (1, N'A+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (2, N'A')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (3, N'A-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (4, N'B+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (5, N'B')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (6, N'B-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (7, N'C+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (8, N'C')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (9, N'C-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (10, N'D+')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (11, N'D')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (12, N'D-')
INSERT [dbo].[Grade] ([Id], [LetterGrade]) VALUES (13, N'F')
SET IDENTITY_INSERT [dbo].[Grade] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (1, N'101')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (2, N'102')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (3, N'103')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (4, N'201')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (5, N'202')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (6, N'203')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (7, N'301')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (8, N'302')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (9, N'303')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (10, N'401')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (11, N'402')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (12, N'403')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (13, N'501')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (14, N'502')
INSERT [dbo].[Room] ([Id], [RoomNo]) VALUES (15, N'503')
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[Semester] ON 

INSERT [dbo].[Semester] ([Id], [Name]) VALUES (1, N'1st')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (2, N'2nd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (3, N'3rd')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (4, N'4th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (5, N'5th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (6, N'6th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (7, N'7th')
INSERT [dbo].[Semester] ([Id], [Name]) VALUES (8, N'8th')
SET IDENTITY_INSERT [dbo].[Semester] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (1, N'Kazi Shoaib Mohammad', N'CSE-2014-001', N'kazi.shoaib.md@gmail.com', N'01713228615', CAST(0x4A390B00 AS Date), N'Agrabad, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (2, N'Shaon Dey', N'CSE-2014-002', N'shaondey@protonmail.ch', N'01725494684', CAST(0x3C390B00 AS Date), N'Chandgaon R/A, Bahadarhat, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (3, N'Tonmoy Rudra', N'CSE-2015-001', N'tonmoy.rudra@gmail.com', N'01515346324', CAST(0x9E390B00 AS Date), N'Andorkilla, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (4, N'Talat Mahamud Sourave', N'CSE-2016-001', N'tms.iiuc@yahoo.com', N'01814354564', CAST(0x073B0B00 AS Date), N'Oxyzen, Chittagong', 1)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (5, N'Tanzimul Alam Tanim', N'ME-2017-001', N'tanim.iiuc@gmail.com', N'01946134685', CAST(0xFC3C0B00 AS Date), N'Mehedibag, Chittagong', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (6, N'Imran Hossen', N'ECE-2018-001', N'imran.cse@protonmail.ch', N'01534686489', CAST(0x293E0B00 AS Date), N'Agrabad, Chittagong', 4)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (7, N'Tohidul Alam Tuhin', N'RE-2015-001', N'tuhin.iiuc@live.com', N'01814644561', CAST(0xB4390B00 AS Date), N'Sitakund, Chittagong', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (8, N'Abdur Rahuman', N'AE-2016-001', N'wmarahuman@protonmail.ch', N'01724679134', CAST(0xB93B0B00 AS Date), N'Bahaddarhat, Chittagong', 2)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (9, N'Rimon Hossain', N'ME-2017-002', N'rimon.iiuc@outlook.com', N'01814354695', CAST(0xF53C0B00 AS Date), N'Chawkbazar, Chittagong', 3)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (10, N'Akibul Islam', N'ECE-2016-001', N'akibul.akib@outlook.com', N'01814354646', CAST(0xB93B0B00 AS Date), N'Khulshi, Chittagong', 4)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (11, N'Shafiul Adon', N'RE-2016-001', N'adon.re@hotmail.com', N'01916234595', CAST(0xB93B0B00 AS Date), N'Noakhali', 5)
INSERT [dbo].[Student] ([Id], [Name], [RegNo], [Email], [ContactNo], [RegDate], [Address], [DeptId]) VALUES (12, N'Shuvro Biswas', N'AE-2015-001', N'shuvro.ae@ymail.com', N'01924613278', CAST(0xD93A0B00 AS Date), N'Sitakund, Chittagong', 2)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (1, N'Mohammed Safiullah', N'Chawkbazar, Chittagong', N'safiullah@gmail.com', N'01711304565', N'Assistant Professor', 1, CAST(17.00 AS Decimal(18, 2)), CAST(14.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (2, N'Shahidul Islam Khan', N'College Road, Chawkbazar, Chittagong', N'nayeemkh@yahoo.com', N'01724367898', N'Assistant Professor', 1, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (3, N'Sazid Zaman Khan', N'Mehedibag, Chittagong', N'szkhanctg@yahoo.com', N'01814354676', N'Lecturer', 1, CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (4, N'Mohammed Arif Hasnayeen', N'College Road, Chawkbazar, Chittagong', N'ahasnayeen@hotmail.com', N'01713228616', N'Assistant Professor', 1, CAST(7.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (5, N'Shahereen Chowdhury', N'Dhaka 1000, Bangladesh', N'shahereen.chowdhury@gmail.com', N'01919998883', N'Lecturer', 3, CAST(7.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (6, N'Dr. Sanjib Chandra Chowdhury', N'Khulshi, Chittagong', N'aloke@me.buet.ac.bd', N'01713224566', N'Associate Professor', 3, CAST(15.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (7, N'Dr. Sumon Saha', N'Dhaka 1000, Bangladesh', N'sumonsaha@me.buet.ac.bd', N'01926197002', N'Assistant Professor', 3, CAST(13.00 AS Decimal(18, 2)), CAST(9.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (8, N'Dr. Md. Quamrul Islam', N'Dhaka 1000, Bangladesh.', N'quamrul@me.buet.ac.bd', N'01861304622', N'Professor', 3, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (9, N'Craig Arnold', N'London, England', N'cbarnold@princeton.edu', N'01513462464', N'Professor', 2, CAST(17.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (10, N'Emily A. Carter', N'New York, USA', N'eac@princeton.edu', N'01515346457', N'Associate Professor', 2, CAST(15.00 AS Decimal(18, 2)), CAST(12.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (11, N'Alexander Glaser', N'LA, USA', N'aglaser@princeton.edu', N'01515346962', N'Associate Professor', 2, CAST(13.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (12, N'Marcus Hultmark', N'London, England', N'hultmark@princeton.edu', N'01515346724', N'Lecturer', 2, CAST(6.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (13, N'Dr Md. Rabiul Islam', N'Rajshahi', N'rabiulbd@hotmail.com', N'01721750743', N'Professor', 4, CAST(17.00 AS Decimal(18, 2)), CAST(14.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (14, N'Md. Samiul Habib', N'Rajshahi', N'samiul.habib@sydney.edu.au', N'61470647883', N'Assistant Professor', 4, CAST(15.00 AS Decimal(18, 2)), CAST(11.50 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (15, N'Jishan-E- Giti', N'Rajshahi', N'jishaneee06@ruet.ac.bd', N'01921619385', N'Associate Professor', 4, CAST(15.00 AS Decimal(18, 2)), CAST(11.00 AS Decimal(18, 2)))
INSERT [dbo].[Teacher] ([Id], [Name], [Address], [Email], [ContactNo], [Designation], [DepartmentId], [CreditLimit], [RemainingCredit]) VALUES (16, N'Pejush Chandra Sarker', N'Rajshahi', N'pejush.cs@gmail.com', N'01814647896', N'Lecturer', 4, CAST(4.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Teacher] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Course]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Course] ON [dbo].[Course]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Course_1]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Course_1] ON [dbo].[Course]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Department]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Department] ON [dbo].[Department]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Department_1]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Department_1] ON [dbo].[Department]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Designation]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Designation] ON [dbo].[Designation]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Student]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Student] ON [dbo].[Student]
(
	[RegNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Student_1]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Student_1] ON [dbo].[Student]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Teacher]    Script Date: 10/08/2016 11:12:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Teacher] ON [dbo].[Teacher]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClassRoomAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoomAllocation_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[ClassRoomAllocation] CHECK CONSTRAINT [FK_ClassRoomAllocation_Course]
GO
ALTER TABLE [dbo].[ClassRoomAllocation]  WITH CHECK ADD  CONSTRAINT [FK_ClassRoomAllocation_Department] FOREIGN KEY([DeptId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[ClassRoomAllocation] CHECK CONSTRAINT [FK_ClassRoomAllocation_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Semester] FOREIGN KEY([SemesterId])
REFERENCES [dbo].[Semester] ([Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Semester]
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[CourseAssignment] CHECK CONSTRAINT [FK_CourseAssignment_Course]
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teacher] ([Id])
GO
ALTER TABLE [dbo].[CourseAssignment] CHECK CONSTRAINT [FK_CourseAssignment_Teacher]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([Id])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Course]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Student]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Department]
GO
USE [master]
GO
ALTER DATABASE [Project2] SET  READ_WRITE 
GO

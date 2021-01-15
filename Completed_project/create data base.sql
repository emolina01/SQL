USE [master]
GO

/****** Object:  Database [Project]    Script Date: 4/14/2018 5:18:29 PM ******/
CREATE DATABASE [Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Project.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Project] SET COMPATIBILITY_LEVEL = 130
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Project] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Project] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Project] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Project] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Project] SET ARITHABORT OFF 
GO

ALTER DATABASE [Project] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Project] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Project] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Project] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Project] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Project] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Project] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Project] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Project] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Project] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Project] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Project] SET RECOVERY FULL 
GO

ALTER DATABASE [Project] SET  MULTI_USER 
GO

ALTER DATABASE [Project] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Project] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Project] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Project] SET QUERY_STORE = OFF
GO

USE [Project]
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [Project] SET  READ_WRITE 
GO


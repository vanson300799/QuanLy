USE [master]
GO
/****** Object:  Database [Petro]    Script Date: 12/24/2020 6:21:41 PM ******/
CREATE DATABASE [Petro]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Petro', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Petro.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Petro_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Petro_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Petro] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Petro].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Petro] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Petro] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Petro] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Petro] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Petro] SET ARITHABORT OFF 
GO
ALTER DATABASE [Petro] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Petro] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Petro] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Petro] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Petro] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Petro] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Petro] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Petro] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Petro] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Petro] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Petro] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Petro] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Petro] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Petro] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Petro] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Petro] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Petro] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Petro] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Petro] SET  MULTI_USER 
GO
ALTER DATABASE [Petro] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Petro] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Petro] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Petro] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Petro] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Petro] SET QUERY_STORE = OFF
GO
USE [Petro]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Petro]
GO
/****** Object:  Table [dbo].[AccessAdminSiteRole]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessAdminSiteRole](
	[RoleId] [int] NOT NULL,
	[AdminSiteID] [int] NOT NULL,
 CONSTRAINT [PK_AccessAdminSitesRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[AdminSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccessAdminSites]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessAdminSites](
	[UserId] [int] NOT NULL,
	[AdminSiteID] [int] NOT NULL,
 CONSTRAINT [PK_AccessPermissions] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[AdminSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccessLogs]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessLogs](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[Action] [nvarchar](255) NULL,
 CONSTRAINT [PK_AccessLogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccessWebModuleRole]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessWebModuleRole](
	[RoleId] [int] NOT NULL,
	[WebModuleID] [int] NOT NULL,
	[View] [bit] NULL,
	[Add] [bit] NULL,
	[Edit] [bit] NULL,
	[Delete] [bit] NULL,
	[Approve] [bit] NULL,
 CONSTRAINT [PK_AccessWebModulesRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[WebModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccessWebModules]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessWebModules](
	[UserId] [int] NOT NULL,
	[WebModuleID] [int] NOT NULL,
	[View] [bit] NULL,
	[Add] [bit] NULL,
	[Edit] [bit] NULL,
	[Delete] [bit] NULL,
 CONSTRAINT [PK_AccessWebModules] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[WebModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminSites]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminSites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Url] [nvarchar](255) NULL,
	[ParentID] [int] NULL,
	[AccessKey] [varchar](50) NULL,
	[Order] [int] NULL,
	[Img] [nvarchar](255) NULL,
 CONSTRAINT [PK_AdminSites] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdvertisementPositions]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertisementPositions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [varchar](255) NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AdvertisementPositions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Advertisements]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Advertisements](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Media] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[Target] [varchar](50) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[AdvertisementPositionID] [int] NULL,
	[Culture] [nvarchar](50) NULL,
	[Video] [nvarchar](500) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Advertisements] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommissionManagement]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommissionManagement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TimeApply] [datetime] NOT NULL,
	[CustomerID] [int] NULL,
	[ShopID] [int] NULL,
	[Commission] [decimal](10, 2) NOT NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommodityCategory]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommodityCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CommodityID] [nvarchar](128) NOT NULL,
	[CommodityName] [nvarchar](256) NOT NULL,
	[Tax] [decimal](6, 4) NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__Commodit__3214EC279AD6372E] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentImages]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentImages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](255) NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Order] [int] NULL,
	[Slide] [bit] NULL,
	[WebContentID] [int] NULL,
 CONSTRAINT [PK_ContentImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentRelateds]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentRelateds](
	[MainID] [int] NOT NULL,
	[RelatedID] [int] NOT NULL,
	[Order] [int] NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_ContentRelateds] PRIMARY KEY CLUSTERED 
(
	[MainID] ASC,
	[RelatedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentTypes]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentTypes](
	[ID] [varchar](50) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Controller] [nvarchar](255) NULL,
	[Order] [int] NULL,
	[Entity] [nvarchar](50) NULL,
 CONSTRAINT [PK_ContentTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[IsoCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerCategory]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nvarchar](128) NOT NULL,
	[CustomerName] [nvarchar](256) NOT NULL,
	[TaxCode] [nvarchar](64) NULL,
	[CustomerAddress] [nvarchar](256) NULL,
	[PhoneNumber] [nvarchar](32) NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__Customer__3214EC2759274041] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DealDetail]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DealDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ShopID] [int] NOT NULL,
	[Description] [nchar](128) NULL,
	[DiscountAmount] [numeric](10, 2) NULL,
	[FreightPrice] [numeric](10, 2) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK_DealDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[District]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[ID] [varchar](20) NOT NULL,
	[DistrictName] [nvarchar](191) NOT NULL,
	[ProvinceID] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FreightPrice]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FreightPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TimeApply] [datetime] NOT NULL,
	[ShopID] [int] NULL,
	[Information] [nchar](1024) NULL,
	[IsLock] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK_FreightPrice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportOrdersChild]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportOrdersChild](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParrentID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CommodityID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ShopID] [int] NOT NULL,
	[InputNumber] [decimal](10, 2) NOT NULL,
	[InputPrice] [decimal](10, 2) NOT NULL,
	[Money] [decimal](10, 2) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportOrdersParrent]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportOrdersParrent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[BillID]  AS ('DN'+right('0000'+CONVERT([nvarchar](8),[ID]),(8))) PERSISTED,
	[SupplierID] [int] NOT NULL,
	[ShopID] [int] NULL,
	[Information] [nvarchar](1024) NULL,
	[TotalQuantity] [decimal](10, 2) NULL,
	[TotalMoney] [decimal](10, 2) NULL,
	[IsLock] [bit] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__ImportOr__3214EC277DBDA5D9] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[ID] [varchar](10) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Published] [bit] NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListedPrice]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListedPrice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TimeApply] [datetime] NOT NULL,
	[PriceListed] [decimal](10, 2) NULL,
	[CommodityID] [int] NOT NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__ListedPr__3214EC278025A14A] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](500) NULL,
	[DistrictID] [varchar](20) NULL,
	[ProvinceID] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogSystem]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogSystem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ActiveType] [nvarchar](64) NOT NULL,
	[FunctionName] [nvarchar](128) NOT NULL,
	[DataTable] [nvarchar](128) NULL,
	[DateTime] [datetime] NULL,
	[Information] [nvarchar](4000) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ModuleNavigations]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModuleNavigations](
	[WebModuleID] [int] NOT NULL,
	[NavigationID] [int] NOT NULL,
 CONSTRAINT [PK_ModuleNavigations] PRIMARY KEY CLUSTERED 
(
	[WebModuleID] ASC,
	[NavigationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Navigations]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Navigations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Order] [int] NULL,
	[Key] [varchar](50) NULL,
 CONSTRAINT [PK_Navigations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteBookKey]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteBookKey](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateTimeKey] [datetime] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partner]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partner](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerName] [nvarchar](255) NULL,
	[Address] [nvarchar](500) NULL,
	[Email] [nvarchar](255) NULL,
	[Mobile] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Price]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TimeApply] [datetime] NOT NULL,
	[CommodityID] [int] NOT NULL,
	[ShopID] [int] NULL,
	[CustomerID] [int] NULL,
	[Prices] [decimal](10, 2) NOT NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingTable]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RouteID] [int] NULL,
	[VehicleID] [int] NULL,
	[Price] [float] NULL,
	[SourcePartnerID] [int] NULL,
	[DestinationPartnerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductInfos]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductInfos](
	[ID] [int] NOT NULL,
	[Code] [nvarchar](255) NULL,
	[Price] [float] NULL,
 CONSTRAINT [PK_ProductInfos_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Province]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Province](
	[ID] [varchar](20) NOT NULL,
	[ProvinceName] [nvarchar](191) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Route]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EndLocationID] [int] NULL,
	[StartLocationID] [int] NULL,
	[RouteCode] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShopCategory]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShopCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ShopCode] [nvarchar](256) NOT NULL,
	[ShoprName] [nvarchar](256) NOT NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK_ShopCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscribeNotices]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscribeNotices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupplierCategory]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [nvarchar](128) NOT NULL,
	[SupplierName] [nvarchar](256) NULL,
	[Taxcode] [nvarchar](64) NULL,
	[SupplierAddress] [nvarchar](256) NULL,
	[PhoneNumber] [nvarchar](32) NULL,
	[Information] [nvarchar](1024) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__Supplier__3214EC276F5D6E50] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransportActual]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportActual](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlanID] [int] NULL,
	[Status] [nvarchar](500) NULL,
	[ActualDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransportPlan]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransportPlan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlanDate] [datetime] NULL,
	[TrackingCode] [nvarchar](255) NULL,
	[VehicleID] [int] NULL,
	[RouteID] [int] NULL,
	[TripCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UploadFiles]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UploadFiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Link] [varchar](max) NULL,
 CONSTRAINT [PK_UploadFile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[StaffCode] [nvarchar](128) NULL,
	[BranchId] [int] NULL,
	[UserName] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Mobile] [nvarchar](255) NULL,
	[Avatar] [nvarchar](255) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedAt] [datetime] NULL,
 CONSTRAINT [PK__UserProf__1788CC4CC234D91B] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CarOwerName] [nvarchar](255) NULL,
	[NumberPlate] [nvarchar](255) NULL,
	[Weight] [nvarchar](255) NULL,
	[PartnerID] [int] NULL,
	[Mobile] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebCategories]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebCategories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Image] [nvarchar](255) NULL,
	[Body] [ntext] NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[MetaKeywords] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[Status] [int] NULL,
	[Order] [int] NULL,
	[CType] [int] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[ParentID] [int] NULL,
 CONSTRAINT [PK_WebCategories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebConfigs]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebConfigs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Key] [varchar](50) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_WebConfigs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebContacts]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebContacts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Body] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Mobile] [nvarchar](255) NULL,
	[Address] [nvarchar](500) NULL,
	[CreatedDate] [date] NULL,
	[NgayBatDau] [datetime] NULL,
	[NgayKetThuc] [datetime] NULL,
	[LoaiDonHang] [int] NULL,
	[LoaiLienHe] [int] NULL,
	[WebModuleID] [int] NULL,
 CONSTRAINT [PK_WebContacts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebContentCategories]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebContentCategories](
	[WebCategoryID] [int] NOT NULL,
	[WebContentID] [int] NOT NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_WebContentCategories] PRIMARY KEY CLUSTERED 
(
	[WebCategoryID] ASC,
	[WebContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebContents]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebContents](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Image] [nvarchar](255) NULL,
	[Body] [ntext] NULL,
	[Link] [nvarchar](255) NULL,
	[WebModuleID] [int] NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[MetaKeywords] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[Status] [int] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[Order] [int] NULL,
	[UID] [nvarchar](255) NULL,
	[LinkVideo] [nvarchar](255) NULL,
	[Event] [datetime] NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[Icon] [nvarchar](255) NULL,
	[CountView] [decimal](18, 0) NULL,
	[PublishDate] [datetime] NULL,
 CONSTRAINT [PK_WebContents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebContentUploads]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebContentUploads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[FullPath] [nvarchar](255) NULL,
	[UID] [nvarchar](255) NULL,
	[FolderID] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[MimeType] [nvarchar](255) NULL,
 CONSTRAINT [PK_WebContentImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebModules]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebModules](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Body] [ntext] NULL,
	[Image] [nvarchar](255) NULL,
	[ParentID] [int] NULL,
	[ContentTypeID] [varchar](50) NULL,
	[URL] [nvarchar](255) NULL,
	[SeoTitle] [nvarchar](255) NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[MetaKeywords] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[Order] [int] NULL,
	[UID] [nvarchar](255) NULL,
	[IndexView] [nvarchar](255) NULL,
	[IndexLayout] [nvarchar](255) NULL,
	[PublishIndexView] [nvarchar](255) NULL,
	[PublishIndexLayout] [nvarchar](255) NULL,
	[PublishDetailView] [nvarchar](255) NULL,
	[PublishDetailLayout] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[SubQuerys] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[ShowOnMenu] [bit] NULL,
	[ShowOnAdmin] [bit] NULL,
	[Culture] [nvarchar](50) NULL,
	[Icon] [nvarchar](255) NULL,
	[CodeColor] [nvarchar](255) NULL,
	[ActiveArticle] [nvarchar](255) NULL,
	[Target] [nvarchar](255) NULL,
 CONSTRAINT [PK_WebModules] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[Title] [nvarchar](256) NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRedirects]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRedirects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[URL] [nvarchar](255) NULL,
	[WebModuleID] [int] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[TimeRedirect] [int] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_WebRedirects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebSimpleContents]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSimpleContents](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[Key] [nvarchar](255) NOT NULL,
	[Body] [ntext] NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[MetaKeywords] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[Culture] [nvarchar](50) NULL,
 CONSTRAINT [PK_WebSimpleContents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebSlides]    Script Date: 12/24/2020 6:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSlides](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Image] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[MetaTitle] [nvarchar](255) NULL,
	[MetaKeywords] [nvarchar](500) NULL,
	[MetaDescription] [nvarchar](500) NULL,
	[Status] [int] NULL,
	[Target] [varchar](50) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[Order] [int] NULL,
	[Culture] [nvarchar](50) NULL,
 CONSTRAINT [PK_WebSlides] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1035)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1036)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1037)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1038)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1039)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1040)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (3, 1041)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (4, 1040)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 2)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 5)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 6)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 7)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 8)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 9)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 13)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 14)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 15)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 16)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 20)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 21)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 22)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 23)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 24)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 25)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 26)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 27)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 28)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 29)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1030)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1031)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1032)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1033)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1034)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (5, 1035)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 1)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 9)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 14)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 15)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 16)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 20)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 21)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 22)
INSERT [dbo].[AccessAdminSiteRole] ([RoleId], [AdminSiteID]) VALUES (6, 23)
INSERT [dbo].[AccessAdminSites] ([UserId], [AdminSiteID]) VALUES (1, 1)
SET IDENTITY_INSERT [dbo].[AccessLogs] ON 

INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (1, N'Entity: Role, Item: 2: Administrators', CAST(N'2014-01-23T21:40:31.100' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (2, N'Entity: Role, Item: 2: Administrators', CAST(N'2014-01-23T21:40:41.570' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (3, N'Entity: Role, Item: 3: Tổng biên tập', CAST(N'2020-08-01T18:23:01.610' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (4, N'Entity: Role, Item: 4: Người viết bài', CAST(N'2020-08-01T18:23:10.050' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (5, N'Entity: Role, Item: 3: Quản trị chung', CAST(N'2020-12-04T18:18:40.517' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (6, N'Entity: Role, Item: 4: Nhân viên cửa hàng', CAST(N'2020-12-04T18:18:51.820' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (7, N'Entity: Role, Item: 3: Quản trị chung', CAST(N'2020-12-04T18:20:22.700' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (8, N'Entity: Role, Item: 3: Quản trị chung', CAST(N'2020-12-04T18:20:28.257' AS DateTime), N'1:admin', N'Edit')
INSERT [dbo].[AccessLogs] ([ID], [Title], [CreatedDate], [CreatedBy], [Action]) VALUES (9, N'Entity: Role, Item: 3: Quản trị chung', CAST(N'2020-12-10T10:14:30.543' AS DateTime), N'34:sparkquyn', N'Edit')
SET IDENTITY_INSERT [dbo].[AccessLogs] OFF
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 2, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 3, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 4, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 9, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 10, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 11, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 12, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 13, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 14, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 15, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 16, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 17, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 18, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 19, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 20, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 21, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 22, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 23, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 24, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 25, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 26, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 27, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 28, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 29, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 30, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 31, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 32, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 33, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 34, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 35, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 36, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 37, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 38, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 39, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 40, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 41, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 42, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 44, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 45, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 46, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 47, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 48, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 49, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 50, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 51, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 52, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 53, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 54, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 55, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 56, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 57, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 58, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 59, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 60, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 61, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 62, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 63, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 64, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 65, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 66, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 68, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 69, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 70, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 71, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 72, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 74, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 75, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 79, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 80, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 81, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 82, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 83, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 86, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 87, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 89, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 90, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 91, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 92, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 93, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 94, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 95, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 96, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 97, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 98, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (2, 99, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 2, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 3, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 4, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 9, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 10, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 11, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 12, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 13, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 14, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 15, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 16, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 17, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 18, 1, 1, 1, 1, 1)
GO
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 19, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 20, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 21, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 22, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 23, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 24, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 25, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 26, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 27, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 28, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 29, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 30, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 31, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 32, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 33, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 34, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 35, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 36, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 37, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 38, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 39, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 40, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 41, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 42, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 44, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 45, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 46, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 47, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 48, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 49, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 50, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 51, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 52, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 53, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 54, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 55, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 56, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 57, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 58, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 59, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 60, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 61, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 62, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 63, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 64, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 65, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 66, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 82, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 86, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 89, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 90, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 91, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 92, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 93, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 94, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (3, 95, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 1, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 2, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 3, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 4, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 9, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 10, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 11, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 12, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 13, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 14, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 15, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 16, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 17, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 18, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 19, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 20, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 21, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 22, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 23, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 24, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 25, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 26, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 27, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 28, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 29, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 30, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 31, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 32, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 33, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 34, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 35, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 36, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 37, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 38, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 39, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 40, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 41, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 42, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 44, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 45, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 46, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 47, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 48, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 49, 1, 1, 1, 1, 0)
GO
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 50, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 51, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 52, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 53, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 54, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 55, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 56, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 57, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 58, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 59, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 60, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 61, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 62, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 63, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 64, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 65, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 66, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 83, 1, 1, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 86, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 87, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 89, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 90, 0, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 91, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 92, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 93, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 94, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 95, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 96, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (4, 97, 1, 1, 1, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 2, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 3, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 4, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 9, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 10, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 11, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 12, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 13, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 14, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 15, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 16, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 17, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 18, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 19, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 20, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 21, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 22, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 23, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 24, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 25, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 26, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 27, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 28, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 29, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 30, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 31, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 32, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 33, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 34, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 35, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 36, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 37, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 38, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 39, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 40, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 41, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 42, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 44, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 45, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 46, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 47, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 48, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 49, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 50, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 51, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 52, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 53, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 54, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 55, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 56, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 57, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (5, 58, 1, 1, 1, 1, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 1, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 2, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 3, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 4, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 9, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 11, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 12, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 14, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 15, 1, 1, 1, 0, 1)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 17, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 18, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 22, 0, 0, 0, 0, 0)
GO
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 28, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 29, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 30, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 31, 1, 1, 1, 1, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 32, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 39, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 40, 1, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 41, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 49, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 50, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 51, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 52, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 53, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 54, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 55, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 56, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 57, 0, 0, 0, 0, 0)
INSERT [dbo].[AccessWebModuleRole] ([RoleId], [WebModuleID], [View], [Add], [Edit], [Delete], [Approve]) VALUES (6, 58, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[AdminSites] ON 

INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1, N'Trang chủ', NULL, N'/admin', NULL, N'Home', 1, N'<i class="fas fa-home " ></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1035, N'Phân quyền', NULL, N'/admin/role', NULL, NULL, 2, N'<i class="fas fa-user-tag"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1036, N'Chức năng khoá sổ', NULL, N'/admin/NoteBookKey', NULL, N'NoteBookKey', 8, N'<i class="fas fa-key"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1037, N'Danh mục cửa hàng', NULL, N'/admin/ShopCategory', NULL, N'ShopCategory', 4, N'<i class="fas fa-store"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1038, N'Danh mục khách hàng', NULL, N'/admin/CustomerCategory', NULL, N'CustomerCategory', 7, N'<i class="fas fa-user-tie"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1039, N'Danh mục nhà cung cấp', NULL, N'/admin/SupplierCategory', NULL, N'SupplierCategory', 6, N'<i class="fas fa-people-carry"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1040, N'Danh mục hàng hoá', NULL, N'/admin/CommodityCategory', NULL, N'CommodityCategory', 5, N'<i class="fas fa-box-open"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1041, N'Danh mục người dùng', NULL, N'/admin/user', NULL, N'User', 3, N'<i class="fas fa-user-alt"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1042, N'Giá niêm yết', NULL, N'/admin/ListedPrice', NULL, N'ListedPrice', 9, N'<i class="fas fa-dollar-sign"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1043, N'Giá bán', NULL, N'/admin/Price', NULL, N'Price', 10, N'<i class="fas fa-hand-holding-usd"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1044, N'Quản lý hoa hồng', NULL, N'/admin/CommissionManagement', NULL, N'CommissionManagement', 11, N'<i class="fas fa-funnel-dollar"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1046, N'Đơn nhập hàng', NULL, N'/admin/ImportOrdersParrent', NULL, N'ImportOrdersParrent', 12, N'<i class="fas fa-file-import"></i>')
INSERT [dbo].[AdminSites] ([ID], [Title], [Description], [Url], [ParentID], [AccessKey], [Order], [Img]) VALUES (1047, N'Cước Vận Chuyển', NULL, N'/admin/FreightPrices', NULL, N'FreightPrice', 13, N'<i class="fas fa-car"></i>')
SET IDENTITY_INSERT [dbo].[AdminSites] OFF
SET IDENTITY_INSERT [dbo].[AdvertisementPositions] ON 

INSERT [dbo].[AdvertisementPositions] ([ID], [UID], [Title], [Image], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'_adv_chi_tiet', N'Quảng cáo trong trang chi tiết', NULL, NULL, N'admin', CAST(N'2020-07-11T19:06:33.183' AS DateTime), N'admin', CAST(N'2020-07-11T19:06:33.183' AS DateTime))
INSERT [dbo].[AdvertisementPositions] ([ID], [UID], [Title], [Image], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'_adv_home_news', N'Quảng cáo Trang chủ - Danh sách tin', NULL, NULL, N'admin', CAST(N'2020-07-11T19:07:02.937' AS DateTime), N'admin', CAST(N'2020-07-11T19:07:02.937' AS DateTime))
INSERT [dbo].[AdvertisementPositions] ([ID], [UID], [Title], [Image], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'_banner_center_home', N'Banner giữa trang chủ', NULL, NULL, N'admin', CAST(N'2020-07-12T12:25:23.450' AS DateTime), N'admin', CAST(N'2020-07-12T12:25:23.450' AS DateTime))
INSERT [dbo].[AdvertisementPositions] ([ID], [UID], [Title], [Image], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'_adv_banner_home', N'Banner tại trang chủ', NULL, NULL, N'admin', CAST(N'2020-07-12T23:38:43.403' AS DateTime), N'admin', CAST(N'2020-07-12T23:38:43.403' AS DateTime))
INSERT [dbo].[AdvertisementPositions] ([ID], [UID], [Title], [Image], [Description], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'_adv_home_news_bottom', N'Quảng cáo Trang chủ - Danh sách tin (dưới facebook)', NULL, NULL, N'admin', CAST(N'2020-07-14T22:20:55.533' AS DateTime), N'admin', CAST(N'2020-07-14T22:20:55.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[AdvertisementPositions] OFF
SET IDENTITY_INSERT [dbo].[Advertisements] ON 

INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (18, N'Landmark', NULL, N'/uploads/072020/html__0011_Layer-35_4f188521.png', N'http://www.landmark72.com/', N'_self', N'admin', CAST(N'2020-07-11T19:08:16.820' AS DateTime), N'admin', CAST(N'2020-07-27T16:04:17.903' AS DateTime), 4, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (19, N'Kem', NULL, N'/uploads/072020/html__0010_Layer-38_f3607114.png', N'http://www.kidofoods.vn/kem/merino', N'_self', N'admin', CAST(N'2020-07-11T19:08:25.687' AS DateTime), N'admin', CAST(N'2020-07-27T16:04:51.930' AS DateTime), 4, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (20, N'Điện thoại', NULL, N'/uploads/072020/html__0009_Layer-39_e34979b8.png', N'https://www.samsung.com/vn/smartphones/galaxy-s20/models/', N'_self', N'admin', CAST(N'2020-07-11T19:08:32.963' AS DateTime), N'admin', CAST(N'2020-07-27T16:05:14.870' AS DateTime), 4, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (24, N'QC', NULL, N'/uploads/082020/4179.jpg_wh860_861e37d7.png', N'#', N'_self', N'admin', CAST(N'2020-07-12T13:23:06.350' AS DateTime), N'admin', CAST(N'2020-11-02T17:51:48.840' AS DateTime), 6, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (25, N'Banner trang chủ', NULL, N'/uploads/102020/banner2_13bcf4f0.jpg', N'#', N'_self', N'admin', CAST(N'2020-07-12T23:39:19.307' AS DateTime), N'admin', CAST(N'2020-10-08T15:49:06.913' AS DateTime), 7, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (28, N'Hồ sơ tư liệu', NULL, N'/uploads/072020/HSTL_7b2f91f2.png', N'/ho-so-tu-lieu-52', N'_self', N'admin', CAST(N'2020-07-17T11:25:48.577' AS DateTime), N'admin', CAST(N'2020-07-27T13:40:05.763' AS DateTime), 5, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (30, N'Liên hệ quảng cáo', NULL, N'/uploads/072020/lien he qc a Bach-02_39bba016.png', N'#', N'_self', N'admin', CAST(N'2020-07-17T11:43:36.557' AS DateTime), N'admin', CAST(N'2020-09-17T12:46:21.553' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (31, N'Bảo vệ môi trường trong xây dựng nông thôn mới', NULL, N'/uploads/072020/bvmt ntm-01_f99b999f.png', N'/bao-ve-moi-truong-trong-xay-dung-nong-thon-moi-54', N'_self', N'admin', CAST(N'2020-07-17T11:44:39.897' AS DateTime), N'admin', CAST(N'2020-07-27T16:08:58.493' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (32, N'Landmark 81', NULL, N'/uploads/072020/html__0011_Layer-35_4f188521.png', N'http://www.landmark72.com/', N'_self', N'admin', CAST(N'2020-07-17T11:45:29.230' AS DateTime), N'admin', CAST(N'2020-07-27T16:04:22.020' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (33, N'Kem', NULL, N'/uploads/072020/html__0010_Layer-38_f3607114.png', N'http://www.kidofoods.vn/kem/merino', N'_self', N'admin', CAST(N'2020-07-17T11:46:19.437' AS DateTime), N'admin', CAST(N'2020-07-27T16:04:48.227' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (34, N'Điện thoại', NULL, N'/uploads/072020/html__0009_Layer-39_e34979b8.png', N'https://www.samsung.com/vn/smartphones/galaxy-s20/models/', N'_self', N'admin', CAST(N'2020-07-17T11:47:19.743' AS DateTime), N'admin', CAST(N'2020-07-27T16:05:09.590' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (35, N'Sữa', NULL, N'/uploads/072020/html__0001_Layer-19_e9b6bc0.png', N'http://www.thmilk.vn/th-true-juice.html', N'_self', N'admin', CAST(N'2020-07-17T11:47:33.987' AS DateTime), N'admin', CAST(N'2020-07-27T16:05:46.940' AS DateTime), 8, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (36, N'Sữa', NULL, N'/uploads/072020/html__0001_Layer-19_e9b6bc0.png', N'http://www.thmilk.vn/th-true-juice.html', N'_self', N'admin', CAST(N'2020-07-17T11:51:26.757' AS DateTime), N'admin', CAST(N'2020-07-27T16:05:42.137' AS DateTime), 4, N'vi-VN', NULL, 1)
INSERT [dbo].[Advertisements] ([ID], [Title], [Description], [Media], [Link], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [AdvertisementPositionID], [Culture], [Video], [Status]) VALUES (40, N'Video QC', NULL, NULL, NULL, N'_self', N'admin', CAST(N'2020-09-17T12:46:56.737' AS DateTime), N'admin', CAST(N'2020-09-17T12:46:56.737' AS DateTime), 8, N'vi-VN', N'/uploads/file/092020/mov_bbb_f33b1bd9_87d1abec.mp4', 1)
SET IDENTITY_INSERT [dbo].[Advertisements] OFF
SET IDENTITY_INSERT [dbo].[CommissionManagement] ON 

INSERT [dbo].[CommissionManagement] ([ID], [TimeApply], [CustomerID], [ShopID], [Commission], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 3, 16, CAST(123.55 AS Decimal(10, 2)), N'1', 1, 1, CAST(N'2020-12-23T00:00:00.000' AS DateTime), 1, CAST(N'2020-12-21T18:38:36.807' AS DateTime))
INSERT [dbo].[CommissionManagement] ([ID], [TimeApply], [CustomerID], [ShopID], [Commission], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, CAST(N'2020-12-12T00:00:00.000' AS DateTime), 1, 13, CAST(7878.34 AS Decimal(10, 2)), N'SparkQuyn', 1, 1, CAST(N'2020-12-15T10:20:53.870' AS DateTime), 1, CAST(N'2020-12-21T15:42:56.133' AS DateTime))
INSERT [dbo].[CommissionManagement] ([ID], [TimeApply], [CustomerID], [ShopID], [Commission], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, CAST(N'2020-03-12T00:00:00.000' AS DateTime), NULL, NULL, CAST(1123.00 AS Decimal(10, 2)), NULL, 1, 1, CAST(N'2020-12-21T18:38:44.920' AS DateTime), 1, CAST(N'2020-12-22T10:36:19.163' AS DateTime))
SET IDENTITY_INSERT [dbo].[CommissionManagement] OFF
SET IDENTITY_INSERT [dbo].[CommodityCategory] ON 

INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'1a1', N'CommoditySpark', CAST(99.9900 AS Decimal(6, 4)), N'Sparkquyn', 1, 1, CAST(N'2016-12-10T16:06:45.170' AS DateTime), 1, CAST(N'2020-12-22T13:21:04.057' AS DateTime))
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, N'1', N'SparkQUynCommodity', CAST(6.4000 AS Decimal(6, 4)), N'1233', 0, 1, CAST(N'2020-12-04T16:48:10.857' AS DateTime), 0, CAST(N'2020-12-04T17:48:06.220' AS DateTime))
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, N'1aa', N'1113', CAST(3.0000 AS Decimal(6, 4)), N'4444', 1, 1, CAST(N'2020-12-04T16:48:26.773' AS DateTime), 1, CAST(N'2020-12-22T09:20:47.977' AS DateTime))
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (12, N'1aaa', N'QUANGTAMDUC1', CAST(10.0000 AS Decimal(6, 4)), N'SparkQuyn', 1, 1, CAST(N'2020-12-12T13:08:00.913' AS DateTime), 1, CAST(N'2020-12-22T09:20:55.903' AS DateTime))
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (13, N'25104', N'QUANGTAMDUC2', CAST(10.6400 AS Decimal(6, 4)), N'SparkQuyn', 1, 1, CAST(N'2020-12-12T13:09:28.273' AS DateTime), 1, CAST(N'2020-12-18T22:58:27.347' AS DateTime))
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (14, N'123444', N'QUANGTAMDUC', CAST(10.4300 AS Decimal(6, 4)), N'SparkQuyn', 0, 1, CAST(N'2020-12-12T13:10:25.390' AS DateTime), 0, NULL)
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (15, N'251033', N'QUANGTAMDUC', CAST(10.3400 AS Decimal(6, 4)), N'SparkQuyn', 0, 1, CAST(N'2020-12-12T14:00:32.587' AS DateTime), 0, NULL)
INSERT [dbo].[CommodityCategory] ([ID], [CommodityID], [CommodityName], [Tax], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (16, N'A1', N'11', CAST(99.0000 AS Decimal(6, 4)), NULL, 1, 1, CAST(N'2020-12-21T18:18:49.027' AS DateTime), 0, NULL)
SET IDENTITY_INSERT [dbo].[CommodityCategory] OFF
INSERT [dbo].[ContentTypes] ([ID], [Title], [Description], [Controller], [Order], [Entity]) VALUES (N'Article', N'Bản tin', NULL, N'Article', 4, NULL)
INSERT [dbo].[ContentTypes] ([ID], [Title], [Description], [Controller], [Order], [Entity]) VALUES (N'Contact', N'Contact', NULL, N'Contact', 7, NULL)
INSERT [dbo].[ContentTypes] ([ID], [Title], [Description], [Controller], [Order], [Entity]) VALUES (N'Empty', N'Empty', NULL, N'Empty', 1, NULL)
INSERT [dbo].[ContentTypes] ([ID], [Title], [Description], [Controller], [Order], [Entity]) VALUES (N'Home', N'Trang chủ', NULL, N'Home', 2, NULL)
INSERT [dbo].[ContentTypes] ([ID], [Title], [Description], [Controller], [Order], [Entity]) VALUES (N'OnePage', N'Một trang', NULL, N'OnePage', 5, NULL)
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([ID], [Title], [IsoCode]) VALUES (2, N'Việt Nam', N'vi-VN')
INSERT [dbo].[Countries] ([ID], [Title], [IsoCode]) VALUES (8, N'United States', N'en-US')
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[CustomerCategory] ON 

INSERT [dbo].[CustomerCategory] ([ID], [CustomerID], [CustomerName], [TaxCode], [CustomerAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'1', N'Công cổ phần cầu đường số 1', N'10000', N'31 Thọ Tháp', N'0987654321', N'NiI400', 1, 1, CAST(N'2020-12-04T15:01:57.240' AS DateTime), 1, CAST(N'2020-12-20T11:53:31.467' AS DateTime))
INSERT [dbo].[CustomerCategory] ([ID], [CustomerID], [CustomerName], [TaxCode], [CustomerAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, N'11', N'Công ty số 2', N'132', NULL, N'0987654321', N'NiI4', 1, 1, CAST(N'2020-12-04T15:02:40.103' AS DateTime), 1, CAST(N'2020-12-22T09:44:27.763' AS DateTime))
INSERT [dbo].[CustomerCategory] ([ID], [CustomerID], [CustomerName], [TaxCode], [CustomerAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, N'2', N'SparkQuyn', N'251099', N'Spark', N'0987654321', N'5556', 1, 34, CAST(N'2020-12-04T17:54:27.927' AS DateTime), 34, CAST(N'2020-12-07T18:40:14.773' AS DateTime))
INSERT [dbo].[CustomerCategory] ([ID], [CustomerID], [CustomerName], [TaxCode], [CustomerAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, N'2510', N'Quang Tam Duc 2', N'10101', N'Mặt trăng', NULL, N'SparkQuyn', 1, 34, CAST(N'2020-12-07T18:42:37.120' AS DateTime), 1, CAST(N'2020-12-22T09:54:30.560' AS DateTime))
SET IDENTITY_INSERT [dbo].[CustomerCategory] OFF
SET IDENTITY_INSERT [dbo].[DealDetail] ON 

INSERT [dbo].[DealDetail] ([ID], [ParentID], [Date], [ShopID], [Description], [DiscountAmount], [FreightPrice], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 2, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 13, N'123                                                                                                                             ', CAST(123.00 AS Numeric(10, 2)), CAST(123.00 AS Numeric(10, 2)), 1, 1, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 1, CAST(N'2020-10-12T00:00:00.000' AS DateTime))
INSERT [dbo].[DealDetail] ([ID], [ParentID], [Date], [ShopID], [Description], [DiscountAmount], [FreightPrice], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, 3, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 13, N'123                                                                                                                             ', CAST(123.00 AS Numeric(10, 2)), CAST(123.00 AS Numeric(10, 2)), 1, 1, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 1, CAST(N'2020-10-12T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[DealDetail] OFF
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'001', N'Quận Ba Đình', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'002', N'Quận Hoàn Kiếm', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'003', N'Quận Tây Hồ', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'004', N'Quận Long Biên', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'005', N'Quận Cầu Giấy', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'006', N'Quận Đống Đa', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'007', N'Quận Hai Bà Trưng', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'008', N'Quận Hoàng Mai', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'009', N'Quận Thanh Xuân', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'016', N'Huyện Sóc Sơn', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'017', N'Huyện Đông Anh', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'018', N'Huyện Gia Lâm', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'019', N'Quận Nam Từ Liêm', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'020', N'Huyện Thanh Trì', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'021', N'Quận Bắc Từ Liêm', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'024', N'Thành phố Hà Giang', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'026', N'Huyện Đồng Văn', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'027', N'Huyện Mèo Vạc', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'028', N'Huyện Yên Minh', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'029', N'Huyện Quản Bạ', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'030', N'Huyện Vị Xuyên', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'031', N'Huyện Bắc Mê', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'032', N'Huyện Hoàng Su Phì', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'033', N'Huyện Xín Mần', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'034', N'Huyện Bắc Quang', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'035', N'Huyện Quang Bình', N'02')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'040', N'Thành phố Cao Bằng', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'042', N'Huyện Bảo Lâm', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'043', N'Huyện Bảo Lạc', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'044', N'Huyện Thông Nông', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'045', N'Huyện Hà Quảng', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'046', N'Huyện Trà Lĩnh', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'047', N'Huyện Trùng Khánh', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'048', N'Huyện Hạ Lang', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'049', N'Huyện Quảng Uyên', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'050', N'Huyện Phục Hòa', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'051', N'Huyện Hòa An', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'052', N'Huyện Nguyên Bình', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'053', N'Huyện Thạch An', N'04')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'058', N'Thành Phố Bắc Kạn', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'060', N'Huyện Pác Nặm', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'061', N'Huyện Ba Bể', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'062', N'Huyện Ngân Sơn', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'063', N'Huyện Bạch Thông', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'064', N'Huyện Chợ Đồn', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'065', N'Huyện Chợ Mới', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'066', N'Huyện Na Rì', N'06')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'070', N'Thành phố Tuyên Quang', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'071', N'Huyện Lâm Bình', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'072', N'Huyện Na Hang', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'073', N'Huyện Chiêm Hóa', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'074', N'Huyện Hàm Yên', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'075', N'Huyện Yên Sơn', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'076', N'Huyện Sơn Dương', N'08')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'080', N'Thành phố Lào Cai', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'082', N'Huyện Bát Xát', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'083', N'Huyện Mường Khương', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'084', N'Huyện Si Ma Cai', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'085', N'Huyện Bắc Hà', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'086', N'Huyện Bảo Thắng', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'087', N'Huyện Bảo Yên', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'088', N'Huyện Sa Pa', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'089', N'Huyện Văn Bàn', N'10')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'094', N'Thành phố Điện Biên Phủ', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'095', N'Thị Xã Mường Lay', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'096', N'Huyện Mường Nhé', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'097', N'Huyện Mường Chà', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'098', N'Huyện Tủa Chùa', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'099', N'Huyện Tuần Giáo', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'100', N'Huyện Điện Biên', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'101', N'Huyện Điện Biên Đông', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'102', N'Huyện Mường Ảng', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'103', N'Huyện Nậm Pồ', N'11')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'105', N'Thành phố Lai Châu', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'106', N'Huyện Tam Đường', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'107', N'Huyện Mường Tè', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'108', N'Huyện Sìn Hồ', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'109', N'Huyện Phong Thổ', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'110', N'Huyện Than Uyên', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'111', N'Huyện Tân Uyên', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'112', N'Huyện Nậm Nhùn', N'12')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'116', N'Thành phố Sơn La', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'118', N'Huyện Quỳnh Nhai', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'119', N'Huyện Thuận Châu', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'120', N'Huyện Mường La', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'121', N'Huyện Bắc Yên', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'122', N'Huyện Phù Yên', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'123', N'Huyện Mộc Châu', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'124', N'Huyện Yên Châu', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'125', N'Huyện Mai Sơn', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'126', N'Huyện Sông Mã', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'127', N'Huyện Sốp Cộp', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'128', N'Huyện Vân Hồ', N'14')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'132', N'Thành phố Yên Bái', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'133', N'Thị xã Nghĩa Lộ', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'135', N'Huyện Lục Yên', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'136', N'Huyện Văn Yên', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'137', N'Huyện Mù Căng Chải', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'138', N'Huyện Trấn Yên', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'139', N'Huyện Trạm Tấu', N'15')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'140', N'Huyện Văn Chấn', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'141', N'Huyện Yên Bình', N'15')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'148', N'Thành phố Hòa Bình', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'150', N'Huyện Đà Bắc', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'151', N'Huyện Kỳ Sơn', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'152', N'Huyện Lương Sơn', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'153', N'Huyện Kim Bôi', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'154', N'Huyện Cao Phong', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'155', N'Huyện Tân Lạc', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'156', N'Huyện Mai Châu', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'157', N'Huyện Lạc Sơn', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'158', N'Huyện Yên Thủy', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'159', N'Huyện Lạc Thủy', N'17')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'164', N'Thành phố Thái Nguyên', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'165', N'Thành phố Sông Công', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'167', N'Huyện Định Hóa', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'168', N'Huyện Phú Lương', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'169', N'Huyện Đồng Hỷ', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'170', N'Huyện Võ Nhai', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'171', N'Huyện Đại Từ', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'172', N'Thị xã Phổ Yên', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'173', N'Huyện Phú Bình', N'19')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'178', N'Thành phố Lạng Sơn', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'180', N'Huyện Tràng Định', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'181', N'Huyện Bình Gia', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'182', N'Huyện Văn Lãng', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'183', N'Huyện Cao Lộc', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'184', N'Huyện Văn Quan', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'185', N'Huyện Bắc Sơn', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'186', N'Huyện Hữu Lũng', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'187', N'Huyện Chi Lăng', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'188', N'Huyện Lộc Bình', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'189', N'Huyện Đình Lập', N'20')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'193', N'Thành phố Hạ Long', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'194', N'Thành phố Móng Cái', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'195', N'Thành phố Cẩm Phả', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'196', N'Thành phố Uông Bí', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'198', N'Huyện Bình Liêu', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'199', N'Huyện Tiên Yên', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'200', N'Huyện Đầm Hà', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'201', N'Huyện Hải Hà', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'202', N'Huyện Ba Chẽ', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'203', N'Huyện Vân Đồn', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'204', N'Huyện Hoành Bồ', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'205', N'Thị xã Đông Triều', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'206', N'Thị xã Quảng Yên', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'207', N'Huyện Cô Tô', N'22')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'213', N'Thành phố Bắc Giang', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'215', N'Huyện Yên Thế', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'216', N'Huyện Tân Yên', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'217', N'Huyện Lạng Giang', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'218', N'Huyện Lục Nam', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'219', N'Huyện Lục Ngạn', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'220', N'Huyện Sơn Động', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'221', N'Huyện Yên Dũng', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'222', N'Huyện Việt Yên', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'223', N'Huyện Hiệp Hòa', N'24')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'227', N'Thành phố Việt Trì', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'228', N'Thị xã Phú Thọ', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'230', N'Huyện Đoan Hùng', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'231', N'Huyện Hạ Hòa', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'232', N'Huyện Thanh Ba', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'233', N'Huyện Phù Ninh', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'234', N'Huyện Yên Lập', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'235', N'Huyện Cẩm Khê', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'236', N'Huyện Tam Nông', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'237', N'Huyện Lâm Thao', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'238', N'Huyện Thanh Sơn', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'239', N'Huyện Thanh Thuỷ', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'240', N'Huyện Tân Sơn', N'25')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'243', N'Thành phố Vĩnh Yên', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'244', N'Thị xã Phúc Yên', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'246', N'Huyện Lập Thạch', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'247', N'Huyện Tam Dương', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'248', N'Huyện Tam Đảo', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'249', N'Huyện Bình Xuyên', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'250', N'Huyện Mê Linh', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'251', N'Huyện Yên Lạc', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'252', N'Huyện Vĩnh Tường', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'253', N'Huyện Sông Lô', N'26')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'256', N'Thành phố Bắc Ninh', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'258', N'Huyện Yên Phong', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'259', N'Huyện Quế Võ', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'260', N'Huyện Tiên Du', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'261', N'Thị xã Từ Sơn', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'262', N'Huyện Thuận Thành', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'263', N'Huyện Gia Bình', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'264', N'Huyện Lương Tài', N'27')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'268', N'Quận Hà Đông', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'269', N'Thị xã Sơn Tây', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'271', N'Huyện Ba Vì', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'272', N'Huyện Phúc Thọ', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'273', N'Huyện Đan Phượng', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'274', N'Huyện Hoài Đức', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'275', N'Huyện Quốc Oai', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'276', N'Huyện Thạch Thất', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'277', N'Huyện Chương Mỹ', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'278', N'Huyện Thanh Oai', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'279', N'Huyện Thường Tín', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'280', N'Huyện Phú Xuyên', N'01')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'281', N'Huyện Ứng Hòa', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'282', N'Huyện Mỹ Đức', N'01')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'288', N'Thành phố Hải Dương', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'290', N'Thị xã Chí Linh', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'291', N'Huyện Nam Sách', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'292', N'Huyện Kinh Môn', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'293', N'Huyện Kim Thành', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'294', N'Huyện Thanh Hà', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'295', N'Huyện Cẩm Giàng', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'296', N'Huyện Bình Giang', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'297', N'Huyện Gia Lộc', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'298', N'Huyện Tứ Kỳ', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'299', N'Huyện Ninh Giang', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'300', N'Huyện Thanh Miện', N'30')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'303', N'Quận Hồng Bàng', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'304', N'Quận Ngô Quyền', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'305', N'Quận Lê Chân', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'306', N'Quận Hải An', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'307', N'Quận Kiến An', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'308', N'Quận Đồ Sơn', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'309', N'Quận Dương Kinh', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'311', N'Huyện Thủy Nguyên', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'312', N'Huyện An Dương', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'313', N'Huyện An Lão', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'314', N'Huyện Kiến Thuỵ', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'315', N'Huyện Tiên Lãng', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'316', N'Huyện Vĩnh Bảo', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'317', N'Huyện Cát Hải', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'318', N'Huyện Bạch Long Vĩ', N'31')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'323', N'Thành phố Hưng Yên', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'325', N'Huyện Văn Lâm', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'326', N'Huyện Văn Giang', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'327', N'Huyện Yên Mỹ', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'328', N'Huyện Mỹ Hào', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'329', N'Huyện Ân Thi', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'330', N'Huyện Khoái Châu', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'331', N'Huyện Kim Động', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'332', N'Huyện Tiên Lữ', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'333', N'Huyện Phù Cừ', N'33')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'336', N'Thành phố Thái Bình', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'338', N'Huyện Quỳnh Phụ', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'339', N'Huyện Hưng Hà', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'340', N'Huyện Đông Hưng', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'341', N'Huyện Thái Thụy', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'342', N'Huyện Tiền Hải', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'343', N'Huyện Kiến Xương', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'344', N'Huyện Vũ Thư', N'34')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'347', N'Thành phố Phủ Lý', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'349', N'Huyện Duy Tiên', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'350', N'Huyện Kim Bảng', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'351', N'Huyện Thanh Liêm', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'352', N'Huyện Bình Lục', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'353', N'Huyện Lý Nhân', N'35')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'356', N'Thành phố Nam Định', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'358', N'Huyện Mỹ Lộc', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'359', N'Huyện Vụ Bản', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'360', N'Huyện Ý Yên', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'361', N'Huyện Nghĩa Hưng', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'362', N'Huyện Nam Trực', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'363', N'Huyện Trực Ninh', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'364', N'Huyện Xuân Trường', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'365', N'Huyện Giao Thủy', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'366', N'Huyện Hải Hậu', N'36')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'369', N'Thành phố Ninh Bình', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'370', N'Thành phố Tam Điệp', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'372', N'Huyện Nho Quan', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'373', N'Huyện Gia Viễn', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'374', N'Huyện Hoa Lư', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'375', N'Huyện Yên Khánh', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'376', N'Huyện Kim Sơn', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'377', N'Huyện Yên Mô', N'37')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'380', N'Thành phố Thanh Hóa', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'381', N'Thị xã Bỉm Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'382', N'Thành phố Sầm Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'384', N'Huyện Mường Lát', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'385', N'Huyện Quan Hóa', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'386', N'Huyện Bá Thước', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'387', N'Huyện Quan Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'388', N'Huyện Lang Chánh', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'389', N'Huyện Ngọc Lặc', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'390', N'Huyện Cẩm Thủy', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'391', N'Huyện Thạch Thành', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'392', N'Huyện Hà Trung', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'393', N'Huyện Vĩnh Lộc', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'394', N'Huyện Yên Định', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'395', N'Huyện Thọ Xuân', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'396', N'Huyện Thường Xuân', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'397', N'Huyện Triệu Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'398', N'Huyện Thiệu Hóa', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'399', N'Huyện Hoằng Hóa', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'400', N'Huyện Hậu Lộc', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'401', N'Huyện Nga Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'402', N'Huyện Như Xuân', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'403', N'Huyện Như Thanh', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'404', N'Huyện Nông Cống', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'405', N'Huyện Đông Sơn', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'406', N'Huyện Quảng Xương', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'407', N'Huyện Tĩnh Gia', N'38')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'412', N'Thành phố Vinh', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'413', N'Thị xã Cửa Lò', N'40')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'414', N'Thị xã Thái Hòa', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'415', N'Huyện Quế Phong', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'416', N'Huyện Quỳ Châu', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'417', N'Huyện Kỳ Sơn', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'418', N'Huyện Tương Dương', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'419', N'Huyện Nghĩa Đàn', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'420', N'Huyện Quỳ Hợp', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'421', N'Huyện Quỳnh Lưu', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'422', N'Huyện Con Cuông', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'423', N'Huyện Tân Kỳ', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'424', N'Huyện Anh Sơn', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'425', N'Huyện Diễn Châu', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'426', N'Huyện Yên Thành', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'427', N'Huyện Đô Lương', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'428', N'Huyện Thanh Chương', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'429', N'Huyện Nghi Lộc', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'430', N'Huyện Nam Đàn', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'431', N'Huyện Hưng Nguyên', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'432', N'Thị xã Hoàng Mai', N'40')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'436', N'Thành phố Hà Tĩnh', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'437', N'Thị xã Hồng Lĩnh', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'439', N'Huyện Hương Sơn', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'440', N'Huyện Đức Thọ', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'441', N'Huyện Vũ Quang', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'442', N'Huyện Nghi Xuân', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'443', N'Huyện Can Lộc', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'444', N'Huyện Hương Khê', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'445', N'Huyện Thạch Hà', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'446', N'Huyện Cẩm Xuyên', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'447', N'Huyện Kỳ Anh', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'448', N'Huyện Lộc Hà', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'449', N'Thị xã Kỳ Anh', N'42')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'450', N'Thành Phố Đồng Hới', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'452', N'Huyện Minh Hóa', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'453', N'Huyện Tuyên Hóa', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'454', N'Huyện Quảng Trạch', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'455', N'Huyện Bố Trạch', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'456', N'Huyện Quảng Ninh', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'457', N'Huyện Lệ Thủy', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'458', N'Thị xã Ba Đồn', N'44')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'461', N'Thành phố Đông Hà', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'462', N'Thị xã Quảng Trị', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'464', N'Huyện Vĩnh Linh', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'465', N'Huyện Hướng Hóa', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'466', N'Huyện Gio Linh', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'467', N'Huyện Đakrông', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'468', N'Huyện Cam Lộ', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'469', N'Huyện Triệu Phong', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'470', N'Huyện Hải Lăng', N'45')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'474', N'Thành phố Huế', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'476', N'Huyện Phong Điền', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'477', N'Huyện Quảng Điền', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'478', N'Huyện Phú Vang', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'479', N'Thị xã Hương Thủy', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'480', N'Thị xã Hương Trà', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'481', N'Huyện A Lưới', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'482', N'Huyện Phú Lộc', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'483', N'Huyện Nam Đông', N'46')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'490', N'Quận Liên Chiểu', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'491', N'Quận Thanh Khê', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'492', N'Quận Hải Châu', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'493', N'Quận Sơn Trà', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'494', N'Quận Ngũ Hành Sơn', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'495', N'Quận Cẩm Lệ', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'497', N'Huyện Hòa Vang', N'48')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'502', N'Thành phố Tam Kỳ', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'503', N'Thành phố Hội An', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'504', N'Huyện Tây Giang', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'505', N'Huyện Đông Giang', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'506', N'Huyện Đại Lộc', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'507', N'Thị xã Điện Bàn', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'508', N'Huyện Duy Xuyên', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'509', N'Huyện Quế Sơn', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'510', N'Huyện Nam Giang', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'511', N'Huyện Phước Sơn', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'512', N'Huyện Hiệp Đức', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'513', N'Huyện Thăng Bình', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'514', N'Huyện Tiên Phước', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'515', N'Huyện Bắc Trà My', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'516', N'Huyện Nam Trà My', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'517', N'Huyện Núi Thành', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'518', N'Huyện Phú Ninh', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'519', N'Huyện Nông Sơn', N'49')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'522', N'Thành phố Quảng Ngãi', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'524', N'Huyện Bình Sơn', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'525', N'Huyện Trà Bồng', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'526', N'Huyện Tây Trà', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'527', N'Huyện Sơn Tịnh', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'528', N'Huyện Tư Nghĩa', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'529', N'Huyện Sơn Hà', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'530', N'Huyện Sơn Tây', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'531', N'Huyện Minh Long', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'532', N'Huyện Nghĩa Hành', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'533', N'Huyện Mộ Đức', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'534', N'Huyện Đức Phổ', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'535', N'Huyện Ba Tơ', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'536', N'Huyện Lý Sơn', N'51')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'540', N'Thành phố Quy Nhơn', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'542', N'Huyện An Lão', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'543', N'Huyện Hoài Nhơn', N'52')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'544', N'Huyện Hoài Ân', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'545', N'Huyện Phù Mỹ', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'546', N'Huyện Vĩnh Thạnh', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'547', N'Huyện Tây Sơn', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'548', N'Huyện Phù Cát', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'549', N'Thị xã An Nhơn', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'550', N'Huyện Tuy Phước', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'551', N'Huyện Vân Canh', N'52')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'555', N'Thành phố Tuy Hòa', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'557', N'Thị xã Sông Cầu', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'558', N'Huyện Đồng Xuân', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'559', N'Huyện Tuy An', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'560', N'Huyện Sơn Hòa', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'561', N'Huyện Sông Hinh', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'562', N'Huyện Tây Hòa', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'563', N'Huyện Phú Hòa', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'564', N'Huyện Đông Hòa', N'54')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'568', N'Thành phố Nha Trang', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'569', N'Thành phố Cam Ranh', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'570', N'Huyện Cam Lâm', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'571', N'Huyện Vạn Ninh', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'572', N'Thị xã Ninh Hòa', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'573', N'Huyện Khánh Vĩnh', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'574', N'Huyện Diên Khánh', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'575', N'Huyện Khánh Sơn', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'576', N'Huyện Trường Sa', N'56')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'582', N'Thành phố Phan Rang-Tháp Chàm', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'584', N'Huyện Bác Ái', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'585', N'Huyện Ninh Sơn', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'586', N'Huyện Ninh Hải', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'587', N'Huyện Ninh Phước', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'588', N'Huyện Thuận Bắc', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'589', N'Huyện Thuận Nam', N'58')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'593', N'Thành phố Phan Thiết', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'594', N'Thị xã La Gi', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'595', N'Huyện Tuy Phong', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'596', N'Huyện Bắc Bình', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'597', N'Huyện Hàm Thuận Bắc', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'598', N'Huyện Hàm Thuận Nam', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'599', N'Huyện Tánh Linh', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'600', N'Huyện Đức Linh', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'601', N'Huyện Hàm Tân', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'602', N'Huyện Phú Quí', N'60')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'608', N'Thành phố Kon Tum', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'610', N'Huyện Đắk Glei', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'611', N'Huyện Ngọc Hồi', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'612', N'Huyện Đắk Tô', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'613', N'Huyện Kon Plông', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'614', N'Huyện Kon Rẫy', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'615', N'Huyện Đắk Hà', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'616', N'Huyện Sa Thầy', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'617', N'Huyện Tu Mơ Rông', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'618', N'Huyện Ia HDrai', N'62')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'622', N'Thành phố Pleiku', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'623', N'Thị xã An Khê', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'624', N'Thị xã Ayun Pa', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'625', N'Huyện KBang', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'626', N'Huyện Đăk Đoa', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'627', N'Huyện Chư Păh', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'628', N'Huyện Ia Grai', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'629', N'Huyện Mang Yang', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'630', N'Huyện Kông Chro', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'631', N'Huyện Đức Cơ', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'632', N'Huyện Chư Prông', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'633', N'Huyện Chư Sê', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'634', N'Huyện Đăk Pơ', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'635', N'Huyện Ia Pa', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'637', N'Huyện Krông Pa', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'638', N'Huyện Phú Thiện', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'639', N'Huyện Chư Pưh', N'64')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'643', N'Thành phố Buôn Ma Thuột', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'644', N'Thị Xã Buôn Hồ', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'645', N'Huyện Ea Hleo', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'646', N'Huyện Ea Súp', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'647', N'Huyện Buôn Đôn', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'648', N'Huyện Cư Mgar', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'649', N'Huyện Krông Búk', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'650', N'Huyện Krông Năng', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'651', N'Huyện Ea Kar', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'652', N'Huyện M Đrắk', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'653', N'Huyện Krông Bông', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'654', N'Huyện Krông Pắc', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'655', N'Huyện Krông A Na', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'656', N'Huyện Lắk', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'657', N'Huyện Cư Kuin', N'66')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'660', N'Thị xã Gia Nghĩa', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'661', N'Huyện Đăk Glong', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'662', N'Huyện Cư Jút', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'663', N'Huyện Đắk Mil', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'664', N'Huyện Krông Nô', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'665', N'Huyện Đắk Song', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'666', N'Huyện Đắk R Lấp', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'667', N'Huyện Tuy Đức', N'67')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'672', N'Thành phố Đà Lạt', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'673', N'Thành phố Bảo Lộc', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'674', N'Huyện Đam Rông', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'675', N'Huyện Lạc Dương', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'676', N'Huyện Lâm Hà', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'677', N'Huyện Đơn Dương', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'678', N'Huyện Đức Trọng', N'68')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'679', N'Huyện Di Linh', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'680', N'Huyện Bảo Lâm', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'681', N'Huyện Đạ Huoai', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'682', N'Huyện Đạ Tẻh', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'683', N'Huyện Cát Tiên', N'68')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'688', N'Thị xã Phước Long', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'689', N'Thị xã Đồng Xoài', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'690', N'Thị xã Bình Long', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'691', N'Huyện Bù Gia Mập', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'692', N'Huyện Lộc Ninh', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'693', N'Huyện Bù Đốp', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'694', N'Huyện Hớn Quản', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'695', N'Huyện Đồng Phú', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'696', N'Huyện Bù Đăng', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'697', N'Huyện Chơn Thành', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'698', N'Huyện Phú Riềng', N'70')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'703', N'Thành phố Tây Ninh', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'705', N'Huyện Tân Biên', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'706', N'Huyện Tân Châu', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'707', N'Huyện Dương Minh Châu', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'708', N'Huyện Châu Thành', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'709', N'Huyện Hòa Thành', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'710', N'Huyện Gò Dầu', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'711', N'Huyện Bến Cầu', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'712', N'Huyện Trảng Bàng', N'72')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'718', N'Thành phố Thủ Dầu Một', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'719', N'Huyện Bàu Bàng', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'720', N'Huyện Dầu Tiếng', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'721', N'Thị xã Bến Cát', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'722', N'Huyện Phú Giáo', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'723', N'Thị xã Tân Uyên', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'724', N'Thị xã Dĩ An', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'725', N'Thị xã Thuận An', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'726', N'Huyện Bắc Tân Uyên', N'74')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'731', N'Thành phố Biên Hòa', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'732', N'Thị xã Long Khánh', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'734', N'Huyện Tân Phú', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'735', N'Huyện Vĩnh Cửu', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'736', N'Huyện Định Quán', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'737', N'Huyện Trảng Bom', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'738', N'Huyện Thống Nhất', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'739', N'Huyện Cẩm Mỹ', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'740', N'Huyện Long Thành', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'741', N'Huyện Xuân Lộc', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'742', N'Huyện Nhơn Trạch', N'75')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'747', N'Thành phố Vũng Tàu', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'748', N'Thành phố Bà Rịa', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'750', N'Huyện Châu Đức', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'751', N'Huyện Xuyên Mộc', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'752', N'Huyện Long Điền', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'753', N'Huyện Đất Đỏ', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'754', N'Huyện Tân Thành', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'755', N'Huyện Côn Đảo', N'77')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'760', N'Quận 1', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'761', N'Quận 12', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'762', N'Quận Thủ Đức', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'763', N'Quận 9', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'764', N'Quận Gò Vấp', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'765', N'Quận Bình Thạnh', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'766', N'Quận Tân Bình', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'767', N'Quận Tân Phú', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'768', N'Quận Phú Nhuận', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'769', N'Quận 2', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'770', N'Quận 3', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'771', N'Quận 10', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'772', N'Quận 11', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'773', N'Quận 4', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'774', N'Quận 5', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'775', N'Quận 6', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'776', N'Quận 8', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'777', N'Quận Bình Tân', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'778', N'Quận 7', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'783', N'Huyện Củ Chi', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'784', N'Huyện Hóc Môn', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'785', N'Huyện Bình Chánh', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'786', N'Huyện Nhà Bè', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'787', N'Huyện Cần Giờ', N'79')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'794', N'Thành phố Tân An', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'795', N'Thị xã Kiến Tường', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'796', N'Huyện Tân Hưng', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'797', N'Huyện Vĩnh Hưng', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'798', N'Huyện Mộc Hóa', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'799', N'Huyện Tân Thạnh', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'800', N'Huyện Thạnh Hóa', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'801', N'Huyện Đức Huệ', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'802', N'Huyện Đức Hòa', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'803', N'Huyện Bến Lức', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'804', N'Huyện Thủ Thừa', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'805', N'Huyện Tân Trụ', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'806', N'Huyện Cần Đước', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'807', N'Huyện Cần Giuộc', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'808', N'Huyện Châu Thành', N'80')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'815', N'Thành phố Mỹ Tho', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'816', N'Thị xã Gò Công', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'817', N'Thị xã Cai Lậy', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'818', N'Huyện Tân Phước', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'819', N'Huyện Cái Bè', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'820', N'Huyện Cai Lậy', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'821', N'Huyện Châu Thành', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'822', N'Huyện Chợ Gạo', N'82')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'823', N'Huyện Gò Công Tây', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'824', N'Huyện Gò Công Đông', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'825', N'Huyện Tân Phú Đông', N'82')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'829', N'Thành phố Bến Tre', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'831', N'Huyện Châu Thành', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'832', N'Huyện Chợ Lách', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'833', N'Huyện Mỏ Cày Nam', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'834', N'Huyện Giồng Trôm', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'835', N'Huyện Bình Đại', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'836', N'Huyện Ba Tri', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'837', N'Huyện Thạnh Phú', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'838', N'Huyện Mỏ Cày Bắc', N'83')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'842', N'Thành phố Trà Vinh', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'844', N'Huyện Càng Long', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'845', N'Huyện Cầu Kè', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'846', N'Huyện Tiểu Cần', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'847', N'Huyện Châu Thành', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'848', N'Huyện Cầu Ngang', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'849', N'Huyện Trà Cú', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'850', N'Huyện Duyên Hải', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'851', N'Thị xã Duyên Hải', N'84')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'855', N'Thành phố Vĩnh Long', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'857', N'Huyện Long Hồ', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'858', N'Huyện Mang Thít', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'859', N'Huyện Vũng Liêm', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'860', N'Huyện Tam Bình', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'861', N'Thị xã Bình Minh', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'862', N'Huyện Trà Ôn', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'863', N'Huyện Bình Tân', N'86')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'866', N'Thành phố Cao Lãnh', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'867', N'Thành phố Sa Đéc', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'868', N'Thị xã Hồng Ngự', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'869', N'Huyện Tân Hồng', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'870', N'Huyện Hồng Ngự', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'871', N'Huyện Tam Nông', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'872', N'Huyện Tháp Mười', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'873', N'Huyện Cao Lãnh', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'874', N'Huyện Thanh Bình', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'875', N'Huyện Lấp Vò', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'876', N'Huyện Lai Vung', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'877', N'Huyện Châu Thành', N'87')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'883', N'Thành phố Long Xuyên', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'884', N'Thành phố Châu Đốc', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'886', N'Huyện An Phú', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'887', N'Thị xã Tân Châu', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'888', N'Huyện Phú Tân', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'889', N'Huyện Châu Phú', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'890', N'Huyện Tịnh Biên', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'891', N'Huyện Tri Tôn', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'892', N'Huyện Châu Thành', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'893', N'Huyện Chợ Mới', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'894', N'Huyện Thoại Sơn', N'89')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'899', N'Thành phố Rạch Giá', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'900', N'Thị xã Hà Tiên', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'902', N'Huyện Kiên Lương', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'903', N'Huyện Hòn Đất', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'904', N'Huyện Tân Hiệp', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'905', N'Huyện Châu Thành', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'906', N'Huyện Giồng Riềng', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'907', N'Huyện Gò Quao', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'908', N'Huyện An Biên', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'909', N'Huyện An Minh', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'910', N'Huyện Vĩnh Thuận', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'911', N'Huyện Phú Quốc', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'912', N'Huyện Kiên Hải', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'913', N'Huyện U Minh Thượng', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'914', N'Huyện Giang Thành', N'91')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'916', N'Quận Ninh Kiều', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'917', N'Quận Ô Môn', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'918', N'Quận Bình Thuỷ', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'919', N'Quận Cái Răng', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'923', N'Quận Thốt Nốt', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'924', N'Huyện Vĩnh Thạnh', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'925', N'Huyện Cờ Đỏ', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'926', N'Huyện Phong Điền', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'927', N'Huyện Thới Lai', N'92')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'930', N'Thành phố Vị Thanh', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'931', N'Thị xã Ngã Bảy', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'932', N'Huyện Châu Thành A', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'933', N'Huyện Châu Thành', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'934', N'Huyện Phụng Hiệp', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'935', N'Huyện Vị Thủy', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'936', N'Huyện Long Mỹ', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'937', N'Thị xã Long Mỹ', N'93')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'941', N'Thành phố Sóc Trăng', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'942', N'Huyện Châu Thành', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'943', N'Huyện Kế Sách', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'944', N'Huyện Mỹ Tú', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'945', N'Huyện Cù Lao Dung', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'946', N'Huyện Long Phú', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'947', N'Huyện Mỹ Xuyên', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'948', N'Thị xã Ngã Năm', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'949', N'Huyện Thạnh Trị', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'950', N'Thị xã Vĩnh Châu', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'951', N'Huyện Trần Đề', N'94')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'954', N'Thành phố Bạc Liêu', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'956', N'Huyện Hồng Dân', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'957', N'Huyện Phước Long', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'958', N'Huyện Vĩnh Lợi', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'959', N'Thị xã Giá Rai', N'95')
GO
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'960', N'Huyện Đông Hải', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'961', N'Huyện Hòa Bình', N'95')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'964', N'Thành phố Cà Mau', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'966', N'Huyện U Minh', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'967', N'Huyện Thới Bình', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'968', N'Huyện Trần Văn Thời', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'969', N'Huyện Cái Nước', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'970', N'Huyện Đầm Dơi', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'971', N'Huyện Năm Căn', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'972', N'Huyện Phú Tân', N'96')
INSERT [dbo].[District] ([ID], [DistrictName], [ProvinceID]) VALUES (N'973', N'Huyện Ngọc Hiển', N'96')
SET IDENTITY_INSERT [dbo].[FreightPrice] ON 

INSERT [dbo].[FreightPrice] ([ID], [TimeApply], [ShopID], [Information], [IsLock], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, CAST(N'2020-10-12T00:00:00.000' AS DateTime), 13, N'123                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ', 1, 1, 1, CAST(N'2020-12-23T00:00:00.000' AS DateTime), 1, CAST(N'2020-12-21T18:38:36.807' AS DateTime))
INSERT [dbo].[FreightPrice] ([ID], [TimeApply], [ShopID], [Information], [IsLock], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, CAST(N'2020-11-12T12:00:00.000' AS DateTime), 17, N'1234                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ', 0, 1, 1, CAST(N'2020-12-22T16:01:42.980' AS DateTime), 1, CAST(N'2020-12-22T16:06:21.727' AS DateTime))
SET IDENTITY_INSERT [dbo].[FreightPrice] OFF
SET IDENTITY_INSERT [dbo].[ImportOrdersChild] ON 

INSERT [dbo].[ImportOrdersChild] ([ID], [ParrentID], [Date], [CommodityID], [SupplierID], [ShopID], [InputNumber], [InputPrice], [Money], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, 10, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 13, 3, 13, CAST(2.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), 1, 1, CAST(N'2020-12-11T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[ImportOrdersChild] ([ID], [ParrentID], [Date], [CommodityID], [SupplierID], [ShopID], [InputNumber], [InputPrice], [Money], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, 10, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 13, 3, 13, CAST(2.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), CAST(24.00 AS Decimal(10, 2)), 1, 1, CAST(N'2020-12-11T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[ImportOrdersChild] ([ID], [ParrentID], [Date], [CommodityID], [SupplierID], [ShopID], [InputNumber], [InputPrice], [Money], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (7, 12, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 1, 3, 13, CAST(2.00 AS Decimal(10, 2)), CAST(11.00 AS Decimal(10, 2)), CAST(22.00 AS Decimal(10, 2)), 1, 1, CAST(N'2020-12-11T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[ImportOrdersChild] OFF
SET IDENTITY_INSERT [dbo].[ImportOrdersParrent] ON 

INSERT [dbo].[ImportOrdersParrent] ([ID], [Date], [SupplierID], [ShopID], [Information], [TotalQuantity], [TotalMoney], [IsLock], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (10, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 3, 13, N'123', CAST(1.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), 0, 1, 1, CAST(N'2020-12-11T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[ImportOrdersParrent] ([ID], [Date], [SupplierID], [ShopID], [Information], [TotalQuantity], [TotalMoney], [IsLock], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (12, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 1, 16, NULL, CAST(2.00 AS Decimal(10, 2)), CAST(200.00 AS Decimal(10, 2)), 0, 1, 1, CAST(N'2020-12-11T00:00:00.000' AS DateTime), 1, CAST(N'2020-12-24T16:34:49.757' AS DateTime))
SET IDENTITY_INSERT [dbo].[ImportOrdersParrent] OFF
INSERT [dbo].[Languages] ([ID], [Title], [Published], [Order]) VALUES (N'vi-VN', N'VietNam', 1, 1)
SET IDENTITY_INSERT [dbo].[ListedPrice] ON 

INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (10, CAST(N'2020-12-11T00:00:00.000' AS DateTime), CAST(999.99 AS Decimal(10, 2)), 3, N'None', 1, 34, CAST(N'2020-10-25T16:06:45.000' AS DateTime), 1, CAST(N'2020-12-22T10:13:44.953' AS DateTime))
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (14, CAST(N'2020-02-12T00:00:00.000' AS DateTime), CAST(10.30 AS Decimal(10, 2)), 12, N'SparkQuyn', 1, 1, CAST(N'2020-12-14T11:41:01.517' AS DateTime), 1, CAST(N'2020-12-22T13:12:27.747' AS DateTime))
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (15, CAST(N'2020-09-24T00:00:00.000' AS DateTime), CAST(19.99 AS Decimal(10, 2)), 13, N'5523', 0, 1, CAST(N'2020-12-14T11:55:31.497' AS DateTime), 1, CAST(N'2020-12-14T12:03:08.440' AS DateTime))
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (16, CAST(N'2020-12-10T00:00:00.000' AS DateTime), CAST(25.10 AS Decimal(10, 2)), 1, N'555', 0, 1, CAST(N'2020-12-14T14:17:41.250' AS DateTime), 1, CAST(N'2020-12-14T14:18:35.557' AS DateTime))
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (19, CAST(N'2020-12-16T00:00:00.000' AS DateTime), CAST(12344.44 AS Decimal(10, 2)), 1, N'5523', 0, 1, CAST(N'2020-12-14T15:04:34.353' AS DateTime), 34, CAST(N'2020-12-14T21:36:39.730' AS DateTime))
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (21, CAST(N'2020-12-16T00:00:00.000' AS DateTime), CAST(0.00 AS Decimal(10, 2)), 13, NULL, 1, 1, CAST(N'2020-12-18T23:10:34.610' AS DateTime), NULL, NULL)
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (22, CAST(N'2020-12-19T02:30:00.000' AS DateTime), CAST(999999.00 AS Decimal(10, 2)), 3, NULL, 0, 1, CAST(N'2020-12-19T17:04:21.950' AS DateTime), NULL, NULL)
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (30, CAST(N'2020-12-11T00:00:00.000' AS DateTime), CAST(0.00 AS Decimal(10, 2)), 12, NULL, 0, 1, CAST(N'2020-12-22T09:41:22.540' AS DateTime), NULL, NULL)
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (31, CAST(N'2020-12-22T00:30:00.000' AS DateTime), CAST(0.00 AS Decimal(10, 2)), 3, NULL, 1, 1, CAST(N'2020-12-22T10:26:21.153' AS DateTime), NULL, NULL)
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (33, CAST(N'2020-12-04T00:00:00.000' AS DateTime), CAST(12.00 AS Decimal(10, 2)), 3, N'12', 1, 1, CAST(N'2020-12-22T13:20:45.647' AS DateTime), NULL, NULL)
INSERT [dbo].[ListedPrice] ([ID], [TimeApply], [PriceListed], [CommodityID], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (34, CAST(N'2020-12-02T00:00:00.000' AS DateTime), CAST(11111.00 AS Decimal(10, 2)), 3, NULL, 1, 1, CAST(N'2020-12-22T13:21:54.940' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[ListedPrice] OFF
SET IDENTITY_INSERT [dbo].[LogSystem] ON 

INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (142, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-09T13:49:34.890' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (143, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-09T14:00:42.477' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (144, 34, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:01:13.433' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (145, 34, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:01:45.487' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (146, 34, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:22:32.277' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (147, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:22:59.187' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (148, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:23:38.837' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (149, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:23:56.483' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (150, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T14:25:24.710' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (151, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T14:27:56.747' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (152, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T14:28:59.800' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (153, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T14:29:27.150' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (154, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T14:29:41.297' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (155, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T14:30:03.910' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (156, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:39:05.170' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (157, 34, N'Delete User Profile', N'Xoá người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:41:38.850' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (158, 34, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:42:56.963' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (159, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T14:44:28.177' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (160, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:47:24.613' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (161, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:47:41.733' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (162, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:47:53.580' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (163, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:49:26.030' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (164, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T14:52:20.890' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (165, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T15:16:40.177' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (166, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T15:16:53.023' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (167, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T15:18:12.703' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (168, 34, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-09T16:35:21.343' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (169, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-09T16:35:33.897' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (170, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-09T17:03:42.117' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (171, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T19:00:08.837' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (172, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T19:52:10.420' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (173, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T20:00:16.227' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (174, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T20:06:57.447' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (175, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-09T20:07:17.407' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (176, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-09T21:03:31.170' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (177, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T09:52:43.263' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (178, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-10T10:14:49.170' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (179, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T10:48:47.537' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (180, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T11:55:40.633' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (181, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T11:59:09.300' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (182, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T12:01:35.957' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (183, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T12:05:52.810' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (184, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-10T12:10:04.463' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (185, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-10T12:10:45.497' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (186, 60, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 60, CAST(N'2020-12-10T13:17:23.717' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (187, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-10T13:27:31.607' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (188, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T15:11:36.260' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (189, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-10T16:13:02.657' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (190, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T16:16:33.777' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (191, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T16:18:42.230' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (192, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-10T16:47:57.763' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (193, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-10T16:48:11.247' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (194, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T16:51:25.333' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (195, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-10T18:42:10.833' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (196, 60, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 60, CAST(N'2020-12-10T18:42:45.663' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (197, 60, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 60, CAST(N'2020-12-10T18:43:10.303' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (198, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T20:23:41.830' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (199, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-10T20:23:50.157' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (200, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T09:10:21.270' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (201, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T09:56:20.443' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (202, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-11T10:01:37.283' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (203, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-11T10:42:25.977' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (204, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-11T10:57:47.097' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (205, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T11:03:04.333' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (206, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T11:10:30.820' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (207, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T11:24:29.990' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (208, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T11:44:28.013' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (209, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T13:08:23.737' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (210, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T15:39:22.133' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (211, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T16:01:19.840' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (212, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T16:06:42.107' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (213, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T18:18:47.703' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (214, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T18:20:44.500' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (215, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-11T18:29:51.997' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (216, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T18:30:18.377' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (217, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T18:30:41.403' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (218, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T18:56:11.273' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (219, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-11T21:11:07.520' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (220, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T10:34:14.313' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (221, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-12T11:00:46.473' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (222, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T12:09:22.607' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (223, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T12:09:30.200' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (224, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T12:32:36.540' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (225, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T12:57:07.433' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (226, 1, N'Add Commodity Category', N'Thêm Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:08:00.940' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (227, 1, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:08:06.310' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (228, 1, N'Add Commodity Category', N'Thêm Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:09:28.293' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (229, 1, N'Add Commodity Category', N'Thêm Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:10:25.410' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (230, 1, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:10:49.033' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (231, 1, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:10:57.897' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (232, 1, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:11:01.253' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (233, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T13:41:33.660' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (234, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T13:43:52.663' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (235, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T13:51:11.823' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (236, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:00:20.400' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (237, 1, N'Add Commodity Category', N'Thêm Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:00:32.607' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (238, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:14:25.153' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (239, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:14:27.213' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (240, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:14:35.940' AS DateTime))
GO
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (241, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:14:54.260' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (242, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:15:09.140' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (243, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-12T14:17:05.110' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (244, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T14:46:21.103' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (245, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T14:54:18.740' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (246, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:03:06.537' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (247, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:03:43.787' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (248, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:04:11.963' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (249, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:07:00.550' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (250, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:07:16.807' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (251, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:08:22.040' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (252, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:08:39.407' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (253, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-12T15:11:26.977' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (254, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-13T09:48:23.383' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (255, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T09:26:28.100' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (256, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T10:23:34.593' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (257, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T10:52:58.060' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (258, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T11:41:01.687' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (259, 1, N'Delete Shop Category', N'Xoá Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T11:41:41.750' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (260, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-14T11:48:19.430' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (261, 1, N'Add List Price', N'Thêm bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T11:55:31.540' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (262, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T14:14:07.770' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (263, 1, N'Add List Price', N'Thêm bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:17:41.277' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (264, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:21:13.577' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (265, 1, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:25:05.287' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (266, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-14T14:25:16.983' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (267, 34, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 34, CAST(N'2020-12-14T14:25:32.257' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (268, 34, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 34, CAST(N'2020-12-14T14:25:45.943' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (269, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T14:27:07.167' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (270, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:27:17.490' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (271, 1, N'Add Supplier Category', N'Thêm Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:29:15.900' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (272, 1, N'Delete Supplier Category', N'Xoá Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:29:20.433' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (273, 1, N'Add Supplier Category', N'Thêm Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:37:05.247' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (274, 1, N'Delete Supplier Category', N'Xoá Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T14:37:23.080' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (275, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-14T14:46:37.127' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (276, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T15:00:34.723' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (277, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T15:00:44.567' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (278, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T15:00:49.397' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (279, 1, N'Add List Price', N'Thêm bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T15:04:34.517' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (280, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T15:18:44.697' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (281, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T16:15:29.070' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (282, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T17:36:30.993' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (283, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T17:44:05.983' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (284, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T17:44:47.073' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (285, 1, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-14T17:46:59.793' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (286, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T17:51:13.043' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (287, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T17:54:35.477' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (288, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T18:01:00.760' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (289, 1, N'Add Price', N'Thêm giá bán', N'Price', NULL, NULL, 0, 1, CAST(N'2020-12-14T18:03:35.410' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (290, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-14T18:25:14.400' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (291, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-14T18:25:43.413' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (292, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T18:26:27.160' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (293, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-14T18:29:44.707' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (294, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-14T18:59:45.510' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (295, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-14T19:06:32.523' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (296, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-14T19:06:44.817' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (297, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-14T19:07:00.710' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (298, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-14T21:32:24.647' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (299, 34, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:36:39.907' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (300, 34, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:37:24.713' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (301, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:45:19.690' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (302, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:45:24.157' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (303, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:46:39.773' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (304, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:47:36.643' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (305, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:47:39.930' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (306, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:50:35.750' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (307, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:50:39.253' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (308, 34, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:50:42.073' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (309, 34, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:50:44.053' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (310, 34, N'Delete Supplier Category', N'Xoá Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 34, CAST(N'2020-12-14T21:50:45.640' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (311, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-15T01:44:52.810' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (312, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-15T01:45:32.567' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (313, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-15T09:53:59.207' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (314, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-15T10:11:32.943' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (315, 1, N'Add Commission Management', N'Thêm danh mục quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-15T10:20:54.053' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (316, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-15T10:27:40.327' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (317, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-15T10:33:08.290' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (318, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T11:10:53.173' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (319, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T12:01:34.973' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (320, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-15T12:04:13.633' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (321, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T12:18:13.410' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (322, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T12:26:20.193' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (323, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T12:29:04.493' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (324, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T13:59:38.227' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (325, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-15T14:01:28.833' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (326, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:03:07.340' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (327, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-15T14:06:55.977' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (328, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:11:44.880' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (329, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:12:14.123' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (330, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:12:58.473' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (331, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:13:20.783' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (332, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:22:25.290' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (333, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:37:48.723' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (334, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T14:37:59.863' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (335, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T15:01:02.643' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (336, 1, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T17:56:05.243' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (337, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T17:56:21.907' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (338, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T17:57:57.753' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (339, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T17:59:58.553' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (340, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:00:01.070' AS DateTime))
GO
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (341, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:00:02.960' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (342, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:00:38.173' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (343, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:00:51.340' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (344, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:02:07.867' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (345, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:08:53.870' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (346, 1, N'Delete User Profile', N'Xoá người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:09:32.583' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (347, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:29:03.437' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (348, 1, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:29:59.203' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (349, 1, N'Delete User Profile', N'Xoá người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T18:30:12.850' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (350, 1, N'Delete Shop Category', N'Xoá Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-15T19:37:34.993' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (351, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-15T19:42:18.330' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (352, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-15T19:43:03.537' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (353, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T19:43:16.633' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (354, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-15T19:43:31.457' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (355, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-15T19:44:02.590' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (356, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-16T13:53:53.583' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (357, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-16T13:57:36.287' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (358, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-16T14:56:31.477' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (359, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-16T14:59:43.173' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (360, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-16T15:00:25.660' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (361, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-16T15:25:23.317' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (362, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-17T10:03:10.427' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (363, 34, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 34, CAST(N'2020-12-17T10:33:41.340' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (364, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-17T11:21:53.900' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (365, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-17T12:09:17.637' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (366, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:51.977' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (367, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:54.380' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (368, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:54.683' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (369, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:55.023' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (370, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:55.500' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (371, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-17T16:58:55.800' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (372, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T09:46:43.633' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (373, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T16:01:23.887' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (374, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T16:17:37.313' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (375, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T17:09:56.353' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (376, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T17:26:21.737' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (377, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T17:27:11.307' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (378, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-18T17:59:24.000' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (379, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T17:59:36.100' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (380, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-18T18:02:03.727' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (381, 60, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admintest', 0, 60, CAST(N'2020-12-18T18:02:13.757' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (382, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T22:58:27.630' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (383, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:07:55.820' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (384, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:08:05.653' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (385, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:08:15.797' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (386, 1, N'Delete Customer Category', N'Xoá Danh mục khách hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:08:23.153' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (387, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:10:34.627' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (388, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-18T23:14:14.923' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (389, 34, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'sparkquyn', 0, 34, CAST(N'2020-12-19T07:01:51.557' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (390, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T11:54:19.783' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (391, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T11:59:44.303' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (392, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T12:14:02.127' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (393, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T12:14:07.093' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (394, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T12:14:13.207' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (395, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T13:58:27.390' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (396, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T13:58:50.227' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (397, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T13:59:01.587' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (398, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T14:05:38.187' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (399, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T14:07:49.530' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (400, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T14:08:33.850' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (401, 1, N'Add User', N'Thêm người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T14:11:41.267' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (402, 1, N'Delete User Profile', N'Xoá người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T14:16:37.750' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (403, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T14:54:33.043' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (404, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T14:59:08.820' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (405, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:05:30.113' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (406, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:08:44.233' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (407, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:31:37.570' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (408, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:42:37.683' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (409, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:42:51.013' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (410, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:43:27.010' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (411, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:47:02.803' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (412, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-19T15:47:13.880' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (413, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:48:43.163' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (414, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:49:24.483' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (415, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:49:31.563' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (416, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T15:50:49.233' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (417, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:10:09.853' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (418, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:10:42.963' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (419, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:10:47.313' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (420, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:10:56.460' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (421, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:10:59.080' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (422, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:13:13.100' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (423, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:13:32.480' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (424, 1, N'Delete Shop Category', N'Xoá Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:13:45.750' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (425, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:17:37.073' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (426, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:21:45.093' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (427, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:21:55.130' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (428, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:22:39.987' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (429, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:26:24.670' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (430, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:26:41.430' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (431, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-19T16:31:20.413' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (432, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-19T17:04:22.107' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (433, 1, N'Add Price', N'Thêm giá bán', N'Price', NULL, NULL, 0, 1, CAST(N'2020-12-19T17:14:22.933' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (434, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-19T17:14:43.140' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (435, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-19T17:14:53.000' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (436, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-20T09:12:25.857' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (437, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-20T11:53:31.530' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (438, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-20T12:40:39.550' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (439, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T10:46:56.863' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (440, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T11:08:02.543' AS DateTime))
GO
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (441, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T11:59:24.137' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (442, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T13:58:20.020' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (443, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:16:15.107' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (444, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:17:56.793' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (445, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:23:56.603' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (446, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:24:23.130' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (447, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:29:34.707' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (448, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T14:45:17.680' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (449, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:03:51.193' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (450, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:03:58.877' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (451, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:04:11.220' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (452, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:04:18.010' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (453, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:07:42.743' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (454, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:10:29.280' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (455, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:11:33.847' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (456, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:20:38.683' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (457, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T15:29:15.063' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (458, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T15:31:32.270' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (459, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T15:34:39.893' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (460, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:42:30.100' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (461, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:42:38.123' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (462, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:42:56.157' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (463, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:44:54.193' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (464, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:45:02.830' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (465, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:45:08.610' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (466, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T15:55:49.053' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (467, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T16:03:04.043' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (468, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T16:03:10.390' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (469, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T16:10:15.917' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (470, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T16:59:48.757' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (471, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:01:50.007' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (472, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:01:54.740' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (473, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:03:46.067' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (474, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:04:04.183' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (475, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:04:39.137' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (476, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:04:49.737' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (477, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:05:18.337' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (478, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:08:59.183' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (479, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:29:48.903' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (480, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:29:58.430' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (481, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:30:08.687' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (482, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:31:08.990' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (483, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:31:15.293' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (484, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T17:35:52.913' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (485, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:36:00.723' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (486, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T17:36:18.650' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (487, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-21T17:37:34.423' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (488, 1, N'Add Commodity Category', N'Thêm Danh mục hàng hoá', N'CommodityCategory', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:18:49.323' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (489, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:33:31.497' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (490, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:35:21.987' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (491, 1, N'Update User Profile', N'Cập nhật thông tin người dùng', N'UserProfiles', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:35:28.563' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (492, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:36:35.217' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (493, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:36:44.370' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (494, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:38:36.807' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (495, 1, N'Add Commission Management', N'Thêm danh mục quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-21T18:38:44.933' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (496, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T08:58:22.990' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (497, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T09:11:55.223' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (498, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:14:39.030' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (499, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:14:45.360' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (500, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:20:48.150' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (501, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:20:55.927' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (502, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:25:46.377' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (503, 1, N'Update Supplier Category', N'Cập nhật Danh mục nhà cung cấp', N'SupplierCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:25:55.213' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (504, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:31:47.487' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (505, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:41:22.710' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (506, 1, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:42:14.790' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (507, 1, N'Delete List Price', N'Xoá bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:42:20.903' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (508, 1, N'Delete Customer Category', N'Xoá Danh mục khách hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:44:18.300' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (509, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:44:27.797' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (510, 1, N'Delete Customer Category', N'Xoá Danh mục khách hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:44:31.403' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (511, 1, N'Update Customer Category', N'Cập nhật Danh mục khách hàng', N'CustomerCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T09:54:30.743' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (512, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T10:05:20.597' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (513, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:13:45.140' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (514, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:26:21.177' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (515, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:34:33.510' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (516, 1, N'Update Commission Management', N'Cập nhật bảng quản lý hoa hồng', N'Commission Management', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:36:19.343' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (517, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:42:42.700' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (518, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:43:02.657' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (519, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:43:15.947' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (520, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:43:27.880' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (521, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T10:43:35.113' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (522, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T13:03:56.810' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (523, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:12:28.027' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (524, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:20:45.943' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (525, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:21:04.120' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (526, 1, N'Add List Price', N'Thêm bản giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:21:54.940' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (527, 1, N'Add Price', N'Thêm giá bán', N'Price', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:22:50.343' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (528, 1, N'Update List Price', N'Cập nhật bảng giá niêm yết', N'ListPrice', NULL, NULL, 0, 1, CAST(N'2020-12-22T13:22:59.050' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (529, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T14:23:55.717' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (530, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:08:35.620' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (531, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:08:41.820' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (532, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:08:48.787' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (533, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:08:54.380' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (534, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:09:00.307' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (535, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:09:07.040' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (536, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:09:27.320' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (537, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:09:32.007' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (538, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:09:37.493' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (539, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T15:23:41.627' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (540, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T15:24:33.850' AS DateTime))
GO
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (541, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T15:27:21.453' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (542, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:41:28.327' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (543, 1, N'Delete Shop Category', N'Xoá Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T15:44:45.143' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (544, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:00:14.457' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (545, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:00:27.187' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (546, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:00:37.653' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (547, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:00:46.760' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (548, 1, N'Add Freightprices', N'Thêm cước vận chuyển', N'FREIGHT PRICES', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:01:43.183' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (549, 1, N'Add Shop Category', N'Thêm Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:05:09.783' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (550, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T16:06:11.927' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (551, 1, N'Update Freightprices Management', N'Cập nhật bảng cước vận chuyển', N'FREIGHT PRICES', NULL, NULL, 0, 1, CAST(N'2020-12-22T16:06:21.910' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (552, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T16:06:38.127' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (553, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T16:19:09.160' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (554, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T16:21:04.097' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (555, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T16:49:16.737' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (556, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:04:39.530' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (557, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:31:12.453' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (558, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:32:13.287' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (559, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:32:34.790' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (560, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:33:32.407' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (561, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:34:17.677' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (562, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-22T18:38:19.827' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (563, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T09:27:07.673' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (564, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T09:37:29.857' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (565, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T09:57:20.880' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (566, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T10:17:58.597' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (567, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T11:52:47.240' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (568, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T11:53:17.770' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (569, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T11:54:47.377' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (570, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T12:00:22.250' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (571, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T12:03:41.367' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (572, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T12:06:01.367' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (573, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T13:31:22.893' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (574, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T13:36:50.593' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (575, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T15:39:06.577' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (576, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T16:01:08.793' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (577, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T17:02:16.400' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (578, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-23T17:37:06.057' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (579, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T09:30:43.340' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (580, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T09:52:19.170' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (581, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T10:02:27.137' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (582, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T10:17:28.450' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (583, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T10:23:45.890' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (584, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T10:35:07.743' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (585, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T14:50:06.213' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (586, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T15:05:40.510' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (587, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T16:11:30.840' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (588, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T16:29:34.293' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (589, 1, N'Update Shop Category', N'Cập nhật Danh mục cửa hàng', N'ShopCategory', NULL, NULL, 0, 1, CAST(N'2020-12-24T16:34:49.800' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (590, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T17:39:24.210' AS DateTime))
INSERT [dbo].[LogSystem] ([ID], [UserID], [ActiveType], [FunctionName], [DataTable], [DateTime], [Information], [IsActive], [CreatedBy], [CreatedAt]) VALUES (591, 1, N'Login', N'Đăng nhập', N'UserProfiles', NULL, N'admin', 0, 1, CAST(N'2020-12-24T17:39:48.647' AS DateTime))
SET IDENTITY_INSERT [dbo].[LogSystem] OFF
SET IDENTITY_INSERT [dbo].[NoteBookKey] ON 

INSERT [dbo].[NoteBookKey] ([ID], [DateTimeKey], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, CAST(N'2020-03-10T01:00:00.000' AS DateTime), 1, 3, CAST(N'2016-12-10T16:06:45.170' AS DateTime), 1, CAST(N'2020-12-19T16:26:41.410' AS DateTime))
SET IDENTITY_INSERT [dbo].[NoteBookKey] OFF
SET IDENTITY_INSERT [dbo].[Price] ON 

INSERT [dbo].[Price] ([ID], [TimeApply], [CommodityID], [ShopID], [CustomerID], [Prices], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, CAST(N'2020-02-12T00:00:00.000' AS DateTime), 12, 17, NULL, CAST(9999999.00 AS Decimal(10, 2)), N'No', 1, 34, CAST(N'2020-12-04T17:48:06.220' AS DateTime), 1, CAST(N'2020-12-22T10:43:35.087' AS DateTime))
INSERT [dbo].[Price] ([ID], [TimeApply], [CommodityID], [ShopID], [CustomerID], [Prices], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, CAST(N'2020-12-18T00:00:00.000' AS DateTime), 1, 16, 1, CAST(999.99 AS Decimal(10, 2)), N'SparkQuyn', 1, 1, CAST(N'2020-12-14T18:03:35.240' AS DateTime), NULL, NULL)
INSERT [dbo].[Price] ([ID], [TimeApply], [CommodityID], [ShopID], [CustomerID], [Prices], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, CAST(N'2020-12-18T00:00:00.000' AS DateTime), 3, 16, NULL, CAST(999.99 AS Decimal(10, 2)), N'123', 1, 1, CAST(N'2020-12-19T17:14:22.770' AS DateTime), 1, CAST(N'2020-12-21T14:45:17.520' AS DateTime))
INSERT [dbo].[Price] ([ID], [TimeApply], [CommodityID], [ShopID], [CustomerID], [Prices], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (10, CAST(N'2020-03-12T00:00:00.000' AS DateTime), 1, 13, 2, CAST(0.00 AS Decimal(10, 2)), NULL, 1, 1, CAST(N'2020-12-22T13:22:50.313' AS DateTime), 1, CAST(N'2020-12-22T13:22:59.033' AS DateTime))
SET IDENTITY_INSERT [dbo].[Price] OFF
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'01', N'Thành phố Hà Nội')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'02', N'Tỉnh Hà Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'04', N'Tỉnh Cao Bằng')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'06', N'Tỉnh Bắc Kạn')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'08', N'Tỉnh Tuyên Quang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'10', N'Tỉnh Lào Cai')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'11', N'Tỉnh Điện Biên')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'12', N'Tỉnh Lai Châu')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'14', N'Tỉnh Sơn La')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'15', N'Tỉnh Yên Bái')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'17', N'Tỉnh Hòa Bình')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'19', N'Tỉnh Thái Nguyên')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'20', N'Tỉnh Lạng Sơn')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'22', N'Tỉnh Quảng Ninh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'24', N'Tỉnh Bắc Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'25', N'Tỉnh Phú Thọ')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'26', N'Tỉnh Vĩnh Phúc')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'27', N'Tỉnh Bắc Ninh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'30', N'Tỉnh Hải Dương')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'31', N'Thành phố Hải Phòng')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'33', N'Tỉnh Hưng Yên')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'34', N'Tỉnh Thái Bình')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'35', N'Tỉnh Hà Nam')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'36', N'Tỉnh Nam Định')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'37', N'Tỉnh Ninh Bình')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'38', N'Tỉnh Thanh Hóa')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'40', N'Tỉnh Nghệ An')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'42', N'Tỉnh Hà Tĩnh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'44', N'Tỉnh Quảng Bình')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'45', N'Tỉnh Quảng Trị')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'46', N'Tỉnh Thừa Thiên Huế')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'48', N'Thành phố Đà Nẵng')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'49', N'Tỉnh Quảng Nam')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'51', N'Tỉnh Quảng Ngãi')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'52', N'Tỉnh Bình Định')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'54', N'Tỉnh Phú Yên')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'56', N'Tỉnh Khánh Hòa')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'58', N'Tỉnh Ninh Thuận')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'60', N'Tỉnh Bình Thuận')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'62', N'Tỉnh Kon Tum')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'64', N'Tỉnh Gia Lai')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'66', N'Tỉnh Đắk Lắk')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'67', N'Tỉnh Đắk Nông')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'68', N'Tỉnh Lâm Đồng')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'70', N'Tỉnh Bình Phước')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'72', N'Tỉnh Tây Ninh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'74', N'Tỉnh Bình Dương')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'75', N'Tỉnh Đồng Nai')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'77', N'Tỉnh Bà Rịa - Vũng Tàu')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'79', N'Thành phố Hồ Chí Minh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'80', N'Tỉnh Long An')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'82', N'Tỉnh Tiền Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'83', N'Tỉnh Bến Tre')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'84', N'Tỉnh Trà Vinh')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'86', N'Tỉnh Vĩnh Long')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'87', N'Tỉnh Đồng Tháp')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'89', N'Tỉnh An Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'91', N'Tỉnh Kiên Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'92', N'Thành phố Cần Thơ')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'93', N'Tỉnh Hậu Giang')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'94', N'Tỉnh Sóc Trăng')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'95', N'Tỉnh Bạc Liêu')
INSERT [dbo].[Province] ([ID], [ProvinceName]) VALUES (N'96', N'Tỉnh Cà Mau')
SET IDENTITY_INSERT [dbo].[ShopCategory] ON 

INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (13, N'123', N'ShopName', N'Spark3', 1, 1, CAST(N'2016-12-10T16:06:45.170' AS DateTime), 1, CAST(N'2020-12-19T16:10:09.693' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (16, N'1234', N'Quyn', N'Quyn3', 1, 1, CAST(N'2020-12-07T19:26:39.133' AS DateTime), 1, CAST(N'2020-12-19T16:10:47.293' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (17, N'12345', N'Spark3', N'SparkQuyn', 1, 34, CAST(N'2020-12-09T16:35:21.170' AS DateTime), 1, CAST(N'2020-12-21T17:31:15.270' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (21, N'1', N'Test1', N'4', 1, 1, CAST(N'2020-12-12T12:32:36.370' AS DateTime), 1, CAST(N'2020-12-22T09:14:45.340' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (23, N'111', N'123453', N'123', 1, 1, CAST(N'2020-12-19T16:13:13.077' AS DateTime), 1, CAST(N'2020-12-19T16:13:32.463' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (24, N'as22', N'23', N'12321', 1, 1, CAST(N'2020-12-21T15:10:29.253' AS DateTime), 1, CAST(N'2020-12-21T17:30:08.667' AS DateTime))
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (25, N'dasds', N'asd', N'dasdasdsa', 1, 1, CAST(N'2020-12-21T15:11:33.807' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (26, N'TSC1', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:08:35.307' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (27, N'TSC2', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:08:41.820' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (28, N'TSC3', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:08:48.787' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (29, N'TSC4', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:08:54.380' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (30, N'TSC5', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:09:00.290' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (31, N'TSC6', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:09:07.040' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (32, N'TSC7', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:09:27.320' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (33, N'TSC8', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:09:32.007' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (34, N'TSC9', N'Trụ sở chính', NULL, 1, 1, CAST(N'2020-12-22T15:09:37.493' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (35, N'TSC10', N'Trụ sở phụ', NULL, 1, 1, CAST(N'2020-12-22T15:41:28.020' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (36, N'TSC11', N'SPARK', NULL, 1, 1, CAST(N'2020-12-22T16:00:14.260' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (37, N'TSC12', N'SPARK12', NULL, 1, 1, CAST(N'2020-12-22T16:00:27.167' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (38, N'TSC13', N'TS13', NULL, 1, 1, CAST(N'2020-12-22T16:00:37.633' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (39, N'TSC14', N'14', NULL, 1, 1, CAST(N'2020-12-22T16:00:46.740' AS DateTime), 0, NULL)
INSERT [dbo].[ShopCategory] ([ID], [ShopCode], [ShoprName], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (40, N'TSC123', N'1234123', NULL, 1, 1, CAST(N'2020-12-22T16:05:09.763' AS DateTime), 0, NULL)
SET IDENTITY_INSERT [dbo].[ShopCategory] OFF
SET IDENTITY_INSERT [dbo].[SubscribeNotices] ON 

INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (1, N'trangqt_c00422@fpt.aptech.ac.vn', N'admin', CAST(N'2013-12-06T11:12:24.230' AS DateTime), N'admin', CAST(N'2013-12-06T11:12:24.230' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (2, N'trangqt2908@gmail.com', N'admin', CAST(N'2013-12-10T09:30:54.517' AS DateTime), N'admin', CAST(N'2013-12-10T09:30:54.517' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (3, N'trangqt2908@gmail.com', N'admin', CAST(N'2013-12-10T09:40:05.607' AS DateTime), N'admin', CAST(N'2013-12-10T09:40:05.607' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (4, N'DucMjnh1992@yahoo.com.vn', N'admin', CAST(N'2013-12-23T16:05:06.903' AS DateTime), N'admin', CAST(N'2013-12-23T16:05:06.903' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (5, N'DucMjnh1992@yahoo.com.vn', N'admin', CAST(N'2013-12-23T16:05:39.673' AS DateTime), N'admin', CAST(N'2013-12-23T16:05:39.673' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (6, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2013-12-27T16:02:21.920' AS DateTime), N'admin', CAST(N'2013-12-27T16:02:21.920' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (7, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2013-12-27T16:02:36.320' AS DateTime), N'admin', CAST(N'2013-12-27T16:02:36.320' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (8, N'DucMjnh1992@yahoo.com', N'', CAST(N'2014-01-06T10:23:18.210' AS DateTime), N'', CAST(N'2014-01-06T10:23:18.210' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (9, N'DucMjnh1992@yahoo.com', N'', CAST(N'2014-01-06T10:23:18.270' AS DateTime), N'', CAST(N'2014-01-06T10:23:18.270' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (10, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2014-01-06T10:30:05.517' AS DateTime), N'admin', CAST(N'2014-01-06T10:30:05.517' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (11, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2014-01-06T10:30:05.557' AS DateTime), N'admin', CAST(N'2014-01-06T10:30:05.557' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (12, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2014-01-06T10:35:49.667' AS DateTime), N'admin', CAST(N'2014-01-06T10:35:49.667' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (13, N'DucMjnh1992@yahoo.com', N'admin', CAST(N'2014-01-06T10:35:49.700' AS DateTime), N'admin', CAST(N'2014-01-06T10:35:49.700' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (14, N'DucMjnh1992@yahoo.com', N'', CAST(N'2014-01-06T10:39:52.327' AS DateTime), N'', CAST(N'2014-01-06T10:39:52.327' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (15, N'DucMjnh1992@yahoo.com', N'', CAST(N'2014-01-06T10:39:52.447' AS DateTime), N'', CAST(N'2014-01-06T10:39:52.447' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (16, N'ducminh@gmail.com', N'', CAST(N'2014-01-06T10:49:20.477' AS DateTime), N'', CAST(N'2014-01-06T10:49:20.477' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (17, N'ducminh@gmail.com', N'', CAST(N'2014-01-06T10:49:20.560' AS DateTime), N'', CAST(N'2014-01-06T10:49:20.560' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (18, N'DucMjnh1992@yahoo.com', N'', CAST(N'2014-01-06T10:51:45.313' AS DateTime), N'', CAST(N'2014-01-06T10:51:45.313' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (19, N'longnguyen21@hotmail.com', N'admin', CAST(N'2014-01-06T11:49:29.810' AS DateTime), N'admin', CAST(N'2014-01-06T11:49:29.810' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (20, N'longnguyen21@hotmail.com', N'admin', CAST(N'2014-01-06T11:49:29.887' AS DateTime), N'admin', CAST(N'2014-01-06T11:49:29.887' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (21, N'ducminh@adcvietnam.net', N'admin', CAST(N'2014-01-06T11:51:00.257' AS DateTime), N'admin', CAST(N'2014-01-06T11:51:00.257' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (22, N'ducminh@adcvietnam.net', N'admin', CAST(N'2014-01-06T11:51:01.130' AS DateTime), N'admin', CAST(N'2014-01-06T11:51:01.130' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (23, N'longnguyen21@hotmail.com', N'admin', CAST(N'2014-01-06T11:54:27.383' AS DateTime), N'admin', CAST(N'2014-01-06T11:54:27.383' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (24, N'longnguyen21@hotmail.com', N'admin', CAST(N'2014-01-06T11:54:36.727' AS DateTime), N'admin', CAST(N'2014-01-06T11:54:36.727' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (25, N'ducminh@adcvietnam.net', N'', CAST(N'2014-01-06T13:58:37.820' AS DateTime), N'', CAST(N'2014-01-06T13:58:37.820' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (26, N'vuongnv@adcvietnam.net', N'', CAST(N'2014-02-13T14:27:40.890' AS DateTime), N'', CAST(N'2014-02-13T14:27:40.890' AS DateTime), 1)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (27, N'buiminhhung162@gmail.com', N'admin', NULL, N'admin', NULL, 0)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (28, N'huonggiang86@gmail.com', N'admin', NULL, N'admin', NULL, 0)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (29, N'trangbaoanh3011@gmail.com', N'', NULL, N'', NULL, 0)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (30, N'trangbaoanh3011@gmai.com', N'', NULL, N'', NULL, 0)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (31, N'giang@joymarktravel.com', N'admin', NULL, N'admin', NULL, 0)
INSERT [dbo].[SubscribeNotices] ([Id], [Email], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status]) VALUES (32, N'michel.hoang388@orange.fr', N'', NULL, N'', NULL, 0)
SET IDENTITY_INSERT [dbo].[SubscribeNotices] OFF
SET IDENTITY_INSERT [dbo].[SupplierCategory] ON 

INSERT [dbo].[SupplierCategory] ([ID], [SupplierID], [SupplierName], [Taxcode], [SupplierAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'1', N'1', N'1', N'1', N'1', N'1', 1, 1, CAST(N'2020-12-04T15:32:24.863' AS DateTime), 1, CAST(N'2020-12-19T15:42:50.987' AS DateTime))
INSERT [dbo].[SupplierCategory] ([ID], [SupplierID], [SupplierName], [Taxcode], [SupplierAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (2, N'2', N'SparkQuyn', N'2', N'Thọ Tháp', N'0987654321', N'44', 1, 1, CAST(N'2020-12-04T17:23:51.210' AS DateTime), 1, CAST(N'2020-12-22T09:25:55.193' AS DateTime))
INSERT [dbo].[SupplierCategory] ([ID], [SupplierID], [SupplierName], [Taxcode], [SupplierAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (3, N'2510', N'SparkQuyn', N'1999', N'Moon', N'0987654321', N'SparkQuyn', 1, 34, CAST(N'2020-12-07T19:01:45.987' AS DateTime), 34, CAST(N'2020-12-07T19:06:57.083' AS DateTime))
INSERT [dbo].[SupplierCategory] ([ID], [SupplierID], [SupplierName], [Taxcode], [SupplierAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (4, N'2', NULL, NULL, NULL, NULL, NULL, 0, 1, CAST(N'2020-12-14T14:29:15.877' AS DateTime), 0, NULL)
INSERT [dbo].[SupplierCategory] ([ID], [SupplierID], [SupplierName], [Taxcode], [SupplierAddress], [PhoneNumber], [Information], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (6, N'a', NULL, NULL, NULL, NULL, NULL, 0, 1, CAST(N'2020-12-14T14:37:05.203' AS DateTime), 0, NULL)
SET IDENTITY_INSERT [dbo].[SupplierCategory] OFF
SET IDENTITY_INSERT [dbo].[UploadFiles] ON 

INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1, N'Test ', N'/uploads/file/PTA - Contact us.docx')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (2, N'test 2', N'/uploads/file/Phieu_1B_DoanhNghiep.xls')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (3, N'GADTfile', N'/uploads/file/GADT_form_tour_package.docx')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (7, NULL, N'/uploads/file/Desktop.rar')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1008, N'Folder 1407', N'/uploads/file/Folder1407.pdf')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1009, NULL, N'/uploads/file/Visa-to-Dubai.pdf')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1011, N'file', N'/uploads/file/2507.jpg')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1012, NULL, N'/uploads/file/Desktop.rar')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1014, N'Backdrop - Tam Dao Group', N'/uploads/file/Backdrop.psd')
INSERT [dbo].[UploadFiles] ([ID], [Title], [Link]) VALUES (1015, N'Tạp chí môi trường số 5 năm 2020', N'/uploads/file/so 1 2020.pdf')
SET IDENTITY_INSERT [dbo].[UploadFiles] OFF
SET IDENTITY_INSERT [dbo].[UserProfile] ON 

INSERT [dbo].[UserProfile] ([UserId], [StaffCode], [BranchId], [UserName], [FullName], [Email], [Mobile], [Avatar], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (1, N'12', NULL, N'admin', N'Administrator', N'admin@petro.com.vn', N'0973161971', N'/content/uploads/avatars/d65ecfa4-22af-4c59-98af-347453652c57.png', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[UserProfile] ([UserId], [StaffCode], [BranchId], [UserName], [FullName], [Email], [Mobile], [Avatar], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (34, N'1123', 13, N'sparkquyn', N'Quang Tâm Đức', N'binh9aqktk@gmail.com', N'0123456789', N'/content/uploads/avatars/2a28648d-e709-4a13-b24d-476ae6c6ecc9.png', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[UserProfile] ([UserId], [StaffCode], [BranchId], [UserName], [FullName], [Email], [Mobile], [Avatar], [IsActive], [CreatedBy], [CreatedAt], [ModifiedBy], [ModifiedAt]) VALUES (60, N'123', 21, N'admintest', N'SparkQuyn', N'user@gmail.com', N'0123456789', N'/content/uploads/avatars/admintest.png', 1, 34, CAST(N'2020-12-09T14:42:56.813' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
SET IDENTITY_INSERT [dbo].[WebConfigs] ON 

INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'email nhận thông tin', N'email-receive', N'trangqt2908@gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'email gửi thông tin', N'email-send', N'tapchimoitruongtest@gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'smtp email gửi', N'email-send-smtp', N'smtp.gmail.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'port email gửi', N'email-send-port', N'587', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'mật khẩu email gửi', N'email-send-password', N'tapchi123', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'ssl email gửi', N'email-send-ssl', N'1', NULL, NULL, NULL, NULL)
INSERT [dbo].[WebConfigs] ([ID], [Title], [Key], [Value], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'LicenseKey', N'LicenseKey', N'BE23C0C3-5CEE-4F24-8FC5-ED818D5CE797', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WebConfigs] OFF
SET IDENTITY_INSERT [dbo].[WebContacts] ON 

INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (1, N'test 2', N'jk', N'Trang', N'trangqt2908@gmail.com', N'01234689698', N'84 Tô Vĩnh Diện', CAST(N'2016-12-10' AS Date), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (2, N'Ý kiến bạn đọc', N'66', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (3, N'Ý kiến bạn đọc', N'66', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (4, N'Ý kiến bạn đọc', N'666', N'6', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (5, N'Ý kiến bạn đọc', N'444', N'444', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (6, N'Liên hệ tòa soạn', N'333', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (7, N'Liên hệ tòa soạn', N'44', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (8, N'Liên hệ tòa soạn', N'44', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (9, N'Liên hệ tòa soạn', N'44', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (10, N'Liên hệ tòa soạn', N'777', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (11, N'Liên hệ tòa soạn', N'5555', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (12, N'Liên hệ tòa soạn', N'6666', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (13, N'Liên hệ tòa soạn', N'555666', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (14, N'Liên hệ tòa soạn', N'333', N'5', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (15, N'Liên hệ tòa soạn', N'333', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (16, N'Liên hệ tòa soạn', N'333', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (17, N'Liên hệ tòa soạn', N'444', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (18, N'Liên hệ tòa soạn', N'Tôi cần liên hệ với tạp chí!', N'Lê Thế Quyền', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (19, N'Liên hệ tòa soạn', N'333', N'3333', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-22' AS Date), NULL, NULL, 0, 3, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (20, N'Ý kiến bạn đọc', N'333', N'3', N'333@gmail.com', NULL, NULL, CAST(N'2020-07-23' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (21, N'Ý kiến bạn đọc', N'Chưa bao giờ tôi được đọc bài viết hay đến vậy. Ngàn like cho tạp chí !!!', N'Nguyễn Văn Tèo', N'nguyenvanteo@gmail.com', NULL, NULL, CAST(N'2020-07-28' AS Date), NULL, NULL, 0, 1, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (23, N'Đăng ký nghiên cứu', N'1123', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:38:22.443' AS DateTime), CAST(N'2020-08-02T12:38:22.443' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (24, N'Đăng ký nghiên cứu', N'2222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:39:25.547' AS DateTime), CAST(N'2020-08-02T12:39:25.547' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (25, N'Đăng ký nghiên cứu', N'2222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:45:11.347' AS DateTime), CAST(N'2020-08-02T12:45:11.347' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (26, N'Đăng ký nghiên cứu', N'1111', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:47:05.717' AS DateTime), CAST(N'2020-08-02T12:47:05.717' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (27, N'Đăng ký nghiên cứu', N'123', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:49:16.963' AS DateTime), CAST(N'2020-08-02T12:49:16.963' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (28, N'Đăng ký nghiên cứu', N'666', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:50:18.763' AS DateTime), CAST(N'2020-08-02T12:50:18.763' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (29, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T12:50:38.563' AS DateTime), CAST(N'2020-08-02T12:50:38.563' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (30, N'Đăng ký nghiên cứu', N'123', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:05:03.700' AS DateTime), CAST(N'2020-08-02T14:05:03.700' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (31, N'Đăng ký nghiên cứu', N'2222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:06:20.727' AS DateTime), CAST(N'2020-08-02T14:06:20.727' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (32, N'Đăng ký nghiên cứu', N'2222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:06:23.933' AS DateTime), CAST(N'2020-08-02T14:06:23.933' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (33, N'Đăng ký nghiên cứu', N'2222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:06:36.603' AS DateTime), CAST(N'2020-08-02T14:06:36.603' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (34, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:17:17.477' AS DateTime), CAST(N'2020-08-02T14:17:17.477' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (35, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:18:25.620' AS DateTime), CAST(N'2020-08-02T14:18:25.620' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (36, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:19:03.167' AS DateTime), CAST(N'2020-08-02T14:19:03.167' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (37, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:19:19.010' AS DateTime), CAST(N'2020-08-02T14:19:19.010' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (38, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:23:30.857' AS DateTime), CAST(N'2020-08-02T14:23:30.857' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (39, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:26:00.830' AS DateTime), CAST(N'2020-08-02T14:26:00.833' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (40, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:33:15.727' AS DateTime), CAST(N'2020-08-02T14:33:15.727' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (41, N'Đăng ký nghiên cứu', N'3333', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:33:38.923' AS DateTime), CAST(N'2020-08-02T14:33:38.923' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (42, N'Đăng ký nghiên cứu', N'222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:35:54.710' AS DateTime), CAST(N'2020-08-02T14:35:54.710' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (43, N'Đăng ký nghiên cứu', N'9999', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T14:37:26.527' AS DateTime), CAST(N'2020-08-02T14:37:26.527' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (44, N'Đăng ký nghiên cứu', N'999', N'3333', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T15:10:26.750' AS DateTime), CAST(N'2020-08-02T15:10:26.750' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (45, N'Đăng ký nghiên cứu', N'nd test', N'test', N'test@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:37:30.443' AS DateTime), CAST(N'2020-08-02T16:37:30.443' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (46, N'Đăng ký nghiên cứu', N'reset', N'3333', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:39:13.400' AS DateTime), CAST(N'2020-08-02T16:39:13.400' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (47, N'Đăng ký nghiên cứu', N'fgfghfgh', N'3333', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:40:01.727' AS DateTime), CAST(N'2020-08-02T16:40:01.727' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (48, N'Đăng ký nghiên cứu', N'777', N'3333', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:42:22.217' AS DateTime), CAST(N'2020-08-02T16:42:22.217' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (49, N'Đăng ký nghiên cứu', N'dgfhdgdgh', N'3333', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:48:33.450' AS DateTime), CAST(N'2020-08-02T16:48:33.450' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (50, N'Đăng ký nghiên cứu', N'loading', N'test', N'333@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T16:58:36.723' AS DateTime), CAST(N'2020-08-02T16:58:36.723' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (51, N'Đăng ký nghiên cứu', N'Test đăng ký', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T17:32:48.463' AS DateTime), CAST(N'2020-08-02T17:32:48.463' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (52, N'Đăng ký nghiên cứu', N'222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T17:33:05.587' AS DateTime), CAST(N'2020-08-02T17:33:05.587' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (53, N'Đăng ký nghiên cứu', N'1111', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T17:33:44.137' AS DateTime), CAST(N'2020-08-02T17:33:44.137' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (54, N'Đăng ký nghiên cứu', N'111222', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T17:34:36.193' AS DateTime), CAST(N'2020-08-02T17:34:36.193' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (55, N'Đăng ký nghiên cứu', N'Tôi muốn đăng ký viết bài TẠP CHÍ SỐ ĐỊNH KỲ', N'Quyền', N'quyenlt2908@gmail.com', N'N/A', N'N/A', CAST(N'2020-08-02' AS Date), CAST(N'2020-08-02T17:38:21.903' AS DateTime), CAST(N'2020-08-02T17:38:21.903' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (56, N'Đăng ký nghiên cứu', N'tghjjghj', N'Quách Trang', N'admin@gmail.com', N'N/A', N'N/A', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-15T17:08:20.567' AS DateTime), CAST(N'2020-09-15T17:08:20.567' AS DateTime), 0, 4, NULL)
INSERT [dbo].[WebContacts] ([ID], [Title], [Body], [FullName], [Email], [Mobile], [Address], [CreatedDate], [NgayBatDau], [NgayKetThuc], [LoaiDonHang], [LoaiLienHe], [WebModuleID]) VALUES (57, N'Đăng ký nghiên cứu', N'ádđf', N'Quách Trang', N'admin@gmail.com', N'N/A', N'N/A', CAST(N'2020-09-15' AS Date), CAST(N'2020-09-15T17:09:51.823' AS DateTime), CAST(N'2020-09-15T17:09:51.823' AS DateTime), 0, 4, 66)
SET IDENTITY_INSERT [dbo].[WebContacts] OFF
SET IDENTITY_INSERT [dbo].[WebContentUploads] ON 

INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (1, N'sample-mp4-file.mp4', N'sample-mp4-file-mp4', N'/uploads/video/072020/sample-mp4-file_8ba47b2c.mp4', N'8d8265b42f1ce6abk49stlpft', NULL, CAST(N'2020-07-12T12:05:39.003' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (2, N'tc.png', N'tc-png', N'/uploads/072020/tc_6683050f.png', N'8d8265c84f3903duol8n2i65i', NULL, CAST(N'2020-07-12T12:10:31.060' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (3, N'tc.png', N'tc-png', N'/uploads/072020/tc_ad48ee45.png', N'8d8265c9399d9e3bpow5q6hk3', NULL, CAST(N'2020-07-12T12:10:42.630' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (4, N'tc.png', N'tc-png', N'/uploads/072020/tc_ad27ee45.png', N'8d8265c9a146b3bqti2fe84si', NULL, CAST(N'2020-07-12T12:10:52.297' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (5, N'mov_bbb.mp4', N'mov_bbb-mp4', N'/uploads/file/072020/mov_bbb_f33b1bd9.mp4', N'8d8265ca80a49d7j8ifpn4elp', NULL, CAST(N'2020-07-12T12:11:16.647' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (6, N'qc6', N'qc6-png', N'/uploads/072020/qc6_ba25edd3.PNG', N'Advertisement', NULL, CAST(N'2020-07-12T13:22:49.340' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (7, N'tc.png', N'tc-png', N'/uploads/072020/tc_9c68ce5b.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-12T16:16:03.120' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (8, N'tc.png', N'tc-png', N'/uploads/072020/tc_f3e2d5b.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-12T16:21:38.067' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (9, N'so5-2020_full.pdf', N'so5-2020_full-pdf', N'/uploads/pdf/072020/so5-2020_full_e152d5b.pdf', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-12T16:21:38.483' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (10, N'tc.png', N'tc-png', N'/uploads/072020/tc_f5f2d25.png', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T16:21:57.117' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (11, N'Tap chi Moi truong_so 4-2020 (full).pdf', N'tap-chi-moi-truong_so-4-2020-full-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 4-2020 (full)_f3e2d25.pdf', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T16:21:57.170' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (12, N'tc.png', N'tc-png', N'/uploads/072020/tc_7e7deee8.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-12T16:22:10.883' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (13, N'Tap chi Moi truong_so 3-2020.pdf', N'tap-chi-moi-truong_so-3-2020-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 3-2020_7e7deee8.pdf', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-12T16:22:10.963' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (14, N'tc.png', N'tc-png', N'/uploads/072020/tc_7f01ef09.png', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-12T16:22:24.883' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (15, N'Tap chi Moi truong_so 2-2020 (tach QC)_du 4 bia.pdf', N'tap-chi-moi-truong_so-2-2020-tach-qc-_du-4-bia-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 2-2020 (tach QC)_du 4 bia_7f01ef09.pdf', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-12T16:22:25.010' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (16, N'tc.png', N'tc-png', N'/uploads/072020/tc_7d54eeaa.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T16:22:40.093' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (17, N'so 1 2020.pdf', N'so-1-2020-pdf', N'/uploads/pdf/072020/so 1 2020_7e7dedd3.pdf', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T16:22:40.183' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (18, N'tc.png', N'tc-png', N'/uploads/072020/tc_3f351d02.png', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T17:23:02.030' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (19, N'Tap chi Moi truong_so 4-2020 (full).pdf', N'tap-chi-moi-truong_so-4-2020-full-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 4-2020 (full)_3ef31da3.pdf', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T17:23:13.070' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (20, N'Tap chi Moi truong_so 4-2020 (full).pdf', N'tap-chi-moi-truong_so-4-2020-full-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 4-2020 (full)_22432c84.pdf', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T17:31:46.147' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (21, N'tc.png', N'tc-png', N'/uploads/image/072020/tc_43880d6f.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-12T17:35:33.390' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (22, N'tc.png', N'tc-png', N'/uploads/image/072020/tc_3d5f3eb6.png', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-12T17:38:12.013' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (23, N'tc.png', N'tc-png', N'/uploads/image/072020/tc_3dc23e78.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T17:38:34.160' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (24, N'so 1 2020.pdf', N'so-1-2020-pdf', N'/uploads/pdf/072020/so 1 2020_3dc23e78.pdf', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T17:38:34.237' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (25, N'so 1 2020.pdf', N'so-1-2020-pdf', N'/uploads/pdf/072020/so 1 2020_3c363e42.pdf', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T17:38:58.990' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (26, N'Tap chi Moi truong_so 4-2020 (full).pdf', N'tap-chi-moi-truong_so-4-2020-full-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 4-2020 (full)_35cc1d65.pdf', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-12T17:43:38.490' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (27, N'Tap chi Moi truong_so 4-2020 (full).pdf', N'tap-chi-moi-truong_so-4-2020-full-pdf', N'/uploads/pdf/072020/Tap chi Moi truong_so 4-2020 (full)_a97fcefc.pdf', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-12T17:56:18.037' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (28, N'slide3.png', N'slide3-png', N'/uploads/image/072020/slide3_9f5e998.png', N'WebSlide', NULL, CAST(N'2020-07-12T23:28:59.780' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (29, N'slide2.png', N'slide2-png', N'/uploads/image/072020/slide2_382074fd.png', N'WebSlide', NULL, CAST(N'2020-07-12T23:29:06.737' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (30, N'slide1.png', N'slide1-png', N'/uploads/image/072020/slide1_aba2df6.png', N'WebSlide', NULL, CAST(N'2020-07-12T23:29:13.100' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (31, N'banner-top', N'banner-top-png', N'/uploads/072020/banner-top_ac4e5cb1.png', N'Advertisement', NULL, CAST(N'2020-07-12T23:39:01.023' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (32, N'qc4', N'qc4-png', N'/uploads/072020/qc4_7933b13a.PNG', N'Advertisement', NULL, CAST(N'2020-07-14T22:21:20.587' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (33, N'toa damonkk.png', N'toa-damonkk-png', N'/uploads/image/072020/toa damonkk_49f4e7e5.png', N'8d826693a28236cenk5vuygum', NULL, CAST(N'2020-07-17T00:16:57.890' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (34, N'toa damonkk.png', N'toa-damonkk-png', N'/uploads/image/072020/toa damonkk_8b35811b.png', N'8d826693a28236cenk5vuygum', NULL, CAST(N'2020-07-17T00:18:39.590' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (35, N'thong tin bao chi.png', N'thong-tin-bao-chi-png', N'/uploads/image/072020/thong tin bao chi_4fcc992b.png', N'8d82668cbd6f4f9hi62px3epf', NULL, CAST(N'2020-07-17T00:19:52.500' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (36, N'gap bc 3.png', N'gap-bc-3-png', N'/uploads/image/072020/gap bc 3_d44cc3f5.png', N'8d829e74cd107e72x1u669t4w', NULL, CAST(N'2020-07-17T00:22:27.837' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (37, N'giang 25.png', N'giang-25-png', N'/uploads/image/072020/giang 25_b7b5dc98.png', N'8d825f98ac425e3g55x1wvout', NULL, CAST(N'2020-07-17T00:23:56.297' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (38, N'vũ việt hiếu.png', N'vu-viet-hieu-png', N'/uploads/image/072020/vũ việt hiếu_23b36ab3.png', N'8d829e80fc39fd2n7vfycfe6n', NULL, CAST(N'2020-07-17T00:27:06.287' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (39, N'tram qtaa.png', N'tram-qtaa-png', N'/uploads/image/072020/tram qtaa_39dd6cac.png', N'8d825f982623ac78bpj8wec6i', NULL, CAST(N'2020-07-17T00:27:56.987' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (40, N'đảng bộ 5.png', N'dang-bo-5-png', N'/uploads/image/072020/đảng bộ 5_8b34fdf8.png', N'8d825f9773ecb82fkrqpb2cdk', NULL, CAST(N'2020-07-17T00:28:39.813' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (41, N'cay xanh.png', N'cay-xanh-png', N'/uploads/image/072020/cay xanh_502f08d9.png', N'8d825f9efa9ca79zrcobr67vd', NULL, CAST(N'2020-07-17T00:31:12.800' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (42, N'các bon vĩnh phúc.png', N'cac-bon-vinh-phuc-png', N'/uploads/image/072020/các bon vĩnh phúc_f82f39b7.png', N'8d825f9f7727c33do8tvm41b7', NULL, CAST(N'2020-07-17T00:33:43.377' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (43, N'cong trinh xanh 2.png', N'cong-trinh-xanh-2-png', N'/uploads/image/072020/cong trinh xanh 2_250ed341.png', N'8d825f9fe2f0b99ume7od7sjp', NULL, CAST(N'2020-07-17T00:35:16.437' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (44, N'cong trinh xanh 1.png', N'cong-trinh-xanh-1-png', N'/uploads/image/072020/cong trinh xanh 1_7bb2b659.png', N'8d825f9fe2f0b99ume7od7sjp', NULL, CAST(N'2020-07-17T00:35:52.820' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (45, N'chau á lựa chọn.png', N'chau-a-lua-chon-png', N'/uploads/image/072020/chau á lựa chọn_b6866997.png', N'8d825f9a4e0e20b4k3xmpc7sk', NULL, CAST(N'2020-07-17T00:38:15.407' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (46, N'NL mat troi.png', N'nl-mat-troi-png', N'/uploads/image/072020/NL mat troi_eacf779e.png', N'8d829e9d1b022d7igrozxbd5a', NULL, CAST(N'2020-07-17T00:40:08.847' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (47, N'thực trạng chăn nuôi.png', N'thuc-trang-chan-nuoi-png', N'/uploads/image/072020/thực trạng chăn nuôi_24dc71ec.png', N'8d829ea053343cfzwpk851ssf', NULL, CAST(N'2020-07-17T00:41:30.503' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (48, N'noi nha pin.png', N'noi-nha-pin-png', N'/uploads/image/072020/noi nha pin_4ed277ee.png', N'8d829ea42f8f6a3iowzangqt9', NULL, CAST(N'2020-07-17T00:43:09.677' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (49, N'nghien gia 2.jpg', N'nghien-gia-2-jpg', N'/uploads/image/072020/nghien gia 2_65880ebd.jpg', N'8d825f9c2db113b9u6mkx4wne', NULL, CAST(N'2020-07-17T00:45:00.240' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (50, N'onbm2.png', N'onbm2-png', N'/uploads/image/072020/onbm2_23b24237.png', N'8d829eaddbf57eb6cdsr8jh6b', NULL, CAST(N'2020-07-17T00:47:04.860' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (51, N'nhâm 5.png', N'nham-5-png', N'/uploads/image/072020/nhâm 5_1e6f0965.png', N'8d825f9926f04c3j177bwj8de', NULL, CAST(N'2020-07-17T00:52:13.047' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (52, N'nhâm 5.png', N'nham-5-png', N'/uploads/image/072020/nhâm 5_c7cb26d1.png', N'8d825f9926f04c3j177bwj8de', NULL, CAST(N'2020-07-17T00:52:53.073' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (53, N'nhâm 5.png', N'nham-5-png', N'/uploads/image/072020/nhâm 5_4ed1f409.png', N'8d825f999bf51aerqm76euf6x', NULL, CAST(N'2020-07-17T00:53:07.200' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (54, N'toa damonkk.png', N'toa-damonkk-png', N'/uploads/image/072020/toa damonkk_f82e1175.png', N'8d825f999bf51aerqm76euf6x', NULL, CAST(N'2020-07-17T00:53:47.403' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (55, N'Jun jung jăng.png', N'jun-jung-jang-png', N'/uploads/image/072020/Jun jung jăng_39dbc06a.png', N'8d82907f626b608hhy1ryq7di', NULL, CAST(N'2020-07-17T00:57:53.330' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (56, N'6.png', N'6-png', N'/uploads/image/072020/6_6d43a161.png', N'8d8265c84f3903duol8n2i65i', NULL, CAST(N'2020-07-17T02:27:09.270' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (57, N'3.png', N'3-png', N'/uploads/image/072020/3_3ad005ef.png', N'8d8265c9399d9e3bpow5q6hk3', NULL, CAST(N'2020-07-17T02:28:33.167' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (58, N'6 (1).png', N'6-1-png', N'/uploads/image/072020/6 (1)_560c7e2a.png', N'8d8265c9a146b3bqti2fe84si', NULL, CAST(N'2020-07-17T02:29:44.727' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (59, N'gtd3.jpg', N'gtd3-jpg', N'/uploads/image/072020/gtd3_62dd2f7e.jpg', N'8d829fa1642a517n9bxcfqium', NULL, CAST(N'2020-07-17T02:36:39.523' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (60, N'3 (1).png', N'3-1-png', N'/uploads/image/072020/3 (1)_fded1e8d.png', N'8d829fa3d04e226j75vdt6h8b', NULL, CAST(N'2020-07-17T02:38:25.900' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (61, N'tc12.jpg', N'tc12-jpg', N'/uploads/image/072020/tc12_152b552c.jpg', N'8d829fa7c426a10sdgwecrovt', NULL, CAST(N'2020-07-17T02:39:58.513' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (62, N'Screenshot_5.png', N'screenshot_5-png', N'/uploads/image/072020/Screenshot_5_32f8a42.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:01:47.803' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (63, N'Screenshot_6.png', N'screenshot_6-png', N'/uploads/image/072020/Screenshot_6_206eb6cc.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-17T03:03:29.417' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (64, N'Screenshot_7.png', N'screenshot_7-png', N'/uploads/image/072020/Screenshot_7_3baaa625.png', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-17T03:05:00.457' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (65, N'Screenshot_8.png', N'screenshot_8-png', N'/uploads/image/072020/Screenshot_8_206d9508.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-17T03:05:09.890' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (66, N'Screenshot_9.png', N'screenshot_9-png', N'/uploads/image/072020/Screenshot_9_dd1d5183.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:06:41.047' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (67, N'Screenshot_10.png', N'screenshot_10-png', N'/uploads/image/072020/Screenshot_10_3ba9a2e8.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-17T03:07:50.163' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (68, N'Screenshot_11.png', N'screenshot_11-png', N'/uploads/image/072020/Screenshot_11_3bb1ba0d.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-17T03:08:50.450' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (69, N'Screenshot_12.png', N'screenshot_12-png', N'/uploads/image/072020/Screenshot_12_68499188.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:10:21.790' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (70, N'Screenshot_13.png', N'screenshot_13-png', N'/uploads/image/072020/Screenshot_13_ab98da52.png', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-17T03:11:19.937' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (71, N'chuyen de TA 1-2020 (1).pdf', N'chuyen-de-ta-1-2020-1-pdf', N'/uploads/pdf/072020/chuyen de TA 1-2020 (1)_51731475.pdf', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:12:42.670' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (72, N'Screenshot_14.png', N'screenshot_14-png', N'/uploads/image/072020/Screenshot_14_5172a198.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-17T03:13:02.187' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (73, N'Screenshot_15.png', N'screenshot_15-png', N'/uploads/image/072020/Screenshot_15_ab974631.png', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-17T03:14:59.163' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (74, N'Screenshot_16.png', N'screenshot_16-png', N'/uploads/image/072020/Screenshot_16_6846f5a9.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-17T03:15:42.020' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (75, N'Screenshot_17.png', N'screenshot_17-png', N'/uploads/image/072020/Screenshot_17_469df8d2.png', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:17:35.653' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (76, N'CD2 online.pdf', N'cd2-online-pdf', N'/uploads/pdf/072020/CD2 online_469df8d2.pdf', N'8d825efc785827bsqq1hdug66', NULL, CAST(N'2020-07-17T03:17:35.653' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (77, N'Screenshot_18.png', N'screenshot_18-png', N'/uploads/image/072020/Screenshot_18_e8194fb6.png', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-17T03:18:34.587' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (78, N'CĐ TV1-2020 .pdf', N'cd-tv1-2020-pdf', N'/uploads/pdf/072020/CĐ TV1-2020 _e8194fb6.pdf', N'8d825efc2b3522flyrlo7ervw', NULL, CAST(N'2020-07-17T03:18:34.587' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (79, N'Screenshot_19.png', N'screenshot_19-png', N'/uploads/image/072020/Screenshot_19_9c09ae9.png', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-17T03:19:50.923' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (80, N'So CD TV 4-2019.pdf', N'so-cd-tv-4-2019-pdf', N'/uploads/pdf/072020/So CD TV 4-2019_9c09ae9.pdf', N'8d825ef934eedefz7fkdgpe61', NULL, CAST(N'2020-07-17T03:19:50.940' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (81, N'Screenshot_20.png', N'screenshot_20-png', N'/uploads/image/072020/Screenshot_20_ebed2f05.png', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-17T03:20:52.717' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (82, N'So CD TV 3-2019.pdf', N'so-cd-tv-3-2019-pdf', N'/uploads/pdf/072020/So CD TV 3-2019_ebed2f05.pdf', N'8d825ee2a62ae8aufurp87fr1', NULL, CAST(N'2020-07-17T03:20:52.730' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (83, N'Screenshot_21.png', N'screenshot_21-png', N'/uploads/image/072020/Screenshot_21_d5174256.png', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-17T03:21:41.297' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (84, N'So CD TV 2-2019.pdf', N'so-cd-tv-2-2019-pdf', N'/uploads/pdf/072020/So CD TV 2-2019_d5174256.pdf', N'8d825ca807ecdcfu6ys5k94et', NULL, CAST(N'2020-07-17T03:21:41.310' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (85, N'html__0015_Layer-43', N'html__0015_layer-43-png', N'/uploads/072020/html__0015_Layer-43_166776d9.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:24:40.670' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (86, N'html__0014_Layer-44', N'html__0014_layer-44-png', N'/uploads/072020/html__0014_Layer-44_f9d09004.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:25:39.257' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (87, N'html__0011_Layer-35', N'html__0011_layer-35-png', N'/uploads/072020/html__0011_Layer-35_4f188521.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:27:21.987' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (88, N'logo_Đảng', N'logo_dang-jpg', N'/uploads/072020/logo_Đảng_a681840a.jpg', N'Advertisement', NULL, CAST(N'2020-07-17T11:39:18.523' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (89, N'HSTL', N'hstl-png', N'/uploads/072020/HSTL_7b2f91f2.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:39:36.663' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (90, N'bvmt ntm-01', N'bvmt-ntm-01-png', N'/uploads/072020/bvmt ntm-01_f99b999f.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:41:50.240' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (91, N'lien he qc a Bach-02', N'lien-he-qc-a-bach-02-png', N'/uploads/072020/lien he qc a Bach-02_39bba016.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:43:33.227' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (92, N'html__0010_Layer-38', N'html__0010_layer-38-png', N'/uploads/072020/html__0010_Layer-38_f3607114.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:46:14.460' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (93, N'html__0009_Layer-39', N'html__0009_layer-39-png', N'/uploads/072020/html__0009_Layer-39_e34979b8.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:47:13.970' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (94, N'html__0001_Layer-19', N'html__0001_layer-19-png', N'/uploads/072020/html__0001_Layer-19_e9b6bc0.png', N'Advertisement', NULL, CAST(N'2020-07-17T11:47:31.850' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (95, N'ht giang huong.png', N'ht-giang-huong-png', N'/uploads/image/072020/ht giang huong_7c2a3cea.png', N'8d82eb2815fd98f7qzc8fqcs3', NULL, CAST(N'2020-07-23T02:46:06.663' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (96, N'ht giang huong.png', N'ht-giang-huong-png', N'/uploads/image/072020/ht giang huong_1e846c29.png', N'8d82eb2815fd98f7qzc8fqcs3', NULL, CAST(N'2020-07-23T02:47:41.687' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (97, N'wetland.jpg', N'wetland-jpg', N'/uploads/072020/wetland_4f07e30c.jpg', N'8d82eb74478f97cb4k2dmg6tr', NULL, CAST(N'2020-07-23T03:20:09.320' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (98, N'Nh%c3%a0%20kh%c3%b4ng%20r%c3%a1c.jpg', N'nh-c3-a0-20kh-c3-b4ng-20r-c3-a1c-jpg', N'/uploads/072020/Nh%c3%a0%20kh%c3%b4ng%20r%c3%a1c_ce119b7b.jpg', N'8d832429fc7c3a6slnnskjjnn', NULL, CAST(N'2020-07-27T15:35:30.123' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (99, N'Nhà không rác.jpg', N'nha-khong-rac-jpg', N'/uploads/image/072020/Nhà không rác_1b622ac4.jpg', N'8d832429fc7c3a6slnnskjjnn', NULL, CAST(N'2020-07-27T15:37:06.173' AS DateTime), N'admin', N'image/jpeg')
GO
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (100, N'bc1.jpg', N'bc1-jpg', N'/uploads/image/072020/bc1_631f16f5.jpg', N'8d8324321285cc5v88jdqho15', NULL, CAST(N'2020-07-27T15:39:14.723' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (101, N'sxanh.jpg', N'sxanh-jpg', N'/uploads/image/072020/sxanh_a46f83d2.jpg', N'8d8324387c60d55i2cp9l2j2u', NULL, CAST(N'2020-07-27T15:41:56.147' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (102, N'sách xanh.jpg', N'sach-xanh-jpg', N'/uploads/image/072020/sách xanh_b5449e22.jpg', N'8d83243b23ba3cbm2y4yovole', NULL, CAST(N'2020-07-27T15:43:14.423' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (103, N'đồ án yên bái.png', N'do-an-yen-bai-png', N'/uploads/image/072020/đồ án yên bái_65dc2cbc.png', N'8d8324615405e26co3y3ktxo2', NULL, CAST(N'2020-07-27T16:00:10.807' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (104, N'fris%202.png', N'fris-202-png', N'/uploads/082020/fris%202_89135ed6.png', N'8d836cfc96b0d7dww829zsdsb', NULL, CAST(N'2020-08-02T10:36:21.457' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (105, N'fris%202.png', N'fris-202-png', N'/uploads/082020/fris%202_139d7bde.png', N'8d836cfc96b0d7dww829zsdsb', NULL, CAST(N'2020-08-02T10:36:33.737' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (106, N'fris 2.png', N'fris-2-png', N'/uploads/image/082020/fris 2_37269b32.png', N'8d836cfc96b0d7dww829zsdsb', NULL, CAST(N'2020-08-02T10:37:01.903' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (107, N'vidan 1.png', N'vidan-1-png', N'/uploads/image/082020/vidan 1_46da1858.png', N'8d836d012681dbdkp8iojiigb', NULL, CAST(N'2020-08-02T10:38:28.413' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (108, N'vidan 1.png', N'vidan-1-png', N'/uploads/image/082020/vidan 1_b9448d02.png', N'8d836d012681dbdkp8iojiigb', NULL, CAST(N'2020-08-02T10:39:32.657' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (109, N'business.jpg', N'business-jpg', N'/uploads/image/082020/business_8e59d189.jpg', N'8d836d079d832b93zdgv1k8i5', NULL, CAST(N'2020-08-02T10:41:10.647' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (110, N'1.png', N'1-png', N'/uploads/image/082020/1_d4bac768.png', N'8d8265c9399d9e3bpow5q6hk3', NULL, CAST(N'2020-08-11T18:33:09.303' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (111, N'2.png', N'2-png', N'/uploads/image/082020/2_af67d75e.png', N'8d8265c9399d9e3bpow5q6hk3', NULL, CAST(N'2020-08-11T18:41:07.470' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (112, N'banner-new', N'banner-new-jpg', N'/uploads/082020/banner-new_3f7ec63c.jpg', N'Advertisement', NULL, CAST(N'2020-08-12T17:23:34.893' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (113, N'gef2.jpg', N'gef2-jpg', N'/uploads/image/082020/gef2_67a650aa.jpg', N'8d8265c9a146b3bqti2fe84si', NULL, CAST(N'2020-08-12T19:32:20.543' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (114, N'keny%202.png', N'keny-202-png', N'/uploads/082020/keny%202_8cd39d70.png', N'WebModule', NULL, CAST(N'2020-08-12T19:46:55.253' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (115, N'keny 2.png', N'keny-2-png', N'/uploads/image/082020/keny 2_92d37d98.png', N'WebModule', NULL, CAST(N'2020-08-12T19:47:35.930' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (116, N'keny 2.png', N'keny-2-png', N'/uploads/image/082020/keny 2_448c2ec4.png', N'8d83ef907d93bbe8ix76ppnjh', NULL, CAST(N'2020-08-12T19:51:50.820' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (117, N'ninh tc.png', N'ninh-tc-png', N'/uploads/image/082020/ninh tc_2db7d131.png', N'8d83ef94ed8a02cwli53j3ofu', NULL, CAST(N'2020-08-12T19:53:33.657' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (118, N'banner_top.jpg', N'banner_top-jpg', N'/uploads/image/082020/banner_top_abd11506.jpg', N'8d84302ecbad882k2nbymkfhq', NULL, CAST(N'2020-08-17T23:13:10.400' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (119, N'anh_tin.PNG', N'anh_tin-png', N'/uploads/image/082020/anh_tin_5057a719.PNG', N'8d84304316b1568gqyirvcxfd', NULL, CAST(N'2020-08-17T23:23:45.837' AS DateTime), N'writer1', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (120, N'anh_tin_2.PNG', N'anh_tin_2-png', N'/uploads/image/082020/anh_tin_2_76981acf.PNG', N'8d84305832bdb08a5xsx3xsfu', NULL, CAST(N'2020-08-17T23:32:16.043' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (121, N'banner_top.jpg', N'banner_top-jpg', N'/uploads/image/082020/banner_top_eda913ce.jpg', N'8d8430864717ae4nbc2j5e5lq', NULL, CAST(N'2020-08-17T23:51:16.533' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (122, N'newlogo', N'newlogo-png', N'/uploads/082020/newlogo_83a313f.png', N'Advertisement', NULL, CAST(N'2020-08-19T18:40:57.513' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (123, N'123.png', N'123-png', N'/uploads/image/082020/123_296bd4ff.png', N'8d84497217eaefcnbrioc4nqr', NULL, CAST(N'2020-08-19T23:25:38.927' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (124, N'sample.png', N'sample-png', N'/uploads/file/082020/sample_7e7a4388.png', N'8d84498731ee45emg3sqy4xdx', NULL, CAST(N'2020-08-19T23:35:57.147' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (125, N'banner-new_3f7ec63c.jpg', N'banner-new_3f7ec63c-jpg', N'/uploads/image/082020/banner-new_3f7ec63c_7e7a4388.jpg', N'8d84498731ee45emg3sqy4xdx', NULL, CAST(N'2020-08-19T23:35:57.417' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (126, N'234.PNG', N'234-png', N'/uploads/image/082020/234_ddb33fed.PNG', N'8d8449944fccc5asd2lmskhte', NULL, CAST(N'2020-08-19T23:42:55.370' AS DateTime), N'writer1', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (127, N'345.PNG', N'345-png', N'/uploads/image/082020/345_c8e52b21.PNG', N'8d844999c427757kegbhis5l1', NULL, CAST(N'2020-08-19T23:44:17.023' AS DateTime), N'writer1', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (128, N'banner_center', N'banner_center-png', N'/uploads/082020/banner_center_98bdabdb.PNG', N'Advertisement', NULL, CAST(N'2020-08-19T23:54:09.870' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (129, N'444.PNG', N'444-png', N'/uploads/image/082020/444_25046f35.PNG', N'8d844a04577c126kc8t657fe9', NULL, CAST(N'2020-08-20T00:33:28.130' AS DateTime), N'tongbientap', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (130, N'ntk2.PNG', N'ntk2-png', N'/uploads/image/082020/ntk2_92afbc20.PNG', N'8d846d2ddec9f0fgq8ffiy9wp', NULL, CAST(N'2020-08-22T19:38:14.583' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (131, N'anh_ava.PNG', N'anh_ava-png', N'/uploads/image/082020/anh_ava_937ca75d.PNG', N'8d84ae11b1e7809iu1e18il1e', NULL, CAST(N'2020-08-27T23:36:20.547' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (132, N'3333.PNG', N'3333-png', N'/uploads/image/082020/3333_8b105d5b.PNG', N'8d84ae11b1e7809iu1e18il1e', NULL, CAST(N'2020-08-27T23:39:29.687' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (133, N'anh_ava (1).png', N'anh_ava-1-png', N'/uploads/image/082020/anh_ava (1)_937f6c9b.png', N'8d84ae11b1e7809iu1e18il1e', NULL, CAST(N'2020-08-27T23:46:25.107' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (134, N'anh_ava (1).png', N'anh_ava-1-png', N'/uploads/image/082020/anh_ava (1)_612f72d9.png', N'8d84ae43d22e269gd78z5b8bg', NULL, CAST(N'2020-08-27T23:55:43.520' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (135, N'anh_ava (2).png', N'anh_ava-2-png', N'/uploads/image/082020/anh_ava (2)_616dec2.png', N'8d84ae43d22e269gd78z5b8bg', NULL, CAST(N'2020-08-28T00:04:27.510' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (136, N'banner-middle', N'4179-jpg_wh860-png', N'/uploads/082020/4179.jpg_wh860_861e37d7.png', N'Advertisement', NULL, CAST(N'2020-08-28T13:50:31.697' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (137, N'5.6.2020.jpg', N'5-6-2020-jpg', N'/uploads/video/092020/5.6.2020_3907d55.jpg', N'8d8265c9a146b3bqti2fe84si', NULL, CAST(N'2020-09-10T18:34:30.257' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (138, N'banner-tcmt', N'banner-tcmt-jpg', N'/uploads/092020/banner-tcmt_834e50db.jpg', N'Advertisement', NULL, CAST(N'2020-09-16T13:46:01.890' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (139, N'banner-tcmt-2', N'banner-tcmt-2-jpg', N'/uploads/092020/banner-tcmt-2_c24d6c3c.jpg', N'Advertisement', NULL, CAST(N'2020-09-16T14:16:08.737' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (140, N'banner-tcmt-3', N'banner-tcmt-3-jpg', N'/uploads/092020/banner-tcmt-3_d91dddd.jpg', N'Advertisement', NULL, CAST(N'2020-09-16T14:31:26.837' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (141, N'banner-tcmt-4', N'banner-tcmt-4-jpg', N'/uploads/092020/banner-tcmt-4_dc40ced2.jpg', N'Advertisement', NULL, CAST(N'2020-09-16T15:02:06.133' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (142, N'Requirement.PNG', N'requirement-png', N'/uploads/image/092020/Requirement_182e4277.PNG', N'8d85a98b835c4a1kyshthiqun', NULL, CAST(N'2020-09-16T23:32:25.267' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (143, N'mov_bbb_f33b1bd9.mp4', N'mov_bbb_f33b1bd9-mp4', N'/uploads/video/092020/mov_bbb_f33b1bd9_4d2db78e.mp4', NULL, NULL, CAST(N'2020-09-17T11:43:14.247' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (144, N'mov_bbb_f33b1bd9.mp4', N'mov_bbb_f33b1bd9-mp4', N'/uploads/video/092020/mov_bbb_f33b1bd9_c92c42f3.mp4', NULL, NULL, CAST(N'2020-09-17T11:44:26.600' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (145, N'mov_bbb_f33b1bd9.mp4', N'mov_bbb_f33b1bd9-mp4', N'#', NULL, NULL, CAST(N'2020-09-17T11:51:45.773' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (146, N'mov_bbb_f33b1bd9.mp4', N'mov_bbb_f33b1bd9-mp4', NULL, NULL, NULL, CAST(N'2020-09-17T12:46:56.787' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (147, N'sample-mp4-file.mp4', N'sample-mp4-file-mp4', N'#', NULL, NULL, CAST(N'2020-09-18T11:01:16.370' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (148, N'sample-mp4-file.mp4', N'sample-mp4-file-mp4', N'#', NULL, NULL, CAST(N'2020-09-18T11:01:48.303' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (149, N'sample-mp4-file.mp4', N'sample-mp4-file-mp4', N'#', NULL, NULL, CAST(N'2020-09-18T11:02:39.800' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (150, N'banner2', N'banner2-jpg', N'/uploads/102020/banner2_13bcf4f0.jpg', N'Advertisement', NULL, CAST(N'2020-10-08T15:48:41.977' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (151, N'banner-middle', N'banner-middle-png', N'/uploads/102020/banner-middle_2b0c720a.PNG', N'Advertisement', NULL, CAST(N'2020-10-13T17:32:48.123' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (152, N'Môi trường & Phát triển bền vững số 5 -2 017.mp4', N'moi-truong--phat-trien-ben-vung-so-5-2-017-mp4', N'/uploads/file/102020/Môi trường & Phát triển bền vững số 5 -2 017_95c6c91a.mp4', N'8d870650f411920cty6w6eie8', NULL, CAST(N'2020-10-14T17:21:26.837' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (153, N'sampletest.mp4', N'sampletest-mp4', N'/uploads/file/102020/sampletest_8b60e54c.mp4', N'8d870661d6864693x3z5k58ti', NULL, CAST(N'2020-10-14T17:27:24.300' AS DateTime), N'admin', N'video/mp4')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (154, N'2015.PNG', N'2015-png', N'/uploads/image/102020/2015_d6488a43.PNG', N'8d8768d3c53cc52shqiem1kkv', NULL, CAST(N'2020-10-22T13:20:42.900' AS DateTime), N'admin', N'image/png')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (155, N'Moi truong so 3-2015_full.pdf', N'moi-truong-so-3-2015_full-pdf', N'/uploads/pdf/102020/Moi truong so 3-2015_full_24016b7e.pdf', N'8d8768d3c53cc52shqiem1kkv', NULL, CAST(N'2020-10-22T13:20:43.227' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (156, N'api2 (1).pdf', N'api2-1-pdf', N'/uploads/pdf/102020/api2 (1)_eff29e41.pdf', N'8d876b8dde2fa4cqd5r4r726z', NULL, CAST(N'2020-10-22T18:33:16.543' AS DateTime), N'admin', N'application/pdf')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (157, N'unnamed.jpg', N'unnamed-jpg', N'/uploads/image/102020/unnamed_cf565846.jpg', N'8d829fa3d04e226j75vdt6h8b', NULL, CAST(N'2020-10-22T23:19:08.560' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (158, N'unnamed.jpg', N'unnamed-jpg', N'/uploads/image/102020/unnamed_d6aef19d.jpg', N'8d829fa1642a517n9bxcfqium', NULL, CAST(N'2020-10-23T00:07:19.647' AS DateTime), N'admin', N'image/jpeg')
INSERT [dbo].[WebContentUploads] ([ID], [Title], [MetaTitle], [FullPath], [UID], [FolderID], [CreatedDate], [CreatedBy], [MimeType]) VALUES (159, N'sample.pdf', N'sample-pdf', N'/uploads/pdf/112020/sample_a88530cd.pdf', N'8d888df9441052832ps1fk41s', NULL, CAST(N'2020-11-14T20:56:04.723' AS DateTime), N'admin', N'application/pdf')
SET IDENTITY_INSERT [dbo].[WebContentUploads] OFF
SET IDENTITY_INSERT [dbo].[WebModules] ON 

INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (86, N'Trang chủ', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'trang-chu', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (87, N'Phân quyền', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'phan-quyen', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (89, N'Chức năng khoá sổ', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'khoa-so', NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (90, N'Danh mục cửa hàng', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'danh-muc-cua-hang', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (91, N'Danh mục khách hàng', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'danh-muc-khach-hang', NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (92, N'Danh mục nhà cung cấp', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'danh-muc-nha-cung-cap', NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (93, N'Danh mục hàng hoá', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'danh-muc-hang-hoa', NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (94, N'Danh mục người dùng', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'danh-muc-nguoi-dung', NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (95, N'Giá niêm yết', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'gia-niem-yet', NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (96, N'Giá bán', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'gia-ban', NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (97, N'Quản lý hoa hồng', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'quan-ly-hoa-hong', NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (98, N'Đơn nhập hàng', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'don-nhap-hang', NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, N'vi-VN', NULL, NULL, NULL, N'_self')
INSERT [dbo].[WebModules] ([ID], [Title], [Description], [Body], [Image], [ParentID], [ContentTypeID], [URL], [SeoTitle], [MetaTitle], [MetaKeywords], [MetaDescription], [Order], [UID], [IndexView], [IndexLayout], [PublishIndexView], [PublishIndexLayout], [PublishDetailView], [PublishDetailLayout], [Status], [SubQuerys], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowOnMenu], [ShowOnAdmin], [Culture], [Icon], [CodeColor], [ActiveArticle], [Target]) VALUES (99, N'Cước vận chuyển', NULL, NULL, NULL, NULL, N'OnePage', NULL, NULL, N'cuoc-van-chuyen', NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-11-26T10:50:48.223' AS DateTime), 1, 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[WebModules] OFF
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(N'2013-10-04T10:20:13.493' AS DateTime), NULL, 1, CAST(N'2020-12-23T04:54:36.840' AS DateTime), 0, N'ADhITS3fpmzNqCyEnL8ykrGDJXtce818LzwcsmRtDwf2rpmD22axS6TYDzs0Jpo9GQ==', CAST(N'2020-12-18T10:17:24.020' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (10, CAST(N'2020-10-21T17:47:39.703' AS DateTime), NULL, 1, NULL, 0, N'AGeiGS3hEhK/z+iLpnw4FEQDlPNGclaEuojqwFdswlltc7NgAyVGtSmDT5oDegSQ9g==', CAST(N'2020-10-21T17:47:39.703' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (11, CAST(N'2020-10-21T17:48:05.573' AS DateTime), NULL, 1, NULL, 0, N'AAhdnji9TmaepN/ZOd427vtx620UgAu+JnsBSS4JVziHidsr3m7DY7H6VpAJuNKwJg==', CAST(N'2020-10-21T17:48:05.573' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (33, CAST(N'2020-12-04T04:16:07.137' AS DateTime), NULL, 1, NULL, 0, N'AJo8ouPjhrHPe90orz10vLJFOZI3GkjN3fXlQI/RN8VA7a4Kv61yWQbSHVy13Bc/gg==', CAST(N'2020-12-04T04:16:07.137' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (34, CAST(N'2020-12-04T10:51:34.357' AS DateTime), NULL, 1, CAST(N'2020-12-19T00:01:43.540' AS DateTime), 0, N'ADjL35mrHYDqaL1BDCa6+eDTAFWVNStP+JwF3h7RLqbRYNRO2skJTl0uj4Go+twuMQ==', CAST(N'2020-12-16T08:24:34.167' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (35, CAST(N'2020-12-04T11:22:39.997' AS DateTime), NULL, 1, NULL, 0, N'ALAWWqGOk+7waw6ZV1ogTHjtMpx+/l0f61A3b9NfYDFh2lIu87DW5K+KEhFiqqvYdQ==', CAST(N'2020-12-04T11:22:39.997' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (36, CAST(N'2020-12-07T12:28:35.763' AS DateTime), NULL, 1, NULL, 0, N'APQQCdPzDQw/gO5TQZ3UHkvOsIB5QGFUywoI+vorKlf+qEYD1gvVCKHmap3ts86nNA==', CAST(N'2020-12-07T12:28:35.763' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (37, CAST(N'2020-12-07T14:58:22.430' AS DateTime), NULL, 1, NULL, 0, N'AG4/zwMuFnCp+g+0XhtnMkI/ehqsK5DBpf6y8pB/p3obckgfZQhlTcdU6t73CM2Q0Q==', CAST(N'2020-12-07T14:58:22.430' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (38, CAST(N'2020-12-08T03:55:10.987' AS DateTime), NULL, 1, NULL, 0, N'AKGv8Ky2G7qMRn+dh1R69dY6U5RjGxe1tzaMOxQvhnnO50rm/bq7puVDSXpK9xD/Pg==', CAST(N'2020-12-08T03:55:10.987' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (39, CAST(N'2020-12-08T04:00:19.073' AS DateTime), NULL, 1, NULL, 0, N'APeEXj7DuFcGFnMQzGx0Wt1FMV8HCbJu6GutXH02PYStD2Ebux0VPvgCvTtaea88Hg==', CAST(N'2020-12-08T04:00:19.073' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (40, CAST(N'2020-12-08T04:41:15.233' AS DateTime), NULL, 1, NULL, 0, N'AMaSWBq3KJx3YMVaHKQ+Ma14nuU+7EZbckkjyAah+bAU/hV4kMCdUp80l0tSBaew+g==', CAST(N'2020-12-08T04:41:15.233' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (41, CAST(N'2020-12-08T08:51:09.143' AS DateTime), NULL, 1, NULL, 0, N'ANwLX08XfP9q1zhcWMmwvnPiDQNUTv9mVagJet7mjnnBwauLwM5xQ8swmp5C0tWrzw==', CAST(N'2020-12-08T08:51:09.143' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (42, CAST(N'2020-12-08T08:53:58.027' AS DateTime), NULL, 1, NULL, 0, N'AKkLNooXoS73rX/D9h9shFVL28ffajAgUBm3ixyaarCqggp8INo0qsGj3NHdp4Hrsw==', CAST(N'2020-12-08T08:53:58.027' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (43, CAST(N'2020-12-08T08:56:03.090' AS DateTime), NULL, 1, NULL, 0, N'ACeKGU2ESn7GuWRskrDoqq9UMHGmXLoGbwqjuUz5Q4p65mPsrItrmshGEURH+WxooQ==', CAST(N'2020-12-08T08:56:03.090' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (44, CAST(N'2020-12-08T12:14:41.753' AS DateTime), NULL, 1, NULL, 0, N'AME+tUlOLPaf+XcyP+tQuooUHgaK9tpD/boZnm1C7i5m1RuCEoeMEaUZFaW47UDpjw==', CAST(N'2020-12-08T12:14:41.753' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (45, CAST(N'2020-12-08T12:15:31.287' AS DateTime), NULL, 1, NULL, 0, N'APbwB6wbzEytJOsXFxnWshGSOt+MFffeQmqNojijTQLkgS298md7pzoDgrWKbbA4rg==', CAST(N'2020-12-08T12:15:31.287' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (46, CAST(N'2020-12-08T12:25:00.083' AS DateTime), NULL, 1, NULL, 0, N'AO6cM/pCbvNmsSyMjHhTYIygvC5wOtlBAwIhRhxho7TCbAk4uXKgT8JZfR4ATKVKSA==', CAST(N'2020-12-08T12:25:00.083' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (47, CAST(N'2020-12-08T12:31:49.000' AS DateTime), NULL, 1, NULL, 0, N'APNCNTTh0VW+KCE2X3KQtCqyVy56DRgOOZkVStKoTHqb2ZeR7MqJb2Hci7xKKl2oxQ==', CAST(N'2020-12-08T12:31:49.000' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (48, CAST(N'2020-12-08T12:36:22.637' AS DateTime), NULL, 1, NULL, 0, N'AEuKiLURfObc7XG613GF/h5FzxY+DxCETTeQak7BenjvQuth7wNzvXmLXlwzr9ys0A==', CAST(N'2020-12-08T12:36:22.637' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (49, CAST(N'2020-12-08T12:46:54.223' AS DateTime), NULL, 1, NULL, 0, N'AEelzMF/VTZRQRde919CMU+4ZztgIC8ggYAwikdyUKOOBtLNuJvCYBfxpbIyAAej/g==', CAST(N'2020-12-08T12:46:54.223' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (50, CAST(N'2020-12-09T04:35:53.677' AS DateTime), NULL, 1, NULL, 0, N'ACEb6m/3FVIZZuUnibKHF0m1djcGzsYSWKt1jHLa27LW01Is4n25cutdGN+msacfFw==', CAST(N'2020-12-09T04:35:53.677' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (51, CAST(N'2020-12-09T04:40:56.203' AS DateTime), NULL, 1, NULL, 0, N'ABY905N/Bo0bQkLZU+xhzTZGoCPrImfK55H6QXGKibameBHD4tCZVG4vpFsmFP5iUg==', CAST(N'2020-12-09T04:40:56.203' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (52, CAST(N'2020-12-09T04:45:11.960' AS DateTime), NULL, 1, NULL, 0, N'AJkMIUi1J3iRjQoWs/vzTkya0+JwhXLdn4NT+Nb85EivLF57L7F06eIuYqt8eMAhyw==', CAST(N'2020-12-09T04:45:11.960' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (53, CAST(N'2020-12-09T04:46:04.030' AS DateTime), NULL, 1, NULL, 0, N'ADN8da8eENTTFwEC50g+N4/7SBxNOeG7zdbFpzj1YW7BMSCr23MzeLN+DLWPJ241zQ==', CAST(N'2020-12-09T04:46:04.030' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (54, CAST(N'2020-12-09T04:48:13.487' AS DateTime), NULL, 1, NULL, 0, N'ANfDfzX5UMmsLqWvAD/NOg1zK0Kd38Q4nYZitL1w9SfeIM7W4B0Vb03Q2PNnOVyVFA==', CAST(N'2020-12-09T04:48:13.487' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (55, CAST(N'2020-12-09T05:00:24.500' AS DateTime), NULL, 1, NULL, 0, N'AK/2qYUbK73AxJwf28IVlBmeBpIp4WpzX6Ac3N/SzlFJI177unwxb+6DTRae8JjoPQ==', CAST(N'2020-12-09T05:00:24.500' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (56, CAST(N'2020-12-09T05:03:25.503' AS DateTime), NULL, 1, NULL, 0, N'AGtZ1/wdbpzd9BlW5y9kfP0+JRS/ZbWRa/H6R53Y2eHg8gvPiBksovYuW8KXGxKiXw==', CAST(N'2020-12-09T05:03:25.503' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (57, CAST(N'2020-12-09T07:01:13.363' AS DateTime), NULL, 1, NULL, 0, N'AM1Iwa1cGmrDF/QDEyosr+2SYHMpGYZxFh9FPU74DoFhuf2s2QtRqkvjRGxVg7W4Ug==', CAST(N'2020-12-09T07:01:13.363' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (58, CAST(N'2020-12-09T07:01:45.450' AS DateTime), NULL, 1, NULL, 0, N'ACoD9rrhzBT+eWP7I1XRfEPnJZNzoCb2LyIy1P/ctQaI1FwgxZQM4Ko25l/vphv/iw==', CAST(N'2020-12-09T07:01:45.450' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (59, CAST(N'2020-12-09T07:22:32.220' AS DateTime), NULL, 1, NULL, 0, N'AEh5rGpSIef0olSw0sHKRjg2PInQ1+EIo1DSL7xkf6YdDymCRKUHYYRr+dONSJBw7g==', CAST(N'2020-12-09T07:22:32.220' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (60, CAST(N'2020-12-09T07:42:56.920' AS DateTime), NULL, 1, CAST(N'2020-12-10T05:09:43.973' AS DateTime), 0, N'APnGp/mtGhKbi/MtLauTQLOGuyD69dYpwJFxAbzE1FVw7f8yQmupmIfPKQCmh2QPiw==', CAST(N'2020-12-10T05:09:55.787' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (61, CAST(N'2020-12-15T10:56:05.173' AS DateTime), NULL, 1, NULL, 0, N'AILKOjeDkI6995tWsc684p/Gb1+XYAUuenM0v4Jtd4J/Owow05f6YOi6ssix2mrY6Q==', CAST(N'2020-12-15T10:56:05.173' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (62, CAST(N'2020-12-15T11:29:59.197' AS DateTime), NULL, 1, NULL, 0, N'ADHBheneoGZfy5JgRxE02NxSso88e5LpAHsEpWXlOaAjOC2NkW/VOnQD0ZWYiS68OA==', CAST(N'2020-12-15T11:29:59.197' AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (63, CAST(N'2020-12-19T07:11:41.193' AS DateTime), NULL, 1, NULL, 0, N'ADMGhRDubfosCxf05Ves0t6/Fl1km59E9rLgM6ykcIDq5vpR4dBiPrESCeUA4yJPAg==', CAST(N'2020-12-19T07:11:41.193' AS DateTime), N'', NULL, NULL)
SET IDENTITY_INSERT [dbo].[webpages_Roles] ON 

INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName], [Title], [Description]) VALUES (2, N'Administrators', N' ', N' ')
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName], [Title], [Description]) VALUES (3, N'Quản trị chung', N'Người quản lý toàn bộ các chi nhánh', NULL)
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName], [Title], [Description]) VALUES (4, N'Nhân viên cửa hàng', NULL, NULL)
SET IDENTITY_INSERT [dbo].[webpages_Roles] OFF
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (1, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (34, 2)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (60, 4)
SET IDENTITY_INSERT [dbo].[WebSimpleContents] ON 

INSERT [dbo].[WebSimpleContents] ([ID], [Title], [Image], [Link], [Description], [Key], [Body], [MetaTitle], [MetaKeywords], [MetaDescription], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Culture]) VALUES (1, N'Thông tin trang liên hệ', NULL, NULL, NULL, N'ContactInfo', N'<p><strong>C&ocirc;ng Ty TNHH Thương Mại Dịch Vụ Sản Xuất Việt Linh H&agrave; Nội</strong><br />
Địa chỉ: <strong>Th&ocirc;n Đức Trạch, X&atilde; Quất Động, Huyện Thường T&iacute;n, TP H&agrave; Nội</strong><br />
Điện thoại:<strong> 04. 00000000&nbsp;</strong> - Hotline: <strong>000 000 000&nbsp;</strong><br />
Email: <strong>ctyvietlinh.com</strong>&nbsp;|&nbsp;<strong>vietlinhcty2016@gmail.com</strong></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
', NULL, NULL, NULL, N'admin', CAST(N'2013-10-29T22:06:57.330' AS DateTime), N'admin', CAST(N'2016-12-10T22:53:49.827' AS DateTime), N'vi-VN')
INSERT [dbo].[WebSimpleContents] ([ID], [Title], [Image], [Link], [Description], [Key], [Body], [MetaTitle], [MetaKeywords], [MetaDescription], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Culture]) VALUES (12, N'Thông tin liên hệ - footer', NULL, NULL, NULL, N'content-footer', N'<p><strong>TẠP CH&Iacute; M&Ocirc;I TRƯỜNG (VEM) - TỔNG CỤC M&Ocirc;I TRƯỜNG (VEA)</strong></p>

<p><strong>Trụ sở tại H&agrave; Nội: </strong> Tầng 7, L&ocirc; E2, phố Dương Đ&igrave;nh Nghệ, phường Y&ecirc;n H&ograve;a, quận Cầu Giấy, H&agrave; Nội.</p>

<p><strong>Thường tr&uacute; tại TP. Hồ Ch&iacute; Minh: </strong>Ph&ograve;ng A 403, Tầng 4, Khu li&ecirc;n cơ quan Bộ TN&amp;MT, số 200 L&yacute; Ch&iacute;nh Thắng, phường 9, quận 3, TP.Hồ Ch&iacute; Minh</p>

<p><strong>Chịu tr&aacute;ch nhiệm nội dung: </strong> &Ocirc;ng Nguyễn Văn Th&ugrave;y - Phụ tr&aacute;ch điều h&agrave;nh Tạp ch&iacute;</p>

<p><strong>Giấy ph&eacute;p: </strong>Số 59/GP-TTĐT ngày 08 tháng 5 năm 2020 của Cục Quản lý Phát thanh, Truy&ecirc;̀n hình và Th&ocirc;ng tin đi&ecirc;̣n tử - Bộ Th&ocirc;ng tin v&agrave; Truyền th&ocirc;ng.</p>

<p><strong>Email: </strong> tapchimoitruongtcmt​ vea.gov.vn</p>

<p><strong>Copyright &copy; 2020&nbsp;Tap ch&iacute; M&ocirc;i trường. All rights reserved​</strong></p>
', NULL, NULL, NULL, N'admin', CAST(N'2020-07-12T23:34:44.480' AS DateTime), N'Admin', CAST(N'2020-07-12T18:20:29.807' AS DateTime), N'vi-VN')
INSERT [dbo].[WebSimpleContents] ([ID], [Title], [Image], [Link], [Description], [Key], [Body], [MetaTitle], [MetaKeywords], [MetaDescription], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Culture]) VALUES (13, N'Facebook', NULL, NULL, NULL, N'facebook', N'<p><iframe frameborder="0" height="180" scrolling="no" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FT%25E1%25BA%25A1p-Ch%25C3%25AD-M%25C3%25B4i-Tr%25C6%25B0%25E1%25BB%259Dng-VEM-121087409693661&amp;tabs=timeline&amp;width=380&amp;height=500&amp;small_header=false&amp;adapt_container_width=true&amp;hide_cover=false&amp;show_facepile=true&amp;appId=547555702424687" style="border:none;overflow:hidden" width="300"></iframe></p>
', NULL, NULL, NULL, N'admin', CAST(N'2020-07-27T13:45:07.790' AS DateTime), N'admin', CAST(N'2020-10-09T15:36:22.913' AS DateTime), N'vi-VN')
SET IDENTITY_INSERT [dbo].[WebSimpleContents] OFF
SET IDENTITY_INSERT [dbo].[WebSlides] ON 

INSERT [dbo].[WebSlides] ([ID], [Title], [Description], [Image], [Link], [MetaTitle], [MetaKeywords], [MetaDescription], [Status], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Order], [Culture]) VALUES (9, N'Slide 3', N'Dovitae diam purus luctus facilisis. Nullam at dolore ipsum eros tristique ultrice. Duis quis imperdie.', N'/uploads/image/072020/slide1_aba2df6.png', N'#', NULL, NULL, NULL, 1, N'_self', N'admin', CAST(N'2016-10-14T15:14:20.753' AS DateTime), N'admin', CAST(N'2020-07-12T23:29:13.040' AS DateTime), 3, N'vi-VN')
INSERT [dbo].[WebSlides] ([ID], [Title], [Description], [Image], [Link], [MetaTitle], [MetaKeywords], [MetaDescription], [Status], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Order], [Culture]) VALUES (12, N'Slide 2', N'Dovitae diam purus luctus facilisis. Nullam at dolore ipsum eros tristique ultrice. Duis quis imperdie.', N'/uploads/image/072020/slide2_382074fd.png', N'#', NULL, NULL, NULL, 1, N'_self', N'admin', CAST(N'2016-11-02T12:18:28.567' AS DateTime), N'admin', CAST(N'2020-07-12T23:29:06.697' AS DateTime), 2, N'vi-VN')
INSERT [dbo].[WebSlides] ([ID], [Title], [Description], [Image], [Link], [MetaTitle], [MetaKeywords], [MetaDescription], [Status], [Target], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Order], [Culture]) VALUES (1012, N'Slide 1', N'Dovitae diam purus luctus facilisis. Nullam at dolore ipsum eros tristique ultrice. Duis quis imperdie.', N'/uploads/image/072020/slide3_9f5e998.png', N'#', NULL, NULL, NULL, 1, N'_self', N'admin', CAST(N'2016-11-21T11:01:02.597' AS DateTime), N'admin', CAST(N'2020-07-12T23:28:59.703' AS DateTime), 1, N'vi-VN')
SET IDENTITY_INSERT [dbo].[WebSlides] OFF
/****** Object:  Index [IX_UserProfile]    Script Date: 12/24/2020 6:21:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserProfile] ON [dbo].[UserProfile]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__webpages__8A2B6160C07A3C3D]    Script Date: 12/24/2020 6:21:44 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__webpages__8A2B6160FB764A8C]    Script Date: 12/24/2020 6:21:44 PM ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SubscribeNotices] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SubscribeNotices] ADD  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[AccessAdminSites]  WITH CHECK ADD  CONSTRAINT [FK_AccessPermissions_AdminSites] FOREIGN KEY([AdminSiteID])
REFERENCES [dbo].[AdminSites] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccessAdminSites] CHECK CONSTRAINT [FK_AccessPermissions_AdminSites]
GO
ALTER TABLE [dbo].[AccessAdminSites]  WITH CHECK ADD  CONSTRAINT [FK_AccessPermissions_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccessAdminSites] CHECK CONSTRAINT [FK_AccessPermissions_UserProfile]
GO
ALTER TABLE [dbo].[AccessWebModules]  WITH CHECK ADD  CONSTRAINT [FK_AccessWebModules_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccessWebModules] CHECK CONSTRAINT [FK_AccessWebModules_UserProfile]
GO
ALTER TABLE [dbo].[AccessWebModules]  WITH CHECK ADD  CONSTRAINT [FK_AccessWebModules_WebModules] FOREIGN KEY([WebModuleID])
REFERENCES [dbo].[WebModules] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccessWebModules] CHECK CONSTRAINT [FK_AccessWebModules_WebModules]
GO
ALTER TABLE [dbo].[AdminSites]  WITH CHECK ADD  CONSTRAINT [FK_AdminSites_AdminSites] FOREIGN KEY([ParentID])
REFERENCES [dbo].[AdminSites] ([ID])
GO
ALTER TABLE [dbo].[AdminSites] CHECK CONSTRAINT [FK_AdminSites_AdminSites]
GO
ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_Advertisements_AdvertisementPositions1] FOREIGN KEY([AdvertisementPositionID])
REFERENCES [dbo].[AdvertisementPositions] ([ID])
GO
ALTER TABLE [dbo].[Advertisements] CHECK CONSTRAINT [FK_Advertisements_AdvertisementPositions1]
GO
ALTER TABLE [dbo].[CommissionManagement]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerCategory] ([ID])
GO
ALTER TABLE [dbo].[CommissionManagement]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerCategory] ([ID])
GO
ALTER TABLE [dbo].[CommissionManagement]  WITH CHECK ADD  CONSTRAINT [FK__Commissio__ShopI__22401542] FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[CommissionManagement] CHECK CONSTRAINT [FK__Commissio__ShopI__22401542]
GO
ALTER TABLE [dbo].[ContentImages]  WITH CHECK ADD  CONSTRAINT [FK_ContentImages_WebContents] FOREIGN KEY([WebContentID])
REFERENCES [dbo].[WebContents] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentImages] CHECK CONSTRAINT [FK_ContentImages_WebContents]
GO
ALTER TABLE [dbo].[ContentRelateds]  WITH CHECK ADD  CONSTRAINT [FK_ContentRelateds_WebContents] FOREIGN KEY([MainID])
REFERENCES [dbo].[WebContents] ([ID])
GO
ALTER TABLE [dbo].[ContentRelateds] CHECK CONSTRAINT [FK_ContentRelateds_WebContents]
GO
ALTER TABLE [dbo].[ContentRelateds]  WITH CHECK ADD  CONSTRAINT [FK_ContentRelateds_WebContents1] FOREIGN KEY([RelatedID])
REFERENCES [dbo].[WebContents] ([ID])
GO
ALTER TABLE [dbo].[ContentRelateds] CHECK CONSTRAINT [FK_ContentRelateds_WebContents1]
GO
ALTER TABLE [dbo].[DealDetail]  WITH CHECK ADD FOREIGN KEY([ParentID])
REFERENCES [dbo].[FreightPrice] ([ID])
GO
ALTER TABLE [dbo].[DealDetail]  WITH CHECK ADD FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ID])
GO
ALTER TABLE [dbo].[District]  WITH CHECK ADD FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ID])
GO
ALTER TABLE [dbo].[FreightPrice]  WITH CHECK ADD FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersChild]  WITH CHECK ADD FOREIGN KEY([CommodityID])
REFERENCES [dbo].[CommodityCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersChild]  WITH CHECK ADD  CONSTRAINT [FK__ImportOrd__Parre__7908F585] FOREIGN KEY([ParrentID])
REFERENCES [dbo].[ImportOrdersParrent] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersChild] CHECK CONSTRAINT [FK__ImportOrd__Parre__7908F585]
GO
ALTER TABLE [dbo].[ImportOrdersChild]  WITH CHECK ADD FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersParrent]  WITH CHECK ADD  CONSTRAINT [FK__ImportOrd__ShopI__2610A626] FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersParrent] CHECK CONSTRAINT [FK__ImportOrd__ShopI__2610A626]
GO
ALTER TABLE [dbo].[ImportOrdersParrent]  WITH CHECK ADD  CONSTRAINT [FK__ImportOrd__Suppl__251C81ED] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[SupplierCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersParrent] CHECK CONSTRAINT [FK__ImportOrd__Suppl__251C81ED]
GO
ALTER TABLE [dbo].[ImportOrdersParrent]  WITH CHECK ADD  CONSTRAINT [FK__ImportOrd__Suppl__69C6B1F5] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[SupplierCategory] ([ID])
GO
ALTER TABLE [dbo].[ImportOrdersParrent] CHECK CONSTRAINT [FK__ImportOrd__Suppl__69C6B1F5]
GO
ALTER TABLE [dbo].[ListedPrice]  WITH CHECK ADD  CONSTRAINT [FK__ListedPri__Commo__16CE6296] FOREIGN KEY([CommodityID])
REFERENCES [dbo].[CommodityCategory] ([ID])
GO
ALTER TABLE [dbo].[ListedPrice] CHECK CONSTRAINT [FK__ListedPri__Commo__16CE6296]
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([DistrictID])
REFERENCES [dbo].[District] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([DistrictID])
REFERENCES [dbo].[District] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ID])
GO
ALTER TABLE [dbo].[Location]  WITH CHECK ADD FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ID])
GO
ALTER TABLE [dbo].[ModuleNavigations]  WITH CHECK ADD  CONSTRAINT [FK_ModuleNavigations_Navigations] FOREIGN KEY([NavigationID])
REFERENCES [dbo].[Navigations] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ModuleNavigations] CHECK CONSTRAINT [FK_ModuleNavigations_Navigations]
GO
ALTER TABLE [dbo].[ModuleNavigations]  WITH CHECK ADD  CONSTRAINT [FK_ModuleNavigations_WebModules] FOREIGN KEY([WebModuleID])
REFERENCES [dbo].[WebModules] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ModuleNavigations] CHECK CONSTRAINT [FK_ModuleNavigations_WebModules]
GO
ALTER TABLE [dbo].[NoteBookKey]  WITH CHECK ADD FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[NoteBookKey]  WITH CHECK ADD FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD FOREIGN KEY([CommodityID])
REFERENCES [dbo].[CommodityCategory] ([ID])
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD FOREIGN KEY([CommodityID])
REFERENCES [dbo].[CommodityCategory] ([ID])
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerCategory] ([ID])
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CustomerCategory] ([ID])
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK__Price__ShopID__1D7B6025] FOREIGN KEY([ShopID])
REFERENCES [dbo].[ShopCategory] ([ID])
GO
ALTER TABLE [dbo].[Price] CHECK CONSTRAINT [FK__Price__ShopID__1D7B6025]
GO
ALTER TABLE [dbo].[PricingTable]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([ID])
GO
ALTER TABLE [dbo].[PricingTable]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([ID])
GO
ALTER TABLE [dbo].[PricingTable]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([ID])
GO
ALTER TABLE [dbo].[PricingTable]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([ID])
GO
ALTER TABLE [dbo].[ProductInfos]  WITH CHECK ADD  CONSTRAINT [FK_ProductInfos_WebContents] FOREIGN KEY([ID])
REFERENCES [dbo].[WebContents] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductInfos] CHECK CONSTRAINT [FK_ProductInfos_WebContents]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD FOREIGN KEY([EndLocationID])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD FOREIGN KEY([EndLocationID])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD FOREIGN KEY([StartLocationID])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD FOREIGN KEY([StartLocationID])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[TransportActual]  WITH CHECK ADD FOREIGN KEY([PlanID])
REFERENCES [dbo].[TransportPlan] ([ID])
GO
ALTER TABLE [dbo].[TransportActual]  WITH CHECK ADD FOREIGN KEY([PlanID])
REFERENCES [dbo].[TransportPlan] ([ID])
GO
ALTER TABLE [dbo].[TransportPlan]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([ID])
GO
ALTER TABLE [dbo].[TransportPlan]  WITH CHECK ADD FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([ID])
GO
ALTER TABLE [dbo].[TransportPlan]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([ID])
GO
ALTER TABLE [dbo].[TransportPlan]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([ID])
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_UserProfile]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD FOREIGN KEY([PartnerID])
REFERENCES [dbo].[Partner] ([ID])
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD FOREIGN KEY([PartnerID])
REFERENCES [dbo].[Partner] ([ID])
GO
ALTER TABLE [dbo].[WebCategories]  WITH CHECK ADD  CONSTRAINT [FK_WebCategories_WebCategories] FOREIGN KEY([ParentID])
REFERENCES [dbo].[WebCategories] ([ID])
GO
ALTER TABLE [dbo].[WebCategories] CHECK CONSTRAINT [FK_WebCategories_WebCategories]
GO
ALTER TABLE [dbo].[WebContentCategories]  WITH CHECK ADD  CONSTRAINT [FK_WebContentCategories_WebCategories] FOREIGN KEY([WebCategoryID])
REFERENCES [dbo].[WebCategories] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebContentCategories] CHECK CONSTRAINT [FK_WebContentCategories_WebCategories]
GO
ALTER TABLE [dbo].[WebContentCategories]  WITH CHECK ADD  CONSTRAINT [FK_WebContentCategories_WebContents] FOREIGN KEY([WebContentID])
REFERENCES [dbo].[WebContents] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebContentCategories] CHECK CONSTRAINT [FK_WebContentCategories_WebContents]
GO
ALTER TABLE [dbo].[WebContents]  WITH CHECK ADD  CONSTRAINT [FK_WebContents_WebModules] FOREIGN KEY([WebModuleID])
REFERENCES [dbo].[WebModules] ([ID])
GO
ALTER TABLE [dbo].[WebContents] CHECK CONSTRAINT [FK_WebContents_WebModules]
GO
ALTER TABLE [dbo].[WebContentUploads]  WITH CHECK ADD  CONSTRAINT [FK_WebContentUploads_WebContentUploads1] FOREIGN KEY([FolderID])
REFERENCES [dbo].[WebContentUploads] ([ID])
GO
ALTER TABLE [dbo].[WebContentUploads] CHECK CONSTRAINT [FK_WebContentUploads_WebContentUploads1]
GO
ALTER TABLE [dbo].[WebModules]  WITH CHECK ADD  CONSTRAINT [FK_WebModules_ContentTypes] FOREIGN KEY([ContentTypeID])
REFERENCES [dbo].[ContentTypes] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[WebModules] CHECK CONSTRAINT [FK_WebModules_ContentTypes]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
ALTER TABLE [dbo].[WebRedirects]  WITH CHECK ADD  CONSTRAINT [FK_WebRedirects_WebModules] FOREIGN KEY([WebModuleID])
REFERENCES [dbo].[WebModules] ([ID])
GO
ALTER TABLE [dbo].[WebRedirects] CHECK CONSTRAINT [FK_WebRedirects_WebModules]
GO
USE [master]
GO
ALTER DATABASE [Petro] SET  READ_WRITE 
GO

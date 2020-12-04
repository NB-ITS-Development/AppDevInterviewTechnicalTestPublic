/* SCHEMA IMPORT */

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating role webapp'
GO
CREATE ROLE [webapp]
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering members of role db_datareader'
GO
ALTER ROLE [db_datareader] ADD MEMBER [webapp]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering members of role db_datawriter'
GO
ALTER ROLE [db_datawriter] ADD MEMBER [webapp]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating schemas'
GO
CREATE SCHEMA [tickets]
AUTHORIZATION [dbo]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [tickets].[User]'
GO
CREATE TABLE [tickets].[User]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__User__IsActive__38996AB5] DEFAULT ((1))
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_User] on [tickets].[User]'
GO
ALTER TABLE [tickets].[User] ADD CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [tickets].[User]'
GO
ALTER TABLE [tickets].[User] ADD CONSTRAINT [UQ_User_Username] UNIQUE NONCLUSTERED  ([Username])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [tickets].[Ticket]'
GO
CREATE TABLE [tickets].[Ticket]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateTimeCreated] [datetime] NOT NULL,
[DateTimeModified] [datetime] NOT NULL,
[CreatedBy] [int] NOT NULL,
[ModifiedBy] [int] NOT NULL,
[Tag] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Ticket] on [tickets].[Ticket]'
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [tickets].[Ticket]'
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [UQ_Ticket_Title] UNIQUE NONCLUSTERED  ([Title])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [tickets].[Lookup_TicketStatus]'
GO
CREATE TABLE [tickets].[Lookup_TicketStatus]
(
[Id] [int] NOT NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__Lookup_Ti__IsAct__4AB81AF0] DEFAULT ((1))
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Lookup_TicketStatus] on [tickets].[Lookup_TicketStatus]'
GO
ALTER TABLE [tickets].[Lookup_TicketStatus] ADD CONSTRAINT [PK_Lookup_TicketStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [tickets].[Lookup_TicketStatus]'
GO
ALTER TABLE [tickets].[Lookup_TicketStatus] ADD CONSTRAINT [UQ_LookupTicketStatus_Title] UNIQUE NONCLUSTERED  ([Title])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [tickets].[Lookup_Tag]'
GO
CREATE TABLE [tickets].[Lookup_Tag]
(
[TagName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__Lookup_Ta__IsAct__3B75D760] DEFAULT ((1)),
[TagDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Lookup_Tag] on [tickets].[Lookup_Tag]'
GO
ALTER TABLE [tickets].[Lookup_Tag] ADD CONSTRAINT [PK_Lookup_Tag] PRIMARY KEY CLUSTERED  ([TagName])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [tickets].[TicketNote]'
GO
CREATE TABLE [tickets].[TicketNote]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Body] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateTimeCreated] [datetime] NOT NULL,
[DateTimeModified] [datetime] NOT NULL,
[CreatedBy] [int] NOT NULL,
[ModifiedBy] [int] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_TicketNote] on [tickets].[TicketNote]'
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [PK_TicketNote] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [tickets].[Ticket]'
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_Tag] FOREIGN KEY ([Tag]) REFERENCES [tickets].[Lookup_Tag] ([TagName])
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_Status_Lookup_TicketStatus] FOREIGN KEY ([Status]) REFERENCES [tickets].[Lookup_TicketStatus] ([Id])
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_CreatedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_ModifiedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [tickets].[TicketNote]'
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [FK_TicketNote_CreatedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [FK_TicketNote_ModifiedBy_User] FOREIGN KEY ([ModifiedBy]) REFERENCES [tickets].[User] ([Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
GRANT EXECUTE TO [webapp]
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO

/* DATA IMPORT */
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION

PRINT(N'Drop constraints from [tickets].[Ticket]')
ALTER TABLE [tickets].[Ticket] NOCHECK CONSTRAINT [FK_Ticket_CreatedBy_User]
ALTER TABLE [tickets].[Ticket] NOCHECK CONSTRAINT [FK_Ticket_ModifiedBy_User]
ALTER TABLE [tickets].[Ticket] NOCHECK CONSTRAINT [FK_Ticket_Status_Lookup_TicketStatus]
ALTER TABLE [tickets].[Ticket] NOCHECK CONSTRAINT [FK_Ticket_Tag]

PRINT(N'Drop constraint FK_TicketNote_CreatedBy_User from [tickets].[TicketNote]')
ALTER TABLE [tickets].[TicketNote] NOCHECK CONSTRAINT [FK_TicketNote_CreatedBy_User]

PRINT(N'Drop constraint FK_TicketNote_ModifiedBy_User from [tickets].[TicketNote]')
ALTER TABLE [tickets].[TicketNote] NOCHECK CONSTRAINT [FK_TicketNote_ModifiedBy_User]

PRINT(N'Add 2 rows to [tickets].[Lookup_Tag]')
INSERT INTO [tickets].[Lookup_Tag] ([TagName], [IsActive], [TagDescription]) VALUES (N'install', 1, N'Installing new software')
INSERT INTO [tickets].[Lookup_Tag] ([TagName], [IsActive], [TagDescription]) VALUES (N'printers', 1, N'Printer-related issues')

PRINT(N'Add 2 rows to [tickets].[Lookup_TicketStatus]')
INSERT INTO [tickets].[Lookup_TicketStatus] ([Id], [Title], [IsActive]) VALUES (1, N'Open', 1)
INSERT INTO [tickets].[Lookup_TicketStatus] ([Id], [Title], [IsActive]) VALUES (2, N'Closed', 1)

PRINT(N'Add 1 row to [tickets].[User]')
SET IDENTITY_INSERT [tickets].[User] ON
INSERT INTO [tickets].[User] ([Id], [Username], [IsActive]) VALUES (1, N'test', 1)
SET IDENTITY_INSERT [tickets].[User] OFF

PRINT(N'Add 2 rows to [tickets].[Ticket]')
SET IDENTITY_INSERT [tickets].[Ticket] ON
INSERT INTO [tickets].[Ticket] ([Id], [Title], [DateTimeCreated], [DateTimeModified], [CreatedBy], [ModifiedBy], [Tag], [Status]) VALUES (1, N'Test Ticket #1', '2020-12-04 16:38:05.180', '2020-12-04 16:41:18.687', 1, 0, NULL, 2)
INSERT INTO [tickets].[Ticket] ([Id], [Title], [DateTimeCreated], [DateTimeModified], [CreatedBy], [ModifiedBy], [Tag], [Status]) VALUES (2, N'Another test', '2020-12-04 16:41:34.087', '2020-12-04 16:41:34.087', 1, 0, NULL, 1)
SET IDENTITY_INSERT [tickets].[Ticket] OFF

PRINT(N'Add constraints to [tickets].[Ticket]')
ALTER TABLE [tickets].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_CreatedBy_User]
ALTER TABLE [tickets].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_ModifiedBy_User]
ALTER TABLE [tickets].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_Status_Lookup_TicketStatus]
ALTER TABLE [tickets].[Ticket] WITH CHECK CHECK CONSTRAINT [FK_Ticket_Tag]
ALTER TABLE [tickets].[TicketNote] WITH CHECK CHECK CONSTRAINT [FK_TicketNote_CreatedBy_User]
ALTER TABLE [tickets].[TicketNote] WITH CHECK CHECK CONSTRAINT [FK_TicketNote_ModifiedBy_User]
COMMIT TRANSACTION
GO

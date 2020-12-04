CREATE TABLE [tickets].[Ticket]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateTimeCreated] [datetime] NOT NULL,
[DateTimeModified] [datetime] NOT NULL,
[CreatedBy] [int] NOT NULL,
[ModifiedBy] [int] NOT NULL,
[Tag] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [UQ_Ticket_Title] UNIQUE NONCLUSTERED  ([Title]) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_CreatedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_ModifiedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
ALTER TABLE [tickets].[Ticket] ADD CONSTRAINT [FK_Ticket_Tag] FOREIGN KEY ([Tag]) REFERENCES [tickets].[Lookup_Tag] ([TagName])
GO

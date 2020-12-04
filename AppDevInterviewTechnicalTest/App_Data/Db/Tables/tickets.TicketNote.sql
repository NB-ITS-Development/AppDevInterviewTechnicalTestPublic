CREATE TABLE [tickets].[TicketNote]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Body] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateTimeCreated] [datetime] NOT NULL,
[DateTimeModified] [datetime] NOT NULL,
[CreatedBy] [int] NOT NULL,
[ModifiedBy] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [PK_TicketNote] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [FK_TicketNote_CreatedBy_User] FOREIGN KEY ([CreatedBy]) REFERENCES [tickets].[User] ([Id])
GO
ALTER TABLE [tickets].[TicketNote] ADD CONSTRAINT [FK_TicketNote_ModifiedBy_User] FOREIGN KEY ([ModifiedBy]) REFERENCES [tickets].[User] ([Id])
GO

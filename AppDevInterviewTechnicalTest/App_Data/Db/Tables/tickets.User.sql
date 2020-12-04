CREATE TABLE [tickets].[User]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__User__IsActive__38996AB5] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [tickets].[User] ADD CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [tickets].[User] ADD CONSTRAINT [UQ_User_Username] UNIQUE NONCLUSTERED  ([Username]) ON [PRIMARY]
GO

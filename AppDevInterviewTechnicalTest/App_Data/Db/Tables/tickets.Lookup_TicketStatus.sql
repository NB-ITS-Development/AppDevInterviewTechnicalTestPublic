CREATE TABLE [tickets].[Lookup_TicketStatus]
(
[Id] [int] NOT NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__Lookup_Ti__IsAct__4AB81AF0] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Lookup_TicketStatus] ADD CONSTRAINT [PK_Lookup_TicketStatus] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Lookup_TicketStatus] ADD CONSTRAINT [UQ_LookupTicketStatus_Title] UNIQUE NONCLUSTERED  ([Title]) ON [PRIMARY]
GO

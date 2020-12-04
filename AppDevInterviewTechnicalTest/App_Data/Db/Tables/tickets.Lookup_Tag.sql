CREATE TABLE [tickets].[Lookup_Tag]
(
[TagName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__Lookup_Ta__IsAct__3B75D760] DEFAULT ((1)),
[TagDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [tickets].[Lookup_Tag] ADD CONSTRAINT [PK_Lookup_Tag] PRIMARY KEY CLUSTERED  ([TagName]) ON [PRIMARY]
GO

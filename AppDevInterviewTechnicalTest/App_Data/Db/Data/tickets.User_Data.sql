SET IDENTITY_INSERT [tickets].[User] ON
INSERT INTO [tickets].[User] ([Id], [Username], [IsActive]) VALUES (1, N'test', 1)
SET IDENTITY_INSERT [tickets].[User] OFF

SET IDENTITY_INSERT [tickets].[Ticket] ON
INSERT INTO [tickets].[Ticket] ([Id], [Title], [DateTimeCreated], [DateTimeModified], [CreatedBy], [ModifiedBy], [Tag], [Status]) VALUES (1, N'Test Ticket #1', '2020-12-04 16:38:05.180', '2020-12-04 16:41:18.687', 1, 0, NULL, 2)
INSERT INTO [tickets].[Ticket] ([Id], [Title], [DateTimeCreated], [DateTimeModified], [CreatedBy], [ModifiedBy], [Tag], [Status]) VALUES (2, N'Another test', '2020-12-04 16:41:34.087', '2020-12-04 16:41:34.087', 1, 0, NULL, 1)
SET IDENTITY_INSERT [tickets].[Ticket] OFF

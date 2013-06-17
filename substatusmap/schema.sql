
USE Analysis


CREATE TABLE [dbo].[Stages](
	[StageID] [int] IDENTITY(1,1) PRIMARY KEY,
	[StageName] [varchar](50) NOT NULL,
	[StageOrder] [int] NULL
)

CREATE TABLE [dbo].[SubStages](
	[SubStageID] [int] IDENTITY(1,1) PRIMARY KEY,
	[SubStageName] [varchar](50) NOT NULL,
	[SubStageOrder] [int] NULL
)

CREATE TABLE [dbo].[SubStatusOwners](
	[SubStatusOwnerID] [int] IDENTITY(1,1) PRIMARY KEY,
	[SubStatusOwner] [varchar](50) NULL
)



CREATE TABLE [dbo].[StageSubStageMap](
	[StageID] [int],
	[SubStageID] int,
	CONSTRAINT fk_StageID FOREIGN KEY (StageID) REFERENCES Stages(StageID),
	CONSTRAINT fk_SubStageId FOREIGN KEY (SubStageID) REFERENCES SubStages(SubStageID)
)


CREATE TABLE [dbo].[SubStageSubStatusMap](
	[SubStageID] int,
	[SubStatusID] int,
	CONSTRAINT fk_SubStageIDmap FOREIGN KEY (SubStageID) REFERENCES SubStages(SubStageID)
)

CREATE TABLE [dbo].[SubStatusOwnerSubStatusMap](
	[SubStatusOwnerID] int,
	[SubStatusID] int,
	CONSTRAINT fk_SubStatusOwnerID FOREIGN KEY (SubStatusOwnerID) REFERENCES SubStatusOwners(SubStatusOwnerID)
)





CREATE TABLE [Film] (
  [id] int PRIMARY KEY,
  [title] nvarchar(255),
  [episode_id] int,
  [opening_crawl] nvarchar(255),
  [director] nvarchar(255),
  [producer] nvarchar(255),
  [release_date] timestamp,
)
GO

CREATE TABLE [People] (
  [id] int PRIMARY KEY,
  [name] nvarchar(255),
  [birth_year] nvarchar(255),
  [eye_color] nvarchar(255),
  [gender] nvarchar(255),
  [hair_color] nvarchar(255),
  [height] nvarchar(255),
  [mass] nvarchar(255),
  [skin_color] nvarchar(255),
  [planet_id] int,
)
GO

CREATE TABLE [Planets] (
  [id] int PRIMARY KEY,
  [name] nvarchar(255),
  [diameter] nvarchar(255),
  [rotation_period] nvarchar(255),
  [orbital_period] nvarchar(255),
  [gravity] nvarchar(255),
  [population] nvarchar(255),
  [climate] nvarchar(255),
  [terrain] nvarchar(255),
  [surface_water] nvarchar(255),
)
GO

CREATE TABLE [Film_People] (
  [id] int PRIMARY KEY,
  [film_id] integer,
  [people_id] integer
)
GO

CREATE TABLE [Film_Planet] (
  [id] int PRIMARY KEY,
  [film_id] integer,
  [planet_id] integer
)
GO

ALTER TABLE [People] ADD FOREIGN KEY ([planet_id]) REFERENCES [Planets] ([id])
GO

ALTER TABLE [Film_People] ADD FOREIGN KEY ([film_id]) REFERENCES [Film] ([id])
GO

ALTER TABLE [Film_People] ADD FOREIGN KEY ([people_id]) REFERENCES [People] ([id])
GO

ALTER TABLE [Film_Planet] ADD FOREIGN KEY ([film_id]) REFERENCES [Film] ([id])
GO

ALTER TABLE [Film_Planet] ADD FOREIGN KEY ([planet_id]) REFERENCES [Planets] ([id])
GO

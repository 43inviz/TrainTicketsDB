create database TrainTicket

go

use TrainTicket

go
--таблица юзеров
create table Users (
	id int identity(1,1) primary key,
	Name nvarchar(max) not null,
	Surname nvarchar(max) not null,
	Login nvarchar(max) not null,
	Password nvarchar(max) not null
)

go
--страны/города/станции
create table Countries (
	id int identity(1,1) primary key,
	Name nvarchar(max) not null
)

go
create table Cities (
	id int identity(1,1) primary key,
	CityName nvarchar(max) not null,
	Country int foreign key references Countries(id) 
)

go


create table Stations (
	id int identity(1,1) primary key,
	StationName nvarchar(max) not null,
	StationCity int foreign key references Cities(id)
)


go
--плацкарт\купе
create table PlaceType( 
	id int identity(1,1) primary key,
	Title nvarchar(255) not null
)


go
--скорый\электричка
create table TrainType(
	id int identity(1,1) primary key,
	Title nvarchar(255) not null
)

go
--поехда
create table Trains(
	id int identity(1,1) primary key,
	Title nvarchar(max) not null,
	TypeTrain int foreign key references TrainType(id),
	WagonCount int not null,
	
	
)

go

use TrainTicket

go
--информация о вагонах
create table Wagons (
    id int identity(1,1) primary key,
    TrainId int foreign key references Trains(id),
    WagonNumber int not null,
    PlaceTypeId int foreign key references PlaceType(id)
)


go
--билеты которые покупают юзеры
create table Tickets (
    id int identity(1,1) primary key,
    UserId int foreign key references Users(id),
    TrainId int foreign key references Trains(id),
    WagonId int foreign key references Wagons(id),
    SeatNumber int not null,
    Price money not null,
    PurchaseDate datetime not null
)

go
--расписание поездов
create table Timetable (
	id int identity(1,1) primary key,
	TrainId int foreign key references Trains(id),
	DepartureStationId int foreign key references Stations(id),
	ArrivalStationId int foreign key references Stations(id),
	DepartureTime datetime not null,
	ArrivalTime datetime not null,
	
)

go
--информация о промежуточных станциях
create table IntermediateStations(
	id int identity(1,1) primary key,
	TimetableId int foreign key references Timetable(id),
	StationId int foreign key references Stations(id),
	ArrivalTime datetime not null,
	DepartureTime datetime not null
)

go

create table TicketPaymentStatus(
	id int identity(1,1) primary key,
	Title nvarchar(255) not null
)

go
--информация о платежах
create table Payments(
	id int identity(1,1) primary key,
	TicketId int foreign key references Tickets(id),
	PaymentDate datetime not null,
	Price money not null,
	TicketsStatusId int foreign key references TicketPaymentStatus(id)
)
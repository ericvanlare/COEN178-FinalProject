DROP TABLE LeaseAgreement;
DROP TABLE RentalProperty;
DROP TABLE PropertyOwner;
DROP TABLE Employee;
DROP TABLE Branch;
DROP TABLE Address;

CREATE TABLE Address(
	AddressID			INTEGER PRIMARY KEY,
	StreetNumber		INTEGER,
	StreetName			VARCHAR(50),
	StreetAptNumber		INTEGER,
	City				VARCHAR(50),
	Zip					INTEGER CHECK (Zip >= 10000 AND Zip < 100000)
);

CREATE TABLE Branch(
	BranchNumber		INTEGER PRIMARY KEY,
	Phone				INTEGER CHECK (Phone >= 1000000000 AND Phone < 10000000000),
	AddressID			INTEGER,
	FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE Employee(
	EmpID				INTEGER PRIMARY KEY,
	EmpName				VARCHAR(50),
	Phone				INTEGER CHECK (Phone >= 1000000000 AND Phone < 10000000000),
	StartDate			DATE,
	JobDesignation		VARCHAR(20) CHECK (JobDesignation IN ('Manager','Supervisor','Staff')),
	BranchNumber		INTEGER,
	FOREIGN KEY (BranchNumber) REFERENCES Branch(BranchNumber)
);

CREATE TABLE PropertyOwner(
	PropertyOwnerID		INTEGER PRIMARY KEY,
	Name 				VARCHAR(50),
	AddressID			INTEGER,
	Phone				INTEGER CHECK (Phone >= 1000000000 AND Phone < 10000000000),
	FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE RentalProperty(
	PropertyNumber		INTEGER PRIMARY KEY,
	PropertyOwnerID		INTEGER,
	AddressID			INTEGER,
	NumberOfRooms		INTEGER,
	MonthlyRent			NUMBER(12,2),
	Status				VARCHAR(20) CHECK (Status IN ('Available','Not-available','Leased')),
	AvailStartDate		DATE,
	SupervisorEmpID		INTEGER,
	FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
	FOREIGN KEY (SupervisorEmpID) REFERENCES Employee(EmpID)
);

CREATE TABLE LeaseAgreement(
	PropertyNumber		INTEGER,
	RenterName			VARCHAR(50),
	HomePhone			INTEGER CHECK (HomePhone >= 1000000000 AND HomePhone < 10000000000),
	WorkPhone			INTEGER CHECK (WorkPhone >= 1000000000 AND WorkPhone < 10000000000),
	FriendName			VARCHAR(50),
	FriendPhone			INTEGER CHECK (FriendPhone >= 1000000000 AND FriendPhone < 10000000000),
	StartDate 			DATE,
	EndDate				DATE CHECK (MONTHS_BETWEEN(StartDate, EndDate) >= 6 AND MONTHS_BETWEEN(StartDate, EndDate) <= 12),
	DepositAmount		NUMBER(12,2),
	RentAmount			NUMBER(12,2),
	FOREIGN KEY (PropertyNumber) REFERENCES RentalProperty(PropertyNumber),
);
CREATE TABLE [PropertyType] (
  [Typeid] INT,
  [TypeName] varchar(50),
  [Description] varchar(100),
  PRIMARY KEY ([Typeid])
);

CREATE TABLE [SchoolZone] (
  [Schoolzoneid] varchar(5),
  [SchoolName] varchar(100),
  [SchoolRate] Decimal(2,2),
  [ExpirationDate] varchar(10),
  PRIMARY KEY ([Schoolzoneid])
);

CREATE TABLE [Transportation] (
  [Transportationid] varchar(5),
  [TransportationTypeName] varchar(15),
  PRIMARY KEY ([Transportationid])
);

CREATE TABLE [Property] (
  [Propertyid] INT,
  [FName] varchar(50),
  [Lname] varchar(50),
  [Address1] varchar(50),
  [  Address2] varchar(50),
  [State] varchar(15),
  [Zip] varchar(12),
  [City] varchar(25),
  [NumberOfbeds] INT,
  [NumberOfbath] INT,
  [Sqrft] varchar(20),
  [Typeid] INT,
  [Yearbuild] varchar(15),
  [Cooling] char(3),
  [Parking] char(13),
  [Heating] char(3),
  [Hoa] varchar(30),
  [Schoolzoneid] varchar(5),
  [Transportationid] Type,
  PRIMARY KEY ([Propertyid]),
  CONSTRAINT [FK_Property.Typeid]
    FOREIGN KEY ([Typeid])
      REFERENCES [PropertyType]([Typeid]),
  CONSTRAINT [FK_Property.Schoolzoneid]
    FOREIGN KEY ([Schoolzoneid])
      REFERENCES [SchoolZone]([Schoolzoneid]),
  CONSTRAINT [FK_Property.Transportationid]
    FOREIGN KEY ([Transportationid])
      REFERENCES [Transportation]([Transportationid])
);

CREATE INDEX [Key] ON  [Property] ([Transportationid]);

CREATE TABLE [Pricing] (
  [Propertyid] INT,
  [Year] INT,
  [ActualRent] varchar(15),
  [EstimateRent] varchar(15),
  [PricePerSqFt] varchar(15),
  PRIMARY KEY ([Propertyid], [Year]),
  CONSTRAINT [FK_Pricing.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);

CREATE TABLE [Image] (
  [Propertyid] INT,
  [Imageid] varchar(5),
  [File] varbinary(max),
  PRIMARY KEY ([Propertyid], [Imageid]),
  CONSTRAINT [FK_Image.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);

CREATE TABLE [Tenant] (
  [Tenantid] INT,
  [FName] varchar(50),
  [Lname] varchar(50),
  [Address1] varchar(50),
  [  Address2] varchar(50),
  [State] varchar(15),
  [Zip] varchar(12),
  [City] varchar(25),
  [Cellphone] varchar(12),
  [Homephone] varchar(12),
  [Workphone] varchar(15),
  [SSN] varchar(11),
  [DOB] varchar(10),
  [Driverlice] char(20),
  [Email] char(50),
  [Famillysize] varchar(15),
  [Pets] vchar(3),
  [Income] decimal(10,2),
  [Gender] char(6),
  [Creditscore] INT,
  PRIMARY KEY ([Tenantid])
);

CREATE TABLE [IncomeCategory] (
  [IncomeCategoryid] varchar(10),
  [CategoryName] varchar(25),
  PRIMARY KEY ([IncomeCategoryid])
);

CREATE TABLE [PreviousAddress] (
  [Tenantid] INT,
  [Prevemployeeid] varchar(5),
  [From] INT,
  [To] INT,
  [IncomeCategoryid] varchar(10),
  [Income] varchar(10),
  PRIMARY KEY ([Tenantid], [Prevemployeeid]),
  CONSTRAINT [FK_PreviousAddress.Tenantid]
    FOREIGN KEY ([Tenantid])
      REFERENCES [Tenant]([Tenantid]),
  CONSTRAINT [FK_PreviousAddress.IncomeCategoryid]
    FOREIGN KEY ([IncomeCategoryid])
      REFERENCES [IncomeCategory]([IncomeCategoryid])
);

CREATE TABLE [EmployeeHistory] (
  [Tenantid] INT,
  [Employeeid] varchar(8),
  [EmployeeName] varchar(50),
  PRIMARY KEY ([Tenantid], [Employeeid]),
  CONSTRAINT [FK_EmployeeHistory.Tenantid]
    FOREIGN KEY ([Tenantid])
      REFERENCES [Tenant]([Tenantid])
);

CREATE TABLE [EmployeeStatus] (
  [Employeestatusid] varchar(10),
  [Name] varchar(50),
  PRIMARY KEY ([Employeestatusid])
);

CREATE TABLE [PropertyTenant] (
  [Propertyid] INT,
  [Tenantid] INT,
  [RentedFrom] varchar(10),
  [ExpirationDate] varchar(10),
  PRIMARY KEY ([Propertyid], [Tenantid]),
  CONSTRAINT [FK_PropertyTenant.Tenantid]
    FOREIGN KEY ([Tenantid])
      REFERENCES [Tenant]([Tenantid]),
  CONSTRAINT [FK_PropertyTenant.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);

CREATE TABLE [MaintenancePlan] (
  [MaintenancePlanid] varchar(5),
  [MaintenancePlanName] varchar(25),
  PRIMARY KEY ([MaintenancePlanid])
);

CREATE TABLE [Maintenance] (
  [Propertyid] INT,
  [Maintenanceid] varchar(5),
  [RepaireItem] varchar(50),
  [MaintenancePlanid] varchar(5),
  PRIMARY KEY ([Propertyid], [Maintenanceid]),
  CONSTRAINT [FK_Maintenance.MaintenancePlanid]
    FOREIGN KEY ([MaintenancePlanid])
      REFERENCES [MaintenancePlan]([MaintenancePlanid]),
  CONSTRAINT [FK_Maintenance.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);

CREATE TABLE [Managementtable] (
  [Managerid] varchar(5),
  [ManagerFname] varchar(50),
  [ManagerLname] varchar(50),
  [Email] varchar(50),
  [Phone] varchar(12),
  [Website] varchar(50),
  [Reportedto] varchar(50),
  PRIMARY KEY ([Managerid])
);

CREATE TABLE [OwnerInformation] (
  [Propertyid] INT,
  [Ownerid] varchar(5),
  [OwnerFname] varchar(50),
  [OwnerLname] varchar(50),
  [Owneremail] varchar(50),
  [Ownerphone] varchar(12),
  [Managerid] varchar(5),
  PRIMARY KEY ([Propertyid], [Ownerid]),
  CONSTRAINT [FK_OwnerInformation.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid]),
  CONSTRAINT [FK_OwnerInformation.Managerid]
    FOREIGN KEY ([Managerid])
      REFERENCES [Managementtable]([Managerid])
);

CREATE TABLE [Paymentmethod] (
  [Paymentmethodid] varchar(5),
  [Paymentmethodname] varchar(20),
  PRIMARY KEY ([Paymentmethodid])
);

CREATE TABLE [PaymentInformation] (
  [Tenantid] INT,
  [Duedate] varchar(15),
  [Payed] char(3),
  [Late] char(3),
  [Paymentmethodid] varchar(5),
  PRIMARY KEY ([Tenantid], [Paymentmethodid]),
  CONSTRAINT [FK_PaymentInformation.Tenantid]
    FOREIGN KEY ([Tenantid])
      REFERENCES [Tenant]([Tenantid]),
  CONSTRAINT [FK_PaymentInformation.Paymentmethodid]
    FOREIGN KEY ([Paymentmethodid])
      REFERENCES [Paymentmethod]([Paymentmethodid])
);

CREATE TABLE [Address] (
  [Addressid] varchar(5),
  [StreetAddress] varchar(50),
  [City] varchar(25),
  [State] varchar(15),
  [Country] varchar(40),
  [Zipcode] varchar(12),
  PRIMARY KEY ([Addressid])
);

CREATE TABLE [Community] (
  [Propertyid] INT,
  [Communityid] varchar(5),
  [CommunityName] varchar(50),
  [Addressid] varchar(5),
  PRIMARY KEY ([Propertyid], [Communityid]),
  CONSTRAINT [FK_Community.Addressid]
    FOREIGN KEY ([Addressid])
      REFERENCES [Address]([Addressid]),
  CONSTRAINT [FK_Community.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);

CREATE TABLE [LeasingType] (
  [LeasingTypeid] varchar(5),
  [LeasingTypeName] varchar(12),
  PRIMARY KEY ([LeasingTypeid])
);

CREATE TABLE [Leasing] (
  [Propertyid] INT,
  [LeasingTypeid] varchar(5),
  [ApllicantfeeinDollar] Decimal(7,2),
  [SecurityDeposite] Decimal(7,2),
  [IS_Lease_Terminationallowed] char(3),
  [Lease_Terminationcost] Decimal(7,2),
  PRIMARY KEY ([Propertyid], [LeasingTypeid]),
  CONSTRAINT [FK_Leasing.LeasingTypeid]
    FOREIGN KEY ([LeasingTypeid])
      REFERENCES [LeasingType]([LeasingTypeid]),
  CONSTRAINT [FK_Leasing.Propertyid]
    FOREIGN KEY ([Propertyid])
      REFERENCES [Property]([Propertyid])
);


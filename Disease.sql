
-- Create statment to create(DDL statment) disease_type table  

CREATE TABLE public.Disease_Type
(
    Disease_Type_Code char(5) PRIMARY KEY,
    Disease_Type_Description Varchar(500)
  );
   
-- Create table syntax for disease table

CREATE TABLE public.Disease
(
    Disease_ID INT generated always as identity primary key,
    Disease_name Varchar(100),
    Intensity_Level_Qty INT,
    Disease_Type_CD char(5),
    CONSTRAINT Fkey_Disease_Type_CD FOREIGN KEY (Disease_Type_CD)
    REFERENCES public.Disease_Type (Disease_Type_Code)
             
);

-- Renaming column name using alter statement

-- alter table public.disease rename column intensity_levely_qty to intensity_level_qty

-- Creating location table 

CREATE TABLE Location
(
    Location_ID INT generated always as identity primary key,
    City_Name VARCHAR(100),
    State_Province_Name VARCHAR(100),
    Country_Name Varchar(100),
    Developing_Flag char(1),
    Wealth_Rank_Number INT
    
);

-- Create race table 

CREATE TABLE public.Race
(
    Race_Code char(5) PRIMARY KEY,
    Race_Description VARCHAR(500)
);

--create insurance table 

CREATE TABLE public.insurance
(
    insurance_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
    company_name character varying(150) ,
    address character varying(150) ,
    contact_details character varying(15),
    CONSTRAINT insurance_pkey PRIMARY KEY (insurance_id)
)

--Create person table 

CREATE TABLE IF NOT EXISTS public.person
(
    person_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
    last_name character varying(50) ,
    first_name character varying(100),
    gender character(1),
    date_of_birth date,
    primary_location_id integer,
    race_cd character(5),
    insurance_id integer,
    CONSTRAINT person_pkey PRIMARY KEY (person_id),
    CONSTRAINT fkey_primary_location_id FOREIGN KEY (primary_location_id)
        REFERENCES public.location (location_id) 
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkey_race_cd FOREIGN KEY (race_cd)
        REFERENCES public.race (race_code) 
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT insurance_id_fkey FOREIGN KEY (insurance_id)
        REFERENCES public.insurance (insurance_id) 
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

-- Alter table statement to add and drop constraint

alter table person add constraint insurance_id_fkey foreign key (insurance_id) 
REFERENCES public.insurance(insurance_id);

alter table person drop constraint insurance_id_fkey foreign key (insurance_id) 
REFERENCES public.insurance(insurance_id);


-- Create diseased Patient table 

CREATE TABLE public.Diseased_Patient
(
    Person_ID INT,
    Disease_ID INT,
    Severity_Value INT,
    Start_Date date,
    End_Date date,
    CONSTRAINT Pkey_Diseased_patient PRIMARY KEY (Person_ID, Disease_ID),
	CONSTRAINT Fkey_Person_ID FOREIGN KEY (Person_ID)
    REFERENCES public.Person (Person_ID),
	CONSTRAINT Fkey_Disease_ID FOREIGN KEY (Disease_ID)
    REFERENCES public.Disease (Disease_ID)
    
);

--Create Race Disease Propensity Table 

CREATE TABLE public.Race_Disease_Propensity
(
    Race_Code char(5),
    Disease_ID int,
    Propensity_Value int,
    CONSTRAINT Pkey_Race_Disease_Propensity PRIMARY KEY (Race_Code,Disease_ID),
    CONSTRAINT Fkey_Race_Code FOREIGN KEY (Race_Code)
    REFERENCES public.Race(Race_Code),
    CONSTRAINT Fkey_Disease_ID FOREIGN KEY (Disease_ID)
    REFERENCES public.Disease (Disease_ID)
);


--Create Medicine table 

CREATE TABLE public.Medicine 
(
   Medicine_ID INT generated always as identity primary key,
   Standard_Industry_Num Varchar(30),
   Medicine_Name Varchar(200),
   Company Varchar(150),
   Active_Ingredient_Name Varchar(200)  
	);


-- Create Indications table 

CREATE TABLE public.indication
(
    Medicine_ID INT ,
    Disease_ID INT,
	Indication_Date DATE,
    Effectiveness_Percent float,
    CONSTRAINT Pkey_Indication PRIMARY KEY (Medicine_ID, Disease_ID),
    CONSTRAINT Fkey_Medicine_ID FOREIGN KEY (Medicine_ID)
    REFERENCES public.Medicine (Medicine_ID),
    CONSTRAINT Fkey_Indication_Disease_ID FOREIGN KEY (Disease_ID)
    REFERENCES public.Disease(Disease_ID)
);



-- Insert data into Disease_Type Table
INSERT INTO disease_type(disease_type_code, disease_type_description) VALUES
    ('DCNCR', 'Cancer is a disease characterized by uncontrollable growth and spreading of body cells.'),
    ('DCNPX', 'Chickenpox is caused by the varicella-zoster virus, resulting in an itchy rash with fluid-filled blisters.'),
    ('DCNCD', 'The common cold is a viral infection affecting the nose and throat, often resulting in mild symptoms.'),
    ('DAIDS', 'Acquired immunodeficiency syndrome (AIDS) is a chronic condition caused by HIV, leading to weakened immunity.'),
    ('DIFZA', 'Flu (influenza) is a respiratory infection causing symptoms such as fever and cough.'),
    ('DMLRA', 'Malaria is a potentially fatal disease transmitted by mosquitoes, causing high fevers and flu-like symptoms.'),
    ('DPLIO', 'Poliomyelitis (polio) is a viral infection affecting the central nervous system, leading to paralysis.'),
    ('DPMNA', 'Pneumonia is a lung infection causing inflammation and respiratory symptoms.'),
    ('DTRCS', 'Tuberculosis (TB) is a bacterial infection primarily affecting the lungs, but can spread to other organs.'),
    ('DCAD', 'Coronary artery disease restricts blood flow to the heart due to cholesterol deposits in arteries.'),
    ('DDSMS', 'Diabetes mellitus affects blood sugar levels, leading to various complications in the body.'),
    ('DSELM', 'Lyme disease is transmitted by ticks, causing symptoms such as fever and skin rash.'),
    ('DMELS', 'Measles is a highly contagious viral illness characterized by fever and rash.'),
    ('DMEGS', 'Meningitis is an inflammation of the membranes surrounding the brain and spinal cord.'),
    ('DMUPS', 'Mumps is a viral infection causing swelling of the salivary glands.'),
    ('DRBLA', 'Rubella is a viral infection causing a mild illness with symptoms such as rash and fever.'),
    ('DSMAS', 'Salmonella infections result from contaminated food or water, leading to gastrointestinal symptoms.'),
    ('DSHGS', 'Shingles is a viral infection causing a painful rash along nerve pathways.'),
    ('DTETU', 'Tetanus is a bacterial infection causing muscle stiffness and spasms.'),
    ('DVIHE', 'Viral hepatitis is a liver infection caused by various hepatitis viruses, leading to liver inflammation.');

-- Insert Data into Disease Table
INSERT INTO disease (disease_name, intensity_level_qty, disease_type_cd) VALUES
    ('Cancer', 10, 'DCNCR'),
    ('Chickenpox', 4, 'DCNPX'),
    ('The common cold', 1, 'DCNCD'),
    ('Acquired immunodeficiency syndrome (AIDS)', 10, 'DAIDS'),
    ('Flu (influenza)', 5, 'DIFZA'),
    ('Malaria', 6, 'DMLRA'),
    ('Coronary artery disease', 10, 'DCAD'),
    ('Poliomyelitis (polio)', 5, 'DPLIO'),
    ('Pneumonia', 7, 'DPMNA'),
    ('Tuberculosis (TB)', 6, 'DTRCS'),
    ('Diabetes mellitus', 8, 'DDSMS'),
    ('Lyme disease', 4, 'DSELM'),
    ('Measles', 8, 'DMELS'),
    ('Meningitis', 7, 'DMEGS'),
    ('Mumps', 6, 'DMUPS'),
    ('Rubella', 8, 'DRBLA'),
    ('Salmonella infections', 4, 'DSMAS'),
    ('Shingles', 4, 'DSHGS'),
    ('Tetanus', 7, 'DTETU'),
    ('Viral hepatitis', 8, 'DVIHE');

-- Inserting Data Into Location Table
INSERT INTO Location (City_Name, State_Province_Name, Country_Name, Developing_Flag, Wealth_Rank_Number) VALUES
    ('New Jersey', 'New York', 'United States', 'Y', 1),
    ('Teltow', 'Berlin', 'Germany', 'Y', 2),
    ('Bordeaux', 'Paris', 'France', 'Y', 4),
    ('Kawasaki', 'Tokyo', 'Japan', 'Y', 3),
    ('Witham', 'Essex', 'England', 'Y', 5),
    ('Capranica', 'Rome', 'Italy', 'Y', 6),
    ('Ontario', 'Toronto', 'Canada', 'Y', 7),
    ('Jaipur', 'Rajasthan', 'India', 'Y', 8),
    ('Dublin', 'Leinstar', 'Ireland', 'Y', 9),
    ('Abuja', 'Nigeria', 'Africa', 'Y', 10);

-- Inserting data into race table
INSERT INTO race (Race_Code, Race_Description) VALUES
    ('ASIAN', 'Asian – Originating from the Far East, Southeast Asia, or the Indian subcontinent.'),
    ('BLACK', 'Black or African American – Originating from any of the Black racial groups of Africa.'),
    ('LATIN', 'Hispanic or Latino – Of Cuban, Mexican, Puerto Rican, South or Central American origin, regardless of race.'),
    ('WHITE', 'White – Identifying with nationalities or ethnic groups from Europe, the Middle East, or North Africa.'),
    ('ARAB', 'Arab – A member of Semitic people from the Middle East and North Africa.'),
    ('WTHPC', 'White Hispanic or Latino – Hispanic or Latino descent, primarily of white Mexican Americans.'),
    ('WSTHC', 'West Indies – Ethnically diverse population from Spanish, French, British, or Dutch colonists.'),
    ('AMNID', 'American Indian or Alaska Native – Native peoples of North and South America with tribal affiliation.'),
    ('PACIF', 'Pacific Islander – Indigenous peoples of the Pacific Islands, including Hawaii and New Zealand.');

-- Inserting data into person table


INSERT INTO PERSON (Last_Name, First_Name, Gender, Date_Of_Birth, Primary_Location_ID, Race_CD) VALUES
    ('Cheng', 'Daniella', 'F', '1989-09-29', 1, 'ASIAN'),
    ('Chen', 'Harshavardhan Sai', 'M', '1992-01-07', 1, 'ASIAN'),
    ('Choi', 'Manasi', 'F', '1999-01-07', 1, 'ASIAN'),
    ('Clarke', 'Daniel', 'M', '1999-12-01', 2, 'WTHPC'),
    ('Clement', 'Sadiqua', 'M', '1979-07-30', 2, 'WTHPC'),
    ('Clyne', 'Dizhanae', 'F', '1999-03-11', 2, 'WTHPC'),
    ('Cohen', 'Wendy', 'F', '1996-01-07', 3, 'WSTHC'),
    ('Colton', 'Jessica', 'F', '1999-03-17', 3, 'WSTHC'),
    ('Creehan', 'Nicole', 'M', '1998-04-01', 3, 'WSTHC'),
    ('Cuch', 'Brittany', 'F', '1975-05-01', 4, 'WHITE'),
    ('Cuesta', 'Doris', 'M', '1999-05-01', 4, 'WHITE'),
    ('Cummins', 'Lauren', 'M', '1998-10-01', 4, 'WHITE'),
    ('Daly', 'Kaitlin', 'F', '1978-05-18', 5, 'AMNID'),
    ('Datuin', 'Leah', 'F', '1999-05-19', 5, 'AMNID'),
    ('Davis', 'Adva', 'F', '1972-05-20', 5, 'AMNID'),
    ('De La Cruz', 'Arianna', 'F', '1967-09-29', 6, 'ARAB'),
    ('De La Rosa', 'ROCIO', 'M', '1998-05-07', 6, 'ARAB'),
    ('De Leon Serrano', 'Diana', 'M', '1997-12-23', 6, 'ARAB'),
    ('Deng', 'Jeeho', 'M', '1977-12-11', 7, 'LATIN'),
    ('Depietri', 'Elham', 'F', '1963-05-14', 7, 'LATIN'),
    ('Deutsch', 'Min', 'M', '1968-04-21', 7, 'LATIN'),
    ('Imhoff', 'Mengyao', 'M', '1998-08-26', 8, 'BLACK'),
    ('Halpert', 'Kairong', 'M', '1997-07-24', 8, 'BLACK'),
    ('Halikias', 'Jinming', 'F', '1995-05-24', 8, 'BLACK');


-- Inserting records into diseased_patient table
INSERT INTO diseased_patient (Person_ID, Disease_ID, Severity_Value, Start_Date, End_Date)
VALUES
    (1, 1, 3, '2015-08-15', '2015-06-15'),
    (2, 2, 1, '1994-08-15', '1997-08-20'),
    (3, 2, 4, '2000-05-01', '2000-05-01'),
    (4, 1, 10, '2015-08-15', '2018-06-15'),
    (5, 7, 3, '2002-09-10', '2002-09-15'),
    (6, 4, 10, '2010-01-01', '2011-02-10'),
    (7, 9, 7, '2012-11-14', '2014-06-15'),
    (8, 10, 6, '2008-05-10', '2008-09-15'),
    (9, 11, 3, '2019-08-15','2019-08-16'),
    (10, 1, 10, '2019-02-07', '2020-01-08'),
    (11, 3, 5, '2007-08-10', '2007-09-15'),
    (12, 6, 3, '2004-10-15', '2004-12-15'),
    (13, 1, 3, '2019-08-02', '2022-06-15'),
    (14, 1, 4, '2002-06-15', '2002-06-21'),
    (15, 2, 5, '2022-04-19', '2022-04-29'),
    (1, 10, 8, '2017-08-15', '2018-06-15'),
    (2, 1, 3, '1980-08-15', '1985-06-15'),
    (2, 3, 3, '2009-05-10', '2009-06-09'),
    (3, 10, 8, '2018-01-15', '2018-03-15'),
    (4, 7, 9, '2002-01-15', '2002-01-31'),
    (5, 2, 6, '2008-10-01', '2008-10-15'),
    (16, 11, 6, '2015-08-15','2019-08-16'),
    (17, 8, 6, '2000-08-15', '2019-08-16'),
    (18, 10, 5, '2001-06-22', '2001-08-15'),
    (19, 7, 7, '2017-09-09', '2017-10-25'),
    (20, 6, 3, '2014-03-10', '2014-06-15'),
    (21, 8, 4, '2007-08-12','2019-08-16');

-- Update statement to update a single row
UPDATE diseased_patient
SET start_date = '2015-06-14'
WHERE end_date = '2015-06-15';

-- Inserting data into Insurance table
INSERT INTO insurance (company_name, address, contact_details) 
VALUES
    ('Blue Cross Blue Shield Association', '225 North Michigan Ave. Chicago, IL 60601', '8554809172'),
    ('Symetra', '8508 Plum Creek Dr. Alabama, AC 52689', '3846228768'),
    ('21st Century Insurance', '9117 Goshen Valley Dr. Alaska, CS 45963', '3815450810'),
    ('Acuity Insurance', '22713 Robin Ct. Arizona, GU 45896', '3676834865'),
    ('Aflac', '8505 Churchill Downs Rd. Connecticut, VHUJO 48952', '3671238495'),
    ('Allianz Life', '22308 Bertie Farm Ct. Georgia, LJ 25689', '3596259824'),
    ('Bankers Life and Casualty Company', '21804 Churchill Downs Ct. Hawaii, ST 69812', '3423322614'),
    ('Berkshire Hathaway', '22521 Sweetleaf Ln. Idaho, IH 12598', '3351514273'),
    ('CareSource', '21628 Goshen Oaks Rd. Indiana, GU 54863', '3325225532'),
    ('Chubb Corp', '21917 Foxlair Rd. Iowa, EV 26589', '3278483984'),
    ('Colonial Life Accident Insurance Company', '22710 Woodfield Rd. Kansas, RU 98561', '3187003242'),
    ('Delta Dental', '22410 Sweetleaf Ln. Kentucky, UI 98512', '2969515920'),
    ('Esurance', '9208 Huntmaster Rd. Louisiana, XU 69842', '2863446574'),
    ('Farmers Insurance Group', '21918 Huntmaster Dr. Maine, TI 85327', '2531318505'),
    ('GAINSCO', '8533 Churchill Downs Rd. Maryland, YA 96584', '2323160705'),
    ('Gerber Life Insurance Company', '9103 Charlie Farm Ct. Massachusetts, RC 98457', '2070961281'),
    ('Gracy Title Company', '01ST Tony ST. Michigan, HC 69842', '5895125698'),
    ('The Guardian Life Insurance Company of America', '06TH HP AVE. Minnesota, BU 98512', '5984809172'),
    ('GuideOne Insurance', '08TH TI ST. Montana, SI 65891', '8894259172'),
    ('Hanover Insurance', '09TH Sunny AVE. New Hampshire, IJ 59841', '6054885672'),
    ('HCC Insurance Holdings', 'SAM JORDANS WAY Ave. Rhode Island, RS 65412', '6854809126'),
    ('Kentucky Farm Bureau', 'ABBEY ST. Utah, BG 98541', '2954569842'),
    ('Liberty Mutual', 'TONI STONE XING. South Carolina, UA 85426', '5453698172'),
    ('Manhattan Life Insurance Company', 'ACACIA ST. South Dakota, TI 87549', '2569809172'),
    ('Society Insurance', 'SHEPHARD PL. Pennsylvania, TU 89547', '2564589172');

-- Insert data into Medicine table
INSERT INTO medicine (Standard_Industry_Num, Medicine_Name, Company, Active_ingredient_Name) 
VALUES
    (23452, 'Acetaminophen', 'McNeil Consumer Healthcare', 'Powdered Cellulose, Pregelatinized Starch'),
    (94488, 'Vitamin D', 'Drisdol', 'CHOLECALCIFEROL, ALPHA.-TOCOPHEROL D'),
    (459627, 'Ibuprofen', 'Motrin', 'p - isobutylphenyl, propionic acid'),
    (458621, 'Levothyroxine', 'Synthroid', 'synthetic crystalline, tetraiodothyronine sodium salt'),
    (895126, 'Lisinopril', 'Prinivil', 'calcium phosphate, mannitol'),
    (789514, 'Amlodipine', 'Norvasc', 'calcium phosphate dibasic, microcrystalline cellulose'),
    (269865, 'Prednisone', 'Deltasone', 'anhydrous lactose, colloidal silicon dioxide'),
    (369547, 'Amphetamine', 'Adderall', 'entactogens,hallucinogens'),
    (589416, 'Albuterol sulfate HFA', 'Ventolin HFA', 'ethanol, oleic acid'),
    (36214, 'Alprazolam', 'Xanax', 'Cellulose, corn starchh'),
    (894126, 'Cyclobenzaprine', 'Flexeril', 'hydroxypropyl cellulose, hydroxypropyl methylcellulose'),
    (125879, 'Azithromycin', 'Zithromax Z-Pak', 'dibasic calcium phosphate anhydrous, pregelatinized starch'),
    (65489, 'Gabapentin', 'Neurontin', 'corn starch, magnesium stearate'),
    (256148, 'Cephalexin', 'Keflex', 'hypromellose, magnesium stearate'),
    (256148, 'Cetirizine', 'Zyrtec', 'pregelatinized starch, lactose'),
    (256148, 'Hydrochlorothiazide', 'Microzide', 'microcrystalline cellulose, pregelatinized starch'),
    (256148, 'Metformin', 'Glucophage', 'pregelatinized starch, magnesium stearate'),
    (256148, 'Atorvastatin', 'Lipitor', 'calcium carbonate, USP'),
    (256148, 'Amoxicillin', 'Augmentin', 'Colloidal Silicon Dioxide, Magnesium Stearate'),
    (256148, 'Vitamin D3', 'D3-50', 'CHOLECALCIFEROL, .ALPHA.-TOCOPHEROL, D-'),
    (256148, 'Benzonatate', 'Tessalon Perles', 'D&C Yellow No. 10, gelatin'),
    (256148, 'Losartan', 'Cozaar', 'lactose monohydrate, starch pregelatinised'),
    (256148, 'Metoprolol succinate ER', 'Toprol XL', 'colloidal silicon dioxide, croscarmellose sodium'),
    (256148, 'Trazodone', 'Desyrel', 'Trazodone hydrochloride, USP'),
    (256148, 'Clonazepam', 'Klonopin', 'docusate sodium, lactose monohydrate'),
    (256148, 'Zolpidem', 'Ambien', 'lactose monohydrate, microcrystalline cellulose'),
    (256148, 'Fluconazole', 'Diflucan', 'microcrystalline cellulose, dibasic calcium'),
    (256148, 'Metronidazole', 'Flagyl', 'corn starch, magnesium stearate'),
    (256148, 'Furosemide', 'Lasix', 'lactose monohydrate NF, magnesium stearate NF'),
    (256148, 'Ferosul', 'ferrous sulfate', 'Microcrystalline, Cellulose');

-- Inserting Data into Race_Disease_propensity table
INSERT INTO Race_Disease_Propensity (Race_code, Disease_ID, Propensity_Value) VALUES
('AMNID', 1, 5),
('AMNID', 2, 6),
('AMNID', 3, 8),
('ARAB', 4, 10),
('ARAB', 2, 8),
('ARAB', 3, 10),
('ASIAN', 10, 5),
('ASIAN', 9, 6),
('ASIAN', 3, 6),
('BLACK', 7, 5),
('BLACK', 10, 1),
('LATIN', 5, 9),
('LATIN', 1, 10),
('LATIN', 2, 9),
('WHITE', 11, 9),
('WHITE', 2, 1),
('WHITE', 9, 9),
('WHITE', 5, 9),
('WSTHC', 2, 10),
('WHITE', 7, 2),
('WHITE', 10, 2),
('WTHPC', 1, 2),
('WTHPC', 2, 3),
('WTHPC', 11, 10);

-- Inserting data into Indication Table
INSERT INTO Indication (Medicine_ID, Disease_ID, Indication_Date, Effectiveness_Percent) VALUES
(1, 1, '2002-07-01', 100),
(1, 2, '2012-09-29', 51.05),
(1, 5, '2019-09-29', 60),
(2, 9, '1999-09-20', 61),
(2, 11, '2002-08-29', 10),
(3, 4, '1999-10-21', 72.09),
(3, 11, '1996-09-29', 50.08),
(4, 7, '1992-03-21', 68),
(7, 7, '2006-09-29', 82),
(5, 9, '2008-09-29', 60),
(6, 11, '2010-07-29', 89),
(6, 10, '2014-10-29', 98),
(9, 8, '2010-09-29', 100),
(19, 6, '2000-06-22', 59),
(20, 9, '2018-09-29', 96),
(17, 11, '2015-07-20', 83.40),
(18, 1, '2012-09-29', 79),
(19, 4, '2012-11-27', 83),
(20, 5, '2024-12-29', 92.20),
(21, 11, '2031-10-26', 57.90),
(22, 9, '2024-09-29', 90.8),
(23, 1, '2035-02-28', 97.80),
(24, 7, '2028-05-24', 32.09),
(25, 7, '2022-09-29', 89.82),
(26, 9, '2027-08-29', 78.89),
(27, 10, '2031-12-29', 90.42),
(28, 11, '2036-09-29', 95.00);

-- Selecting all data from public schema
SELECT * FROM disease;
SELECT * FROM disease_type;
SELECT * FROM diseased_patient;
SELECT * FROM indication;
SELECT * FROM insurance;
SELECT * FROM location;
SELECT * FROM medicine;
SELECT * FROM race;
SELECT * FROM race_disease_propensity;

-- Operational Queries

-- Interesting analyses that can be generated from Disease model (OLTP Database Public Schema)

/* 1. Analyzing trends in disease prevalence:
 This query returns the number of cases and the average severity of each disease */

SELECT disease.disease_name, COUNT(diseased_patient.person_id) AS number_of_cases,
ROUND(AVG(diseased_patient.severity_value), 2) AS average_severity
FROM diseased_patient
INNER JOIN disease ON diseased_patient.disease_id = disease.disease_id
GROUP BY disease.disease_name;

/* 2. Examining the relationship between race and disease propensity:
This query returns the average propensity value for each race and disease combination. */

SELECT race.race_code, disease.disease_name, ROUND(AVG(race_disease_propensity.propensity_value), 2)
AS average_propensity
FROM race_disease_propensity
INNER JOIN race ON race_disease_propensity.race_code = race.race_code
INNER JOIN disease ON race_disease_propensity.disease_id = disease.disease_id
GROUP BY race.race_code, disease.disease_name;

/* 3. Identifying the most effective treatments:
This query returns the medicine with the highest effectiveness percent for each disease. */

SELECT disease.disease_name, medicine.medicine_name, MAX(indication.effectiveness_percent) AS maximum_effectiveness
FROM indication
INNER JOIN disease ON indication.disease_id = disease.disease_id
INNER JOIN medicine ON indication.medicine_id = medicine.medicine_id
GROUP BY disease.disease_name, medicine.medicine_name;

/* 4. Analyzing the distribution of diseases by location:
This query returns the number of cases for each location. */

SELECT location.city_name, location.state_province_name, location.country_name,
COUNT(diseased_patient.person_id) AS number_of_cases
FROM diseased_patient
INNER JOIN person ON diseased_patient.person_id = person.person_id
INNER JOIN location ON person.primary_location_id = location.location_id
GROUP BY location.city_name, location.state_province_name, location.country_name;

/* 5. Query that analyzes the relationship between gender and the prevalence of different diseases in different
countries:
This query returns the number of cases for each disease, country, and gender combination. */

SELECT disease.disease_name, location.country_name, person.gender,
COUNT(diseased_patient.person_id) AS number_of_cases
FROM diseased_patient
INNER JOIN disease ON diseased_patient.disease_id = disease.disease_id
INNER JOIN person ON diseased_patient.person_id = person.person_id
INNER JOIN location ON person.primary_location_id = location.location_id
GROUP BY disease.disease_name, location.country_name, person.gender;

/* 6. Patient and Medicine Information.
This query returns data about each patient's personal information, location, disease,
and the medicine used to treat the disease. */

SELECT p.person_id, CONCAT(p.last_name, ' ', p.first_name) AS "Patient Name", p.gender, l.country_name,
		dp.disease_id, d.disease_name, i.medicine_id, m.medicine_name, i.effectiveness_percent 
		FROM location l INNER JOIN person p ON l.location_id=p.primary_location_id INNER JOIN 
		diseased_patient dp ON p.person_id = dp.person_id INNER JOIN  disease d ON
		dp.disease_id = d.disease_id INNER JOIN indication i ON d.disease_id = i.disease_id
		INNER JOIN medicine m ON m.medicine_id = i.medicine_id
		ORDER BY 1;

/* 7. Maximum Medicine Effectiveness for Each Disease
It returns the name of each disease and the name of the medicine with the highest effectiveness percentage
for that disease. The results are grouped by disease name and sorted by disease name and medicine name. */

SELECT d.disease_name, m.medicine_name, MAX(i.effectiveness_percent)  
		FROM disease d INNER JOIN indication i ON i.disease_id = d.disease_id 
		INNER JOIN  medicine m  ON i.medicine_id = m.medicine_id 
		GROUP BY d.disease_name, m.medicine_name 
		ORDER BY 1, 2, 3;

/* 8. Patient Disease Count by Race
The query returns the data sorted by the count of disease IDs in descending order. 
The results are grouped by patient name and race code, and the count of diseases for each group is returned. */

SELECT CONCAT(p.last_name, ' ', p.first_name) AS "Patient Name", COUNT(dp.disease_id), r.race_code
FROM person p INNER JOIN diseased_patient dp ON p.person_id = dp.person_id 
INNER JOIN race r ON p.race_cd = r.race_code GROUP BY p.last_name, p.first_name, r.race_code 
ORDER BY 2 DESC;

/* 9. Patient Diagnosis and Medicine Information.
The query returns the data sorted in the order it was retrieved. It returns information about each patient's
diagnosis, including the patient's name, age at diagnosis, disease, and the medicine used to treat the 
disease. */

SELECT p.first_name, p.last_name, p.date_of_birth,   
EXTRACT(YEAR FROM dp.start_date) - EXTRACT(YEAR FROM p.date_of_birth) AS age_at_diagnosis,
d.disease_name, m.medicine_name, m.company
FROM diseased_patient dp
JOIN person p ON dp.person_id = p.person_id						
JOIN indication i ON dp.disease_id = i.disease_id
JOIN disease d ON i.disease_id = d.disease_id
JOIN medicine m ON i.medicine_id = m.medicine_id;

/* 10. Procedure that will return the medicine name and its effectiveness. 
It takes disease name as input and returns medicine name and its effectiveness. */

CREATE OR REPLACE FUNCTION get_best_medicine_for_disease_by_name(disease_name VARCHAR(100))
RETURNS TABLE (medicine_name VARCHAR(200), effectiveness_percent FLOAT) AS $$
BEGIN
  RETURN QUERY
  SELECT m.medicine_name, i.effectiveness_percent
  FROM indication i
  JOIN medicine m ON i.medicine_id = m.medicine_id
  JOIN disease d ON i.disease_id = d.disease_id
  WHERE d.disease_name = $1
  ORDER BY i.effectiveness_percent DESC
  LIMIT 1;
END $$
LANGUAGE plpgsql;

-- Use the following statement to fetch the result or call the procedure

SELECT * FROM get_best_medicine_for_disease_by_name('Malaria');


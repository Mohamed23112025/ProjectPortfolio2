  
-- Cleaning Data in SQL Queries

select * 
from portfolioproject.dbo.[Nashville Housing]

 -- standardize date format 
 select  SaleDate ,convert(date, SaleDate)
from portfolioproject.dbo.[Nashville Housing]

Select saleDateConverted, CONVERT(Date,SaleDate)
From portfolioproject.dbo.[Nashville Housing]



Update  [Nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE [Nashville Housing]  
Add SaleDateConverted Date;

Update [Nashville Housing]
SET SaleDateConverted = CONVERT(Date,SaleDate)

--populate property Address date 


Select *
From portfolioproject.dbo.[Nashville Housing]


--where PropertyAddress is null 
order by 2



Select a.ParcelID , a.PropertyAddress , b.ParcelID , b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
From portfolioproject.dbo.[Nashville Housing] a 
join portfolioproject.dbo.[Nashville Housing] b 
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null 

 update a 
 set PropertyAddress= isnull(a.PropertyAddress,b.PropertyAddress)
 From portfolioproject.dbo.[Nashville Housing] a 
join portfolioproject.dbo.[Nashville Housing] b 
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null 

 -- Breaking out Address into Individual colum (add , city ,state )

 select *

 from portfolioproject.dbo.[Nashville Housing]
 
 
 select 
 substring ( PropertyAddress,1, charindex(',', PropertyAddress)-1) as Address
 , substring ( PropertyAddress,charindex(',', PropertyAddress)+1,len(PropertyAddress))  as Address

 from portfolioproject.dbo.[Nashville Housing]

 ALTER TABLE [Nashville Housing]  
Add propertysplitaddrsse nvarchar(255);

Update [Nashville Housing]
SET propertysplitaddrsse =substring ( PropertyAddress,1, charindex(',', PropertyAddress)-1)

 ALTER TABLE [Nashville Housing]  
Add propertysplitcity  nvarchar(255);

Update [Nashville Housing]
SET propertysplitcity = substring ( PropertyAddress,charindex(',', PropertyAddress)+1,len(PropertyAddress))




 select OwnerAddress
  from portfolioproject.dbo.[Nashville Housing]

  select 
  PARSEname(REPLACE(OwnerAddress,',','.'),3)
,  PARSEname(REPLACE(OwnerAddress,',','.'),2)
,  PARSEname(REPLACE(OwnerAddress,',','.'),1)
    from portfolioproject.dbo.[Nashville Housing]

	 ALTER TABLE [Nashville Housing]
	Add ownersplitaddrsse nvarchar(255);

Update [Nashville Housing]
SET ownersplitaddrsse = PARSEname(REPLACE(OwnerAddress,',','.'),3)
	

 
 ALTER TABLE [Nashville Housing]  
	Add ownersplitcity   nvarchar(255)

Update [Nashville Housing]
SET ownersplitcity = PARSEname(REPLACE(OwnerAddress,',','.'),2)


 ALTER TABLE [Nashville Housing]  
	Add ownersplitstate  nvarchar(255);

Update [Nashville Housing]
SET ownersplitstate  = substring ( PropertyAddress,charindex(',', PropertyAddress)+1,len(PropertyAddress))

select *
  from portfolioproject.dbo.[Nashville Housing]
  

  -- change Y and N to Yes and No

  select distinct(SoldAsVacant), count (SoldAsVacant)
  from portfolioproject.dbo.[Nashville Housing]
  Group by SoldAsVacant
  order by SoldAsVacant

  select SoldAsVacant,
  case when SoldAsVacant ='Y' then 'yes'
   when  SoldAsVacant ='N' then 'No'
   else SoldAsVacant
   end
  from portfolioproject.dbo.[Nashville Housing]

  Update [Nashville Housing]
  set SoldAsVacant = 
   case when SoldAsVacant ='Y' then 'yes'
   when  SoldAsVacant ='N' then 'No'
   else SoldAsVacant
   end
     select distinct(SoldAsVacant), count (SoldAsVacant)
  from portfolioproject.dbo.[Nashville Housing]
  Group by SoldAsVacant
  order by SoldAsVacant

  -- remove dublication 
 with  rownumCTE as (
 select *, 
 ROW_NUMBER () over (
  partition by	parcelid,
				propertyaddress,
				saleprice ,
				saledate,
				legalreference 
				order by 
				uniqueid  ) row_num 
 
 from portfolioproject.dbo.[Nashville Housing]

 )
select * 
 from rownumCTE
  where row_num >1

  -- Delete unused colums 
  
select *
  from portfolioproject.dbo.[Nashville Housing]
  
  
  
  alter table portfolioproject.dbo.[Nashville Housing]
  drop column    TaxDistrict
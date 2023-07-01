
--Cleaning Data in SQL queries
Select*
From portfolio_project.dbo.[Nashville Housing]

--Standarize Sale date
Select SaleDateConverted, Convert(Date, SaleDate)
From portfolio_project.dbo.[Nashville Housing]

Update portfolio_project.dbo.[Nashville Housing]
Set SaleDate = Convert(Date,Saledate)

Alter Table portfolio_project.dbo.[Nashville Housing]
Add SaleDateConverted Date;

Update portfolio_project.dbo.[Nashville Housing]
Set SaleDateConverted = Convert(Date,SaleDate)

--Populate property address
Select PropertyAddress
From portfolio_project.dbo.[Nashville Housing]
--Where PropertyAddress is null
Order by ParcelID;

Select a.ParcelID, a.PropertyAddress, b. ParcelID, b. PropertyAddress,
ISNULL(a.PropertyAddress, b. PropertyAddress)
From portfolio_project.dbo.[Nashville Housing] a
Join portfolio_project.dbo.[Nashville Housing] b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b. [UniqueID]
Where a.PropertyAddress is Null;

--The following populates an address in the Property address column contain NULL values. The propertyAddress are esentially a match to a specific parcelID
Update a
Set PropertyAddress = IsNull(a.PropertyAddress, b. PropertyAddress)
From portfolio_project.dbo.[Nashville Housing] a
Join portfolio_project.dbo.[Nashville Housing] b
on a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b. [UniqueID]
Where a.PropertyAddress is Null;

--Breaking out address into individal columns 
Select PropertyAddress
From portfolio_project.dbo.[Nashville Housing]

Select 
Substring(PropertyAddress, 1, Charindex(',', PropertyAddress)-1) as Address,
	Substring(PropertyAddress, Charindex(',', PropertyAddress)+1, Len(PropertyAddress)) as Address

--We are looking at the 1st position until the string reaches (,). The -1 pulls results from every string BEFORE the comma (,) appears. 

From portfolio_project.dbo.[Nashville Housing]

Alter Table portfolio_project.dbo.[Nashville Housing]
Add PropertySplitCity Nvarchar (255);

Update portfolio_project.dbo.[Nashville Housing]
Set PropertySplitAddress = Substring(PropertyAddress, 1, Charindex(',', PropertyAddress) -1)

Alter Table portfolio_project.dbo.[Nashville Housing]
Add PropertySplitAddress Nvarchar (255);

Update portfolio_project.dbo.[Nashville Housing]
Set PropertySplitCity = Substring(PropertyAddress, Charindex(',', PropertyAddress)+1, Len(PropertyAddress))

Select *
From portfolio_project.dbo.[Nashville Housing]

--Spliting OwnerAddress into three columns one containing ADDRESS, CITY AND STATE
Select 
PARSENAME (Replace (OwnerAddress, ',', '.'),3),
PARSENAME (Replace (OwnerAddress, ',', '.'),2),
PARSENAME (Replace (OwnerAddress, ',', '.'),1)
From portfolio_project.dbo.[Nashville Housing]

Alter Table portfolio_project.dbo.[Nashville Housing]
Add OwnerSplitAddress Nvarchar (255);

Update portfolio_project.dbo.[Nashville Housing]
Set OwnerSplitAddress = PARSENAME (Replace (OwnerAddress, ',', '.'),3)

Alter Table portfolio_project.dbo.[Nashville Housing]
Add OwnerSplitCity Nvarchar (255);

Update portfolio_project.dbo.[Nashville Housing]
Set OwnerSplitCity = PARSENAME (Replace (OwnerAddress, ',', '.'),2)

Alter Table portfolio_project.dbo.[Nashville Housing]
Add OwnerSplitState Nvarchar (255);

Update portfolio_project.dbo.[Nashville Housing]
Set OwnerSplitState = PARSENAME (Replace (OwnerAddress, ',', '.'),1)

--change Y and N to Yes and NO in "SoldAsVacant" field

Select *
From portfolio_project.dbo.[Nashville Housing]

Select Distinct (SoldAsVacant), Count (SoldAsVacant)
From portfolio_project.dbo.[Nashville Housing]
Group by SoldAsVacant
Order by 2

Select (SoldAsVacant),
	Case When SoldAsVacant = 'Y' Then 'yes'
		 When SoldAsVacant = 'N' Then 'No'
			Else SoldAsVacant 
			End
From portfolio_project.dbo.[Nashville Housing]

Update portfolio_project.dbo.[Nashville Housing]
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'yes'
		 When SoldAsVacant = 'N' Then 'No'
			Else SoldAsVacant 
			End

--Remove duplicates
With RowNumCTE As(
Select*,
	Row_Number() Over
	(Partition By ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order by UniqueID) Row_num
From portfolio_project.dbo.[Nashville Housing]
--Order by ParcelID
)
--Change Delete to Select* to verify if duplicates have been removed
Delete
From RowNumCTE
Where Row_num > 1
--Order by PropertyAddress

--Delete Unused columns
Select*
From portfolio_project.dbo.[Nashville Housing]

Alter Table portfolio_project.dbo.[Nashville Housing]
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter table portfolio_project.dbo.[Nashville Housing]
Drop Column SaleDate
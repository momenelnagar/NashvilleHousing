select PropertyAddress
from [NashvilleHousing ]

select SaleDate
from [NashvilleHousing ] 

select *
from [NashvilleHousing ]
order by ParcelID


select a.ParcelID , a.PropertyAddress ,b.ParcelID ,b.PropertyAddress , ISNULL(a.PropertyAddress,b.PropertyAddress)
from [NashvilleHousing ] a
join [NashvilleHousing ] b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from [NashvilleHousing ] a
join [NashvilleHousing ] b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


select 
substring(PropertyAddress, 1 , CHARINDEX(',', PropertyAddress)-1) as address
,substring(PropertyAddress , CHARINDEX(',', PropertyAddress)+1 , LEN(propertyaddress))
from [NashvilleHousing ] 



alter table [NashvilleHousing ]
add streetaddress nvarchar(255)

update [NashvilleHousing ]
set streetaddress = substring(PropertyAddress, 1 , CHARINDEX(',', PropertyAddress)-1)



alter table [NashvilleHousing ]
add city nvarchar(255)

update [NashvilleHousing ]
set city = substring(PropertyAddress , CHARINDEX(',', PropertyAddress)+1 , LEN(propertyaddress))


select 
substring(OwnerAddress, 1 , CHARINDEX(',', OwnerAddress)-1) as address
,substring(OwnerAddress , CHARINDEX(',', OwnerAddress)+12 , LEN(OwnerAddress))
from [NashvilleHousing ] 


select 
PARSENAME(replace(owneraddress, ',', '.' ) ,3)
,PARSENAME(replace(owneraddress, ',', '.' ) ,2)
,PARSENAME(replace(owneraddress, ',', '.' ) ,1)
from [NashvilleHousing ]


alter table [NashvilleHousing ]
add ownersplitaddress nvarchar(255)

update [NashvilleHousing ]
set ownersplitaddress = PARSENAME(replace(owneraddress, ',', '.' ) ,3)



alter table [NashvilleHousing ]
add ownercity nvarchar(255)

update [NashvilleHousing ]
set ownercity = PARSENAME(replace(owneraddress, ',', '.' ) ,2)



alter table [NashvilleHousing ]
add ownerstate nvarchar(255)

update [NashvilleHousing ]
set ownerstate = PARSENAME(replace(owneraddress, ',', '.' ) ,1)


select *
from [NashvilleHousing ]


select distinct (SoldAsVacant) , count(SoldAsVacant)
from [NashvilleHousing ]
group by SoldAsVacant
order by 2


--remove duplicate
with rownumcte as (
select * ,
   row_number() over(
   partition by 
   ParcelID,
   propertyaddress,
   saledate,
   saleprice,
   ownername,
   owneraddress order by uniqueID) row_num
		 
from [NashvilleHousing ] 
)

select *
from rownumcte 
where row_num > 1



alter table [NashvilleHousing ] 
drop column owneraddress, taxdistrict ,propertyaddress


select distinct ownercity
from [NashvilleHousing ]


select *
from [NashvilleHousing ]

select convert(money ,TotalValue )
from [NashvilleHousing ]


update [NashvilleHousing ]
set TotalValue = convert(money ,TotalValue )

alter table [NashvilleHousing ]
alter column TotalValue money
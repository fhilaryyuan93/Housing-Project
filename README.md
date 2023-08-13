# Housing-Project

## Overview

This is a SQL project that focuses on data cleaning within SQL. The data used is the Nashville Housing which consists of information about the housing including sale dates, sale as vacant, address and more. 

## Process
Standardizing the Sale date was the first task completed so the column reads year, month, then day.  The next task was populating Null values in the property address with actual address. This required exploring the date and noticing the owner address is matched with a unique ID. In which case, the null values were replaced with owner address based on the assigned unique ID. The Address column was a bit busy, consisting of address, city and state therefore, resulting in the analysis process being a bit more difficult. To resolve this, the Parsename function was used to delimit the address, city and state into individual columns. To keep the Sold As Vacant column clean and simple, the Y and N were replaced with Yes and No. Instead of consisting of 4 values (Y, N, Yes, No), the column is reduced to 2 values after clean to only Yes and No. Finally, to show cast how columns and tables can be deleted the DELETE statement was used to remove a table and the DROP statement was used to remove fields. 

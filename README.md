# SQL Project 1: Olist public data importing
**Author**: Chinh X. Mai, **Date**: July 18, 2022

![README_banner](https://user-images.githubusercontent.com/89245616/179500856-363711c0-2b7f-465e-bd68-be96a4c59e93.png)

## Brazilian E-Commerce Public Dataset by Olist 

Welcome! This is a Brazilian ecommerce public dataset of orders made at [Olist Store](https://olist.com/pt-br/). The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and finally reviews written by customers. We also released a geolocation dataset that relates Brazilian zip codes to lat/lng coordinates.

This is real commercial data, it has been anonymised, and references to the companies and partners in the review text have been replaced with the names of Game of Thrones great houses.

**Context**

This dataset was generously provided by Olist, the largest department store in Brazilian marketplaces. Olist connects small businesses from all over Brazil to channels without hassle and with a single contract. Those merchants are able to sell their products through the Olist Store and ship them directly to the customers using Olist logistics partners. See more on our website: www.olist.com

After a customer purchases the product from Olist Store a seller gets notified to fulfill that order. Once the customer receives the product, or the estimated delivery date is due, the customer gets a satisfaction survey by email where he can give a note for the purchase experience and write down some comments.

**Acknowledgements**

Thanks to Olist for releasing this dataset.

# Executive summary

This project establishes a data schema containing all the data in the **Olist** set following the given structure of the publisher. The original data stored in separate csv files have been imported to separate tables in a schema with proper data type assigned to all variables. The project achieves the following points:

* Creating a schema to store data tables replicating the data structure given by the publisher of the Olist data set
* Creating tables following a logical order so that all the connections among the tables are properly preserved
* Importing the data simultaneously with the table creations and adjusting the data when necessary
* Assigning suitable data types to the given data, which contain three main types: integer, numeric, text, and timestamp
* Checking the result by using the schema information table
* Constructing the entity relationship diagram for comparing the structure of the imported and the original databased

The data is now ready to be extracted and manipulated using SQL queries. The next steps might be exploratory analysis and data visualization so that more insights can be gained for further investigations.

## Detailed documentation

For detailed documentation, please refer to the Github repository using the following link

[SQL Project 1 Github](https://github.com/ChinhMaiGit/Project-SQL-1/)

or access the analysis workbook directly

[SQL project 1 Workbook](/html/project1.html)


## References

1. [Olist public data on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

# SQL Data Warehouse Project

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![SQL Server](https://img.shields.io/badge/database-SQL%20Server-red.svg)
![Architecture](https://img.shields.io/badge/architecture-Medallion-gold.svg)

A comprehensive data warehouse implementation using SQL Server that follows the **Medallion Architecture** (Bronze-Silver-Gold layers) to transform raw data from multiple source systems into analytics-ready datasets.

## 🏗️ Architecture Overview

This project implements a **three-tier medallion architecture**:

- **🥉 Bronze Layer**: Raw data ingestion from source systems
- **🥈 Silver Layer**: Cleaned and validated data with business rules applied
- **🥇 Gold Layer**: Aggregated, business-ready data for analytics and reporting

## 📊 Data Sources

The warehouse integrates data from two primary source systems:

### CRM System (`dataset/source_crm/`)
- **Customer Information** (`cust_info.csv`) - Customer demographics and details
- **Product Information** (`prd_info.csv`) - Product catalog and specifications  
- **Sales Details** (`sales_details.csv`) - Transaction records and sales data

### ERP System (`dataset/source_erp/`)
- **Customer Data** (`CUST_AZ12.CSV`) - Extended customer information
- **Location Data** (`LOC_A101.csv`) - Geographic and location details
- **Product Categories** (`PX_CAT_G1V2.csv`) - Product categorization data

## 🗂️ Project Structure

sql_dataWareHouse_project/
├── dataset/ # Source data files
│ ├── source_crm/ # CRM system data
│ └── source_erp/ # ERP system data
├── docs/ # Documentation and diagrams
│ ├── data_catalog.md # Data dictionary and catalog
│ ├── data_architecture.png # Architecture diagram
│ ├── data_flow.png # Data flow visualization
│ ├── data_model.png # Data model diagram
│ └── data_integration.png # Integration architecture
├── scripts/ # SQL scripts organized by layer
│ ├── init_database.sql # Database initialization
│ ├── bronze/ # Bronze layer scripts
│ │ ├── ddl_bronze.sql # Bronze table definitions
│ │ └── proc_load_bronze.SQL # Bronze data loading procedures
│ ├── silver/ # Silver layer scripts
│ │ ├── ddl_silver.sql # Silver table definitions
│ │ └── proc_load_silver.sql # Silver transformation procedures
│ └── gold/ # Gold layer scripts
│ └── ddl_gold # Gold layer table definitions
├── tests/ # Data quality and validation tests
│ ├── quality_checks_silver.sql # Silver layer quality tests
│ └── quality_check_gold.sql # Gold layer quality tests
├── LICENSE # MIT License
└── README.md # This file


## 🚀 Getting Started

### Prerequisites
- SQL Server 2016 or later
- SQL Server Management Studio (SSMS) or Azure Data Studio
- Appropriate permissions to create databases and bulk insert data

### Installation Steps

1. **Clone the repository**
git clone https://github.com/trishita-26/sql_dataWareHouse_project.git
cd sql_dataWareHouse_project
2. **Initialize the database**
-- Run the database initialization script
sqlcmd -S your_server -d master -i scripts/init_database.sql
3. **Create Bronze layer tables**
sqlcmd -S your_server -d DataWarehouse -i scripts/bronze/ddl_bronze.sql
4. **Create Silver layer tables**
sqlcmd -S your_server -d DataWarehouse -i scripts/silver/ddl_silver.sql
5. **Create Gold layer tables**
sqlcmd -S your_server -d DataWarehouse -i scripts/gold/ddl_gold


## 📈 Data Pipeline Process

### 1. **Bronze Layer** - Raw Data Ingestion
- Uses `BULK INSERT` operations to load CSV files directly into staging tables
- Preserves original data structure and format
- Includes audit columns for data lineage tracking

### 2. **Silver Layer** - Data Cleansing & Transformation
- Applies data quality rules and business logic
- Handles data type conversions and standardization
- Implements slowly changing dimensions (SCD) where applicable
- Removes duplicates and validates data integrity

### 3. **Gold Layer** - Business-Ready Analytics
- Creates aggregated tables optimized for reporting
- Implements star schema design for dimensional modeling
- Provides pre-calculated metrics and KPIs

## 🔍 Data Quality & Testing

The project includes comprehensive data quality checks:

- **Silver Layer Tests** (`tests/quality_checks_silver.sql`)
- Data completeness validation
- Referential integrity checks
- Business rule validation

- **Gold Layer Tests** (`tests/quality_check_gold.sql`)
- Aggregation accuracy verification
- Performance benchmarking
- Data consistency validation

## 📚 Documentation

Detailed documentation is available in the `docs/` directory:

- **Data Catalog** - Complete data dictionary and metadata
- **Architecture Diagrams** - Visual representation of system design
- **Data Flow Diagrams** - End-to-end data processing flow
- **Data Model** - Entity relationship diagrams

## 🛠️ Key Features

- ✅ **Medallion Architecture** - Industry-standard three-tier design
- ✅ **Multi-Source Integration** - Combines CRM and ERP data
- ✅ **Data Quality Framework** - Comprehensive testing and validation
- ✅ **Incremental Loading** - Efficient data processing with stored procedures
- ✅ **Comprehensive Documentation** - Detailed guides and diagrams
- ✅ **Scalable Design** - Easy to extend with additional data sources

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:
- Additional data quality checks
- Performance optimizations
- Documentation improvements
- New data source integrations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Trishita** - [@trishita-26](https://github.com/trishita-26)

---

⭐ **Star this repository** if you find it helpful for your data warehouse projects!

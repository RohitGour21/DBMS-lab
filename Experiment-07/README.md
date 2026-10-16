# Experiment 7: Database Normalization (UNF to BCNF)

## Aim
To identify functional dependencies in a denormalized Sales table and normalize the relation step-by-step from UNF to 3NF and BCNF, verifying lossless join and dependency preservation properties.

## Theory
* **Normalization:** The systematic process of structuring relational tables to minimize data redundancy and anomalies.
* **1NF:** Eliminates repeating groups and ensures atomic attribute values.
* **2NF:** Removes partial functional dependencies (where non-key attributes depend on part of a composite key).
* **3NF:** Eliminates transitive dependencies (non-key attributes depending on other non-key attributes).
* **BCNF (Boyce-Codd Normalform):** Stronger than 3NF, requiring that for every functional dependency $X \rightarrow Y$, $X$ must be a superkey.

## Decomposition Summary
* **Customers Table:** `customer_id` $\rightarrow$ `customer_name`, `customer_city`
* **Salespersons Table:** `salesperson_id` $\rightarrow$ `salesperson_name`
* **Products Table:** `product_id` $\rightarrow$ `product_name`, `price`
* **Orders & Order_Details Tables:** Decomposed to maintain atomic quantities and primary key constraints without data loss.

## Usage / Execution Instructions
1. Run the script to create the Unnormalized Form (`Sales_UNF`) table and insert sample data.
2. Execute sequential creation scripts for 1NF, 2NF, 3NF, and BCNF tables.
3. Run verification queries to test dependency constraints and validate lossless joins.

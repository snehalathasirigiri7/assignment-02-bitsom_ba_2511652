## Storage Systems
To meet the hospital’s four goals, a combination of OLTP, streaming, analytical, and AI‑optimized storage systems is required.
For predicting patient readmission risk, a Data Lakehouse (Delta Lake / Apache Iceberg) is the best fit. Historical treatments, diagnoses, lab values, and past admissions span structured and semi‑structured formats. A lakehouse enables large‑scale batch training, time‑travel queries, ACID reliability, and efficient model retraining using Spark/Databricks-style compute engines.
For doctor-friendly plain-English history queries, an NLP retrieval system backed by a Vector Database (e.g., Pinecone, Weaviate, FAISS) is ideal. Patient records from the OLTP system are periodically embedded using a clinical‑tuned embedding model. These embeddings enable semantic search so doctors’ questions such as “Has this patient had a prior cardiac event?” can retrieve relevant notes even when vocabulary differs (“MI”, “STEMI”, “cardiac arrest”). The source-of-truth data remains in the EHR, but the vector DB accelerates semantic lookup.
For management reporting (bed occupancy, monthly departmental spend), a Data Warehouse or Lakehouse SQL layer is required. A lakehouse warehouse (e.g., Delta + Photon/Trino/BigQuery) provides high-performance OLAP queries without duplicate storage. Aggregated tables (bed_utilization_fact, finance_fact) are derived from operational systems and stored in columnar form for fast BI dashboards.
Finally, streaming ICU vitals require a high-throughput, fault‑tolerant ingestion layer such as Kafka or Azure Event Hub, combined with a streaming storage sink (Delta Live Tables / Iceberg streaming tables). This ensures vitals (heart rate, SPO2, ECG waveforms) are persisted in real time with schema evolution support. The same stream can feed alerting engines, live monitors, and longer-term clinical research datasets.

## OLTP vs OLAP Boundary
The OLTP boundary ends at the hospital’s EHR/Clinical Database, which manages live patient data—registrations, treatments, medication orders, physician notes, billing events, and real-time updates. This system is designed for correctness, ACID guarantees, rapid reads/writes, and patient safety. No analytical workloads run here.
The OLAP boundary begins once data is replicated or streamed into the Lakehouse. From this point onward, data is optimized for analytical read patterns, batch processing, aggregations, and machine learning. ETL/ELT pipelines transform clinical, operational, and financial data into analytical fact/dimension models. The vector database, BI layer, and ML training all interact with data only after it reaches the OLAP environment, ensuring the operational EHR remains unaffected by heavy workloads.

## Trade-offs
A major trade-off in this architecture is the duplication of patient information across multiple storage systems—the OLTP database (source of truth), the Lakehouse (analytics/ML), and the Vector DB (semantic search). This increases governance complexity and requires strict synchronization to avoid outdated embeddings or stale analytical data.
To mitigate this, the system should implement:

Automated incremental pipelines that refresh Lakehouse tables using CDC (Change Data Capture).
Event-driven embedding refresh triggered only when a patient’s clinical notes or diagnoses change.
Centralized data governance with lineage tracking (e.g., Unity Catalog / DataHub) ensuring full visibility of how patient records propagate.

This approach preserves performance while ensuring updates propagate reliably across all downstream AI and reporting systems.   
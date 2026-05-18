"""
Download the full Los Angeles Crime Data dataset from:
https://data.lacity.org/resource/2nrs-mtv8.json

The Socrata API returns a maximum of 1,000 rows by default.
This script uses $limit and $offset to download all rows in batches.

Output:
    - la_crime_data_raw.csv
    - la_crime_data_raw.parquet (optional, if pyarrow is installed)

Requirements:
    pip install pandas requests tqdm pyarrow
"""

import requests
import pandas as pd
from tqdm import tqdm

# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------
BASE_URL = "https://data.lacity.org/resource/2nrs-mtv8.json"

BATCH_SIZE = 1000      # Recommended by LA Open Data
MAX_ROWS = None        # Set to an integer for testing, e.g. 5000
APP_TOKEN = None       # Optional: Add your Socrata App Token here

CSV_OUTPUT = "la_crime_data_raw.csv"
PARQUET_OUTPUT = "la_crime_data_raw.parquet"

# -------------------------------------------------------------------
# Session setup
# -------------------------------------------------------------------
session = requests.Session()

if APP_TOKEN:
    session.headers.update({"X-App-Token": APP_TOKEN})

# -------------------------------------------------------------------
# Function to fetch one batch
# -------------------------------------------------------------------
def fetch_batch(offset, limit=BATCH_SIZE):
    params = {
        "$limit": limit,
        "$offset": offset
    }

    response = session.get(BASE_URL, params=params, timeout=60)
    response.raise_for_status()
    return response.json()

# -------------------------------------------------------------------
# Download all data
# -------------------------------------------------------------------
all_rows = []
offset = 0

print("Downloading LA Crime Data...")

with tqdm(desc="Rows downloaded", unit=" rows") as pbar:
    while True:
        batch = fetch_batch(offset)

        # Stop if no rows returned
        if not batch:
            break

        all_rows.extend(batch)

        rows_downloaded = len(batch)
        pbar.update(rows_downloaded)

        offset += rows_downloaded

        # Optional test limit
        if MAX_ROWS and len(all_rows) >= MAX_ROWS:
            all_rows = all_rows[:MAX_ROWS]
            break

print(f"\nDownload complete: {len(all_rows):,} rows")

# -------------------------------------------------------------------
# Convert to DataFrame
# -------------------------------------------------------------------
df = pd.DataFrame(all_rows)

print(f"DataFrame shape: {df.shape}")
print("\nColumns:")
print(df.columns.tolist())

# -------------------------------------------------------------------
# Convert date columns (if present)
# -------------------------------------------------------------------
date_columns = [
    "date_occ",
    "date_rptd"
]

for col in date_columns:
    if col in df.columns:
        df[col] = pd.to_datetime(df[col], errors="coerce")

# -------------------------------------------------------------------
# Convert latitude/longitude to numeric
# -------------------------------------------------------------------
for col in ["lat", "lon"]:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")

# -------------------------------------------------------------------
# Save to CSV
# -------------------------------------------------------------------
df.to_csv(CSV_OUTPUT, index=False)
print(f"\nSaved CSV: {CSV_OUTPUT}")

# -------------------------------------------------------------------
# Save to Parquet (optional)
# -------------------------------------------------------------------
try:
    df.to_parquet(PARQUET_OUTPUT, index=False)
    print(f"Saved Parquet: {PARQUET_OUTPUT}")
except Exception as e:
    print(f"Parquet not saved: {e}")

# -------------------------------------------------------------------
# Basic data quality checks
# -------------------------------------------------------------------
if {"lat", "lon"}.issubset(df.columns):
    valid_coords = df["lat"].notna() & df["lon"].notna()
    print(f"\nRows with valid coordinates: {valid_coords.sum():,}")
    print(f"Rows missing coordinates: {(~valid_coords).sum():,}")

print("\nPreview:")
print(df.head())
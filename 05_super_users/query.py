# python -m pip install oracledb numpy pyarrow polars --upgrade
import numpy as np
import polars as pl
import oracledb
import pyarrow

try:
    conn=oracledb.connect(user="[Username]", password="[Password]", dsn="localhost:1521/FREEPDB1")
    table="SELECT * FROM USERS_P5"
    odf=conn.fetch_df_all(statement=table,arraysize=100)
    pyarrow_table=pyarrow.Table.from_arrays(odf.column_arrays(),names=odf.column_names())
    users=pl.from_arrow(pyarrow_table)
    superusers=(users.sort(by=['USER_ID','TRANSACTION_DATE'])
                     .with_columns(SUPERUSER_DATE=pl.col('TRANSACTION_DATE')
                                                    .shift(-1)
                                                    .over(partition_by='USER_ID')
                      )
                     .group_by('USER_ID')
                     .first()
                     .select(pl.col('USER_ID')
                             ,pl.col('SUPERUSER_DATE')
                      )
    )
    print(f'Convertion date to superusers using Polars:\n{superusers}')          
finally:
    conn.close()

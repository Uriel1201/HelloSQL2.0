# pip install pandas
# pip install numpy
# pip install SQLAlchemy
# pip install cx_Oracle

import pandas as pd
import numpy as np
import cx_Oracle
import sqlalchemy
from sqlalchemy.exc import SQLAlchemyError

try:
    # Cadena de conexión a la base de datos (reemplaza con tus propios detalles)
    engine=sqlalchemy.create_engine("oracle+cx_oracle://usr:pswd@localhost/?service_name=orclpdb1", arraysize=1000)

    # Consulta SQL para obtener los datos
    table="""SELECT * FROM FRIENDS_P9;"""
    
    # Leer datos en un DataFrame de pandas
    friends=pd.read_sql(table,engine)
    
    most_friended=(pd.concat([friends['user_1']
                              ,friends['user_2']
                             ]
                      )
                     .reset_index()
                     .drop(columns=['index'])
                     .rename(columns={0:'friend_id'})
                     .groupby('friend_id')
                     .size()
                     .sort_values(ascending=False)
    )
    print(f'number of friends by each user:\n{most_friended}')
     
except SQLAlchemyError as e:
    print(f"Error al conectar a la base de datos o al ejecutar la consulta: {e}")

finally:
    # Opcional: Cerrar la conexión si es necesario, pero SQLAlchemy se encarga de gestionarla generalmente.
    if 'engine' in locals():
        engine.dispose()

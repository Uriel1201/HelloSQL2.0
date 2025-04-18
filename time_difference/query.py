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
    table="""SELECT * FROM USERS_P4;"""
    
    # Leer datos en un DataFrame de pandas
    users=pd.read_sql(table, engine)
    print(users)

    
    # e_t: 'Elapsed time between the last two actions'
    e_t=(users.sort_values(by=['User_id', 'Action_date']
                           ,ascending=[True,False]
               )
              .groupby('User_id'
                       ,as_index=False
               )
              .agg(Ranked_one=('Action_date'
                               ,'first'
                   )
                   ,Ranked_two=('Action_date'
                                ,lambda x:
                                        x.iloc[1] if len(x)>1 else pd.NaT
                    )
               )
              .assign(Elapsed_time=lambda x: 
                                          x['Ranked_one']-x['Ranked_two']
               )
    )
    print(e_t[['User_id','Elapsed_time']])
    
except SQLAlchemyError as e:
    print(f"Error al conectar a la base de datos o al ejecutar la consulta: {e}")

finally:
    # Opcional: Cerrar la conexión si es necesario, pero SQLAlchemy se encarga de gestionarla generalmente.
    if 'engine' in locals():
        engine.dispose()

# Need

## Package

### _Python_

env Python : 
```
python3 -m venv venv
```

activate env :
```
source venv/bin/activate
```  

install package :
```
pip install requests
```

check package's list:
```
pip list
```

save requirement :
```
pip freeze > requirements.txt
```

install from requirements:
```
pip install -r requirements.txt
```


### Fast Api

```
pip install fastapi uvicorn
```
```
# main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}

@app.get("/users/{user_id}")
def read_user(user_id: int):
    return {"user_id": user_id, "name": "UserName"}


# Visit: http://localhost:8000/users/1
# Docs: http://localhost:8000/docs
```

Run :
```
uvicorn main:app --reload
```


### Alembic

Create Migrations : 
```
alembic revision --autogenerate -m "message"
```
Apply pending Migration : 
```
alembic upgrade head
```
Go back : 
```
alembic downgrade -1
```
Check history :
```
alembic history 
```

Check Current DB : 
````
alembic current
````

Remove Version Alembic :
```
rm alembic/versions/<filesName>.py
```

### SQLAlchemy Enums with PostgreSQL

By default, `sqlalchemy.Enum` creates a **native Postgres type** (not just a column constraint).
This means adding a new value to an Enum later requires a manual migration step —
Alembic's autogenerate won't handle it reliably inside a transaction.

**Manual migration to add a new Enum value:**
op.execute("ALTER TYPE actiontype ADD VALUE 'new_value'")

(Replace `actiontype` with your actual Postgres type name, check it in DBeaver if unsure — lowercase by default.)

**Alternative — avoid native Postgres Enum entirely:**
```python
actionType = Column(SAEnum(ActionType, native_enum=False), nullable=False)
```
This stores the Enum as a `VARCHAR` with a `CHECK` constraint instead of a native type.
Adding a new value then only requires a normal Alembic migration — no manual `ALTER TYPE` needed.

Trade-off: native Enum is stricter/cleaner at the DB level, but harder to evolve.
`native_enum=False` is easier to maintain long-term if the Enum is expected to grow.
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
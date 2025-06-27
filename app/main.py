from fastapi import FastAPI, Security, HTTPException, Depends
from fastapi.security.api_key import APIKeyHeader
from starlette.status import HTTP_403_FORBIDDEN
import os

API_KEY = os.getenv("API_KEY")
print(API_KEY)  # For debugging only, remove in production

API_KEY_NAME = "X-Key"  # Header name, keep consistent case

api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)

async def get_api_key(api_key: str = Security(api_key_header)):
    if api_key == API_KEY:
        return api_key
    raise HTTPException(
        status_code=HTTP_403_FORBIDDEN,
        detail="Invalid or missing API Key",
    )

app = FastAPI()

@app.get("/test")
async def test(api_key: str = Depends(get_api_key)):
    return {"response": "it works!"}
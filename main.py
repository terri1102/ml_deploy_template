from fastapi import FastAPI, status
from fastapi.responses import Response
from modules.utils.logger import ApplicationLogger

logger = ApplicationLogger()

app = FastAPI(
    title="My App",
    version="0.0.1",
    contact={"email": "user@example.com"}
    )

@app.get("/health", tags=["Health Check"])
def health_check():
    return Response(status_code=status.HTTP_200_OK)

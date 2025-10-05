import pickle
import os
import pandas as pd
from fastapi import FastAPI, HTTPException
from contextlib import asynccontextmanager
from .schemas import ModelInput, PredictionOut

# --- Configuration ---
# API metadata and model path are defined directly in this file.
API_TITLE = "ML Model API"
API_DESCRIPTION = "API for serving a trained machine learning model."
API_VERSION = "0.1.0"
MODEL_NAME = "your_model.pkl"

# Construct the full path to the model file.
# This assumes the 'models' directory is one level up from the 'app' directory.
MODEL_PATH = os.path.join(os.path.dirname(__file__), "..", "models", MODEL_NAME)


# --- Lifespan Function for Model Loading ---
# This is the new, recommended way to handle startup/shutdown logic.
@asynccontextmanager
async def lifespan(app: FastAPI):
    # This block runs ONCE, when the application starts up.
    print("Application startup...")
    try:
        with open(MODEL_PATH, "rb") as f:
            app.state.model = pickle.load(f) # Store the model in the app state
        print(f"Model '{MODEL_NAME}' loaded successfully.")
    except FileNotFoundError:
        print(f"ERROR: Model file not found at {MODEL_PATH}")
        app.state.model = None
    except Exception as e:
        print(f"An error occurred while loading the model: {e}")
        app.state.model = None
    
    yield # The application runs after this yield

    # This block runs ONCE, when the application shuts down.
    print("Application shutdown...")
    # You can add cleanup code here if needed, e.g., closing database connections.


# Create the FastAPI app instance, now with the lifespan manager
app = FastAPI(
    title=API_TITLE,
    description=API_DESCRIPTION,
    version=API_VERSION,
    lifespan=lifespan
)


# --- API Endpoints ---
@app.get("/")
def read_root():
    """Root endpoint to check if the API is running."""
    return {"status": "ok", "message": "Welcome to the Model Serving API!"}


@app.post("/predict", response_model=PredictionOut)
def predict(data: ModelInput):
    """
    Accepts input data, makes a prediction using the loaded model,
    and returns the result.
    """
    # Access the model from the application state
    if app.state.model is None:
        raise HTTPException(
            status_code=503,
            detail="Model is not loaded. The service might be starting up or has encountered an error."
        )

    try:
        # Convert the Pydantic model to a pandas DataFrame
        input_df = pd.DataFrame([data.dict()])
        
        # Make a prediction
        prediction_result = app.state.model.predict(input_df)[0]

        return {"prediction": prediction_result}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred during prediction: {str(e)}")


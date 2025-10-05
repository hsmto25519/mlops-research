from pydantic import BaseModel, Field
from typing import List

# This schema defines the structure of the input data for your model.
# TODO: Replace these fields with the actual features your model requires.
class ModelInput(BaseModel):
    """
    Input features for the model prediction.
    """
    feature_1: float = Field(..., example=5.1, description="Description for feature 1")
    feature_2: float = Field(..., example=3.5, description="Description for feature 2")
    feature_3: float = Field(..., example=1.4, description="Description for feature 3")
    feature_4: float = Field(..., example=0.2, description="Description for feature 4")

# This schema defines the structure of the prediction response.
class PredictionOut(BaseModel):
    """
    Output structure for the model's prediction.
    """
    prediction: float = Field(..., example=0.0, description="The raw prediction output from the model.")

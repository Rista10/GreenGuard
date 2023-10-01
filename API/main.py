import tensorflow as tf
from fastapi import FastAPI ,File, UploadFile
from io import BytesIO
import numpy as np
import sqlite3
import uvicorn
from PIL import Image
import requests
import shelve 

app= FastAPI()

MODEL= tf.keras.models.load_model("../saved_models/2")



 
# print("All entries are successfully made inside the sample shelve file")  
# # Importing the Shelve Module  
 
# # Opening the sample shelve file with open() function  
# shelveVariable = shelve.open("information")  
# # Print all data entries from the sample shelve file in list form  
# print("Items in the sample shelve file: ", list(shelveVariable.items()))  

CLASS_NAMES=[
 "Apple___healthy",
 "Apple___Apple_scab",
 "Apple___Black_rot",
 "Apple___Cedar_apple_rust",
 "Potato___Early_blight",
 "Potato___Late_blight",
 "Potato___healthy",
 "Tomato___Bacterial_spot",
 "Tomato___Early_blight"]


# Define a function to read the uploaded file as an image
def read_file_as_image(data)-> np.ndarray:
 image = np.array ( Image.open (BytesIO( data )))
 return image

@app.post("/upload/")
async def upload_file(
    file:UploadFile= File(...)
):
    
    image = read_file_as_image(await file.read())
    image_batch=np.expand_dims(image,0)

    predictions = MODEL.predict(image_batch)
    predicted_class = CLASS_NAMES[np.argmax( predictions[0])]

    confidence = np.max(predictions[0])

    return{'class':predicted_class,
            'confidence':float(confidence)
        }
    

temp =0
humidity_glob  =0
heatindex_glob =0
moisturevalue_glob =0
   
@app.get("/update_sensor")
def update_sensor(temperature,humidity,heatindex,moisturevalue):

    global temp ,humidity_glob,heatindex_glob,moisturevalue_glob
    temp=temperature
    humidity_glob=humidity
    heatindex_glob=heatindex
    moisturevalue_glob=moisturevalue

    
    return {"temperature": temperature, "humidity": humidity,"heatindex":heatindex,"moisturevalue":moisturevalue}




@app.get("/view_sensor_data")
def view_sensor():
  
    print(temp)
    return {"temperature": temp,"humid":humidity_glob,"heatindex":heatindex_glob,"moisturevalue":moisturevalue_glob}


if __name__ == "__main__":
    uvicorn.run(app,host='localhost',port=8000)
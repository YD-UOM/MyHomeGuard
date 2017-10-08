#The liabray used for Post Http requests
import requests
import json
#Headers required for the azure API
headers={
    "Accept":"application/json",
    "ZUMO-API-VERSION":"2.0.0",
    "Content-Type":"application/json"
        }

#The libraries for Azure Blob Service
from azure.storage.blob import BlockBlobService
from azure.storage.blob import PublicAccess
from azure.storage.blob import ContentSettings
#Login creadential for accesing the Azure Blob Service
block_blob_service = BlockBlobService(account_name='myhomeguard',account_key='J/CHcStS9xZ31YH3y2gGsbWKJCxNAxcHqsSinkyvMHUm6++jcTSPgVDCmnKo/BTpleR4nhd65vmYhhSkwScvRw==')
block_blob_service.create_container('mycontainer',public_access=PublicAccess.Container)
#Address to store the image, it will be used to create image url later
imageAddress="https://myhomeguard.blob.core.windows.net/mycontainer/"

#The Lirabries for the Raspberry Pi Device, GPIO is used for control and monitor the GPIO Pin,picamera
#is used to control the camera
import RPi.GPIO as GPIO
import time
import picamera

#Initialise the GPIO setting
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
#Pin 11 will monitor the PIR Sensor Output
GPIO.setup(11,GPIO.IN)
GPIO.setup(3,GPIO.OUT)
camera=picamera.PiCamera()

#Use step to let the system reminder which step(No Intruders or Intruder detected) the system is.
step=1

#used to create the image name
imageid=0
try:
    while True:
        #check the out put of PIR Sensor Output
        i=GPIO.input(11)
        
        #when the PIR Sensor is sleep
        if i==0 and step==1:
            print "No intruders", i
            GPIO.output(3,0)
            step=0
        # when the PIR Sensor is active
        elif i==1 and step==0:
            print "Intruder detected",i
            #lighting the signal light
            GPIO.output(3,1)
            imagename='pic'+str(imageid)+'.jpg'
            #Camera take apicture
            camera.capture(imagename)
            time.sleep(1)
            print("picture done")
            #upload the image to the azure blob storage
            block_blob_service.create_blob_from_path(
                'mycontainer',
                imagename,
                imagename,
                content_settings=ContentSettings(content_type='image/jpg')
                )
            print("picture uploaded")
            #Set up the Json
            imageurl=imageAddress+imagename
            datas={
                "text":"Raspberry Detect a new ",
                "imageurl":imageurl,
                "complete":False
                }
            #Send the Json meesage to the azure easy table
            requests.post("http://myhomeguard.azurewebsites.net/tables/TodoItem",data=json.dumps(datas),headers=headers)

            step=1
            imageid=imageid+1
        time.sleep(1)

except KeyboardInterrupt:
    print "System Exit"
finally:
    print "GPIO has been cleaned up"
    GPIO.cleanup()

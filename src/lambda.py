import json
import logging
import boto3
from boto3.dynamodb.conditions import Attr, Key
from botocore.exceptions import ClientError
from decimal import Decimal

class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return str(obj)
        return json.JSONEncoder.default(self, obj)

logger = logging.getLogger(__name__)

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('tmnt-demo')

def get_data(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('tmnt-demo')

    query_params = event['queryStringParameters']
    objName = query_params['name'] if 'name' in query_params else None
    objType = query_params['type'] if 'type' in query_params else None
    
    if objName and objType:
        result = table.query(
            KeyConditionExpression=Key('type').eq(objType) & Key('name').eq(objName)
        )
    elif objName:
        result = table.scan(
            FilterExpression=Attr('name').eq(objName)
        )
    elif objType:
        result = table.scan(
            FilterExpression=Attr('type').eq(objType)
        )
    else:
        result = table.scan()
    
    return result['Items']

def lambda_handler(event, context):
    response = get_data(event, context)
    print("This is the response:\n")
    print(response)

    returnObject = {}
    returnObject['statusCode'] = 200
    returnObject['headers'] = {}
    returnObject['headers']['Content-Type'] = 'application/json'
    returnObject['body'] = json.dumps(response, cls=DecimalEncoder)

    return returnObject

# def lambda_handler(event, coVntext):
#     name          = event['queryStringParameters']['name']
#     type          = event['queryStringParameters']['type']
#     species       = event['queryStringParameters']['species']
#     age           = event['queryStringParameters']['age']
#     height        = event['queryStringParameters']['height']
#     weight        = event['queryStringParameters']['weight']
#     favorite_food = event['queryStringParameters']['favorite_food']

#     print("Name: " + name)
#     print("Type: " + type)
#     print("Species: " + species)
#     print("Age: " + age)
#     print("Height: " + height)
#     print("Weight: " + weight)
#     print("Favorite food: " + favorite_food)
    
#     response = {}
#     response['name'] = name
#     response['type'] = type
#     response['species'] = species
#     response['age'] = age
#     response['height'] = height
#     response['weight'] = weight
#     response['favorite_food'] = favorite_food
    
#     responseObject = {}
#     responseObject['statusCode'] = 200
#     responseObject['headers'] = {}
#     responseObject['headers']['Content-Type'] = 'application/json'
#     responseObject['body'] = json.dumps(response)
    
#     return responseObject

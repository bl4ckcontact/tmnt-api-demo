import json
import boto3

# def lambda_handler(event, context):
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

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('tmnt-demo')

def lambda_handler(event, context):
    name = event['queryStringParameters']['name']
    response = table.get_item(Key={'name': name})
    print(response)
    return {
        'statusCode': 200,
        'body': str(response)
    }
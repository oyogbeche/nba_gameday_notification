import json
import boto3
import os
from botocore.exceptions import ClientError

# Initialize the DynamoDB resource and ses 
dynamodb = boto3.resource('dynamodb')
ses_client = boto3.client('ses', region_name='eu-west-1')

def lambda_handler(event, context):
    
    # Get the table name from the environment variable
    table_name = os.getenv('DYNAMODB_TABLE')
    if not table_name:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "DYNAMODB_TABLE env variable not set"})
        }
    
    # Get the DynamoDB table
    table = dynamodb.Table(table_name)
    
    try:
        # Parse the request body
        body = json.loads(event['body'])
        email = body.get('email')
        preferences = body.get('preferences')
        
        # Validate required fields
        if not email or not preferences:
            return {
                "statusCode": 400,
                "body": json.dumps({"error": f"Invalid input: 'email' and 'preferences' are required"})
            }
        
        
        # Save the item to DynamoDB
        table.put_item(Item={
                'user_id': email,
                'preferences': preferences
            })
        ses_client.verify_email_identity(EmailAddress=email)
        
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Data saved successfully!"})
        }
    
    except ClientError as e:
        # Handle DynamoDB-specific errors
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"DynamoDB ClientError: {str(e)}"})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"Unexpected error: {str(e)}"})
        }
import os
import json
import urllib.request
import boto3
from datetime import datetime, timedelta, timezone

def format_game_data(game):
    status = game.get("Status", "Unknown")
    away_team = game.get("AwayTeam", "Unknown")
    home_team = game.get("HomeTeam", "Unknown")
    final_score = f"{game.get('AwayTeamScore', 'N/A')}-{game.get('HomeTeamScore', 'N/A')}"
    start_time = game.get("DateTime", "Unknown")
    channel = game.get("Channel", "Unknown")
    
    # Format quarters
    quarters = game.get("Quarters", [])
    quarter_scores = ', '.join([f"Q{q['Number']}: {q.get('AwayScore', 'N/A')}-{q.get('HomeScore', 'N/A')}" for q in quarters])
    
    if status == "Final":
        return (
            f"Game Status: {status}\n"
            f"{away_team} vs {home_team}\n"
            f"Final Score: {final_score}\n"
            f"Start Time: {start_time}\n"
            f"Channel: {channel}\n"
            f"Quarter Scores: {quarter_scores}\n"
        )
    elif status == "InProgress":
        last_play = game.get("LastPlay", "N/A")
        return (
            f"Game Status: {status}\n"
            f"{away_team} vs {home_team}\n"
            f"Current Score: {final_score}\n"
            f"Last Play: {last_play}\n"
            f"Channel: {channel}\n"
        )
    elif status == "Scheduled":
        return (
            f"Game Status: {status}\n"
            f"{away_team} vs {home_team}\n"
            f"Start Time: {start_time}\n"
            f"Channel: {channel}\n"
        )
    else:
        return (
            f"Game Status: {status}\n"
            f"{away_team} vs {home_team}\n"
            f"Details are unavailable at the moment.\n"
        )

def fetch_user_preferences(table):
    """Fetch user preferences from DynamoDB."""
    try:
        response = table.scan()
        return response.get('Items', []) 
    except Exception as e:
        print(f"Error fetching user preferences: {e}")
        return []


def match_user_preference(preferences, games):
    matched = []
    for game in games:
        if isinstance(game, str):  # If formatted strings
            if any(pref in game for pref in preferences):
                matched.append(game)
        elif isinstance(game, dict):  # If raw game data
            if any(pref in (game.get("AwayTeam", "") + game.get("HomeTeam", "")) for pref in preferences):
                matched.append(game)
    return matched

def send_message(email, matched_games, origin_email):
    try:
        ses = boto3.client('ses', region_name='eu-west-1') 
        subject = "NBA GameDay Update"
        body_text = f"Hello,\n\nHere are your favorite games:\n\n"
        body_text += "\n".join([f"- {game}" for game in matched_games])
        body_text += "\n\nEnjoy the games!"

        ses.send_email(
            Source=origin_email,
            Destination={'ToAddresses': [email]},
            Message={
                'Subject': {'Data': subject, 'Charset': 'UTF-8'},
                'Body': {'Text': {'Data': body_text, 'Charset': 'UTF-8'}}
            }
        )
        print(f"Email sent successfully to {email}")
    except Exception as e:
        print(f"Error sending email to {email}: {e}")

def process_user_preferences(users, games, origin_email):
    for user in users:
        email = user.get('user_id')
        preferences = user.get('preferences', [])
        
        if not email or not preferences:
            print(f"Skipping user with missing data: {user}")
            continue
        
        # Match user preferences with games
        matched_games = match_user_preference(preferences, games)
        
        if matched_games:
            # Send personalized email
            send_message(email, matched_games, origin_email)
        else:
            print(f"No matched games for user {email}")


def lambda_handler(event, context):
    # Get environment variables
    api_key = os.getenv("NBA_API_KEY")
    table_name = os.getenv("DYNAMODB_TABLE")
    origin_email = os.getenv("SES_EMAIL")
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)
    ses = boto3.client('ses', region_name='eu-west-1')  
    
    # Adjust for west african time (UTC-1)
    utc_now = datetime.now(timezone.utc)
    west_africa_time = utc_now - timedelta(hours=1)  # West African Time is UTC-1
    today_date = west_africa_time.strftime("%Y-%m-%d")
    
    print(f"Fetching games for date: {today_date}")
    
    # Fetch data from the API
    api_url = f"https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/{today_date}?key={api_key}"
    print(today_date)
     
    try:
        with urllib.request.urlopen(api_url) as response:
            data = json.loads(response.read().decode())
            print(json.dumps(data, indent=4))  # Debugging: log the raw data
    except Exception as e:
        print(f"Error fetching data from API: {e}")
        return {"statusCode": 500, "body": "Error fetching data"}
    
    # Include all games (final, in-progress, and scheduled)
    games = [format_game_data(game) for game in data] 
    users = fetch_user_preferences(table)
    process_user_preferences(users, games, origin_email)
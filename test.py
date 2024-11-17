import requests

url = "https://thecorporation.space/api/v0/influence_system/ranks"

try:
    response = requests.get(url)
    response.raise_for_status()  # Check if the request was successful
    data = response.json()
    print(data)
except requests.exceptions.RequestException as e:
    print(f"An error occurred: {e}")
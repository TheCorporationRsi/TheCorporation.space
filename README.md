# TheCorporation.space

Foobar is a Python library for dealing with word pluralization.

## Installation step

-Use pip to install all the requirement

```bash
pip install -r requirements.txt
```

- Create a json file at this path called config.json


```bash
#linux
sudo touch /etc/config.json
sudo nano /etc/config.json

#windows
New-Item -Path '/etc' -ItemType Directory
New-Item -Path '/etc/config.json' -ItemType File
notepad.exe /etc/config.json

```
```json
{
    "SECRET_KEY": "create_your_own_secret_key",
    "SQLALCHEMY_DATABASE_URI": "sqlite:///site.db",
    "EMAIL_USER": "enter_your_gmail",
    "EMAIL_PASS": "enter_gmail_password",
    "DISCORD_ID": "enter_discord_api_id",
    "DISCORD_SECRET":"enter_discord_secret",
    "DISCORD_BOT_TOKEN": "enter_discord_bot_token",
    "RECAP_PRVKEY":"enter_recapcha_private_key",
    "RECAP_PUBKEY":"enter_recapcha_public_key"
}
```
- Create an empty database
```bash
python create_empty_database.py
```

From there all should work except maybe discord AUTH.


## Usage

Please follow this tutorial to understand the code structure: 

https://www.youtube.com/playlist?list=PL-osiE80TeTs4UjLw5MM6OjgkjFeUxCYH

- debug setting  
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "run.py",
                "FLASK_ENV": "development",
                "FLASK_DEBUG": "1",
                "TESTING":"True" 
            },
            "args": [
                "run",
                "--no-debugger",
                "--no-reload"
            ],
            "jinja": true
        },
        {
            "type": "pwa-chrome",
            "request": "launch",
            "name": "Launch Chrome against localhost",
            "url": "http://localhost:8080",
            "webRoot": "${workspaceFolder}"
        }
    ]
}
```



## License
This is the property of TheCorporation.space
You may ask CyberDreamer#9412 on discord before reusing the code.

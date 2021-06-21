# TheCorporation.space

This program need python3.9

## Installation step

- Use pip to install all the requirement

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
    "DISCORD_BOT_TOKEN": "enter_bot_token",
    "DISCORD_REDIRECT_URI":"localhost:5000/discord_callback",
    "DISCORD_BOT_IPC_SECRET": "create_your_own_IPC_secret_key",
    "DISCORD_PUBLIC_KEY": "",
    "RECAP_PRVKEY":"6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe",
    "RECAP_PUBKEY":"6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI"
}
```
- SECRET_KEY : Random characters, you can simply google hex key generator
- SQLALCHEMY_DATABASE_URI : keep like it is
- EMAIL_USER : "enter_your_gmail"
- EMAIL_PASS : email password or API specific password
- DISCORD_ID : Discord API id from https://discord.com/developers/applications
- DISCORD_SECRET : Discord API secret key
- DISCORD_BOT_TOKEN : Discord BOT token
- DISCORD_REDIRECT_URI : keep the same thing, but the fact that it need https will prevent it to work
- RECAP_PRVKEY : private key, you have to create your own application on https://cloud.google.com
- RECAP_PUBKEY : public key
<br />
<br />

- Create an empty database (you have to respond a question while the program run)
```bash
python create_empty_database.py
```

From there all should work except maybe discord AUTH.


## Usage

Please follow this tutorial to understand the code structure: 

https://www.youtube.com/playlist?list=PL-osiE80TeTs4UjLw5MM6OjgkjFeUxCYH

For debugging, use VSCode Debugger (the config is already set).


## License
Permission is granted to The Corporation (CORP), a Star Citizen community, to use and edit the following project as needed. The project can be copy onto another repository as long as it is for the use of The Corporation only and that the previous participants are clearly stated onto the new repository.

Before reusing the code for another project, you must ask the permission of the owner, CyberDreamer. Please contact: gata23laroche@gmail.com.

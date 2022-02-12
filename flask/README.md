# TheCorporation.space

This program need python3.9

## Installation step

- Use pip to install all the requirement

```bash
pip install -r requirements.txt
```

- Create a json file called config.json in the parent folder of the application folder.


```json
{
    "SECRET_KEY": "create_your_own_secret_key",
    "SQLALCHEMY_DATABASE_URI": "sqlite:///site.db",
    "SQLALCHEMY_DATABASE_TEST_URI": "sqlite:///test.db",
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
- The 2 next are preset with test key. Do not use them on production interface:
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



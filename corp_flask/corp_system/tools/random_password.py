import random
import string

def generate_memorable_password(length=32):
    # List of Star Citizen ships
    ships = [
        "Aurora", "Constellation", "Hornet", "Cutlass", "Avenger", "Gladius", "Vanguard",
        "Freelancer", "Starfarer", "Carrack", "Reclaimer", "Prospector", "Caterpillar",
        "Buccaneer", "Herald", "Terrapin", "Dragonfly", "Nox", "Sabre", "Raven", "Eclipse",
        "Hurricane", "Hammerhead", "Valkyrie", "Cyclone", "Nova", "Prowler", "Banu", "Defender"
    ]
    special_chars = "!@#$%^&*"
    
    # Choose random ships
    password = ''.join(random.choice(ships) for _ in range(2))
    
    # Add random digits and special characters
    password += ''.join(random.choice(string.digits) for _ in range(2))
    password += ''.join(random.choice(special_chars) for _ in range(2))
    
    # Shuffle the password to mix the characters
    password = list(password)
    random.shuffle(password)
    
    return ''.join(password)
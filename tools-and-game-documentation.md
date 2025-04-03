# Gaming Companion Overlay Tool
## Tools and Game Documentation

This document outlines the essential documentation required for the development, integration, and maintenance of the Gaming Companion Overlay Tool. It provides a comprehensive overview of both the development tools and the game-specific documentation needed to successfully implement and maintain the project.

### 1. Development Tools Documentation


| Service | Documentation Purpose | URL/Resource |
|---------|----------------------|--------------|
| **Stripe** | Payment processing integration | [Stripe Documentation](https://stripe.com/docs) |
| **OpenAI API** | AI integration for dynamic content | [OpenAI API Documentation](https://platform.openai.com/docs/) |



### 2. Game Integration Documentation

For each supported game, we need specific documentation to properly integrate with the overlay system and provide accurate, helpful guidance to users.


#### 2.2 Elden Ring

| Documentation Type | Purpose | Source |
|-------------------|---------|--------|
| **Game Structure** | Quest and progression systems | [Elden Ring Wiki](https://eldenring.wiki.fextralife.com/) |
| **Window Management** | Overlay compatibility | [Windows API Documentation](https://docs.microsoft.com/en-us/windows/win32/) |
| **Content Guidelines** | Legal usage of game information | [Bandai Namco Terms of Service](https://www.bandainamcoent.com/legal) |

#### 2.3 Baldur's Gate 3

| Documentation Type | Purpose | Source |
|-------------------|---------|--------|
| **Game Systems** | Quest, dialogue, and combat mechanics | [BG3 Wiki](https://baldursgate3.wiki.fextralife.com/) |
| **Windowed Mode** | Overlay compatibility | [Larian Studios Support](https://larian.com/support/baldur-s-gate-3) |
| **Game Data Structure** | Understanding quest and progression data | [Community Resources](https://github.com/Larian-Studios) |

External APIs and game content:

https://github.com/deliton/eldenring-api.  
https://plasticmacaroni.github.io/bg3-missables/
https://github.com/plasticmacaroni/bg3-missables?tab=readme-ov-file




#### 3.2 Data Management

| Documentation | Purpose | Resource |
|---------------|---------|----------|
| **JSON Structure** | Format for game data storage | [JSON Documentation](https://www.json.org/) |


### 4. Content Creation Documentation

#### 4.1 Game Data Pack Structure

The following documentation outlines the format and structure required for creating consistent, usable game data packs:

```json
{
  "game_id": "world_of_warcraft",
  "version": "1.0.0",
  "last_updated": "2024-03-23",
  "content": {
    "quests": [
      {
        "id": "q12345",
        "name": "Quest Name",
        "zone": "Zone Name",
        "level": 60,
        "type": "Main Story",
        "steps": [
          {
            "step_id": 1,
            "description": "Step description",
            "hints": [
              "Hint 1",
              "Hint 2"
            ],
            "coordinates": {
              "x": 45.2,
              "y": 67.8
            }
          }
        ],
        "rewards": [
          {
            "type": "item",
            "id": "i789",
            "name": "Item Name"
          }
        ]
      }
    ],
    "dungeons": [ /* similar structure */ ],
    "bosses": [ /* similar structure */ ]
  }
}
```

#### 4.2 Formatting Guidelines

| Element | Format | Example |
|---------|--------|---------|
| **Quest Names** | Title Case | "The Forgotten Shrine" |
| **Descriptions** | Complete sentences with proper punctuation | "Travel to the northern part of Elwynn Forest to find the abandoned shrine." |
| **Coordinates** | Decimal values to one decimal place | {"x": 45.2, "y": 67.8} |
| **Item IDs** | Game-specific ID format | "i12345" or game's native ID system |

#### 4.3 Content Sourcing Guidelines

| Source Type | Usage Guidelines | Legal Considerations |
|-------------|------------------|----------------------|
| **Official Game Guides** | Reference only, reformatting required | Copyright restrictions apply, no direct copying |
| **Wiki Content** | Check license, attribution may be required | Varies by wiki, some use Creative Commons licensing |
| **Community Guides** | Permission required, proper attribution | Respect original creator's rights |
| **Generated Content** | Can be used freely if created for this project | Verify AI-generated content for accuracy |

### 5. User Documentation Requirements

#### 5.1 Installation Guide Documentation

Documentation should include clear instructions for:

1. Downloading the application
2. Installation process
3. Account creation
4. Payment processing
5. Initial setup and configuration
6. Game-specific setup instructions

#### 5.2 Usage Documentation

Documentation should cover:

1. Overlay activation and control
2. Navigation through available guides
3. Customization options
4. Hotkey configuration
5. Game-specific features
6. Troubleshooting common issues

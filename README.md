# Disable the "Private Attribution" setting in all Firefox profiles

Utility to disable the "Private Attribution" setting in all Firefox profiles.

## What is Private Attribution?

Firefox has a setting in about:config called `dom.private-attribution.submission.enabled`.

**Purpose:** This setting is part of Firefox's efforts to support privacy-friendly ways for advertisers and websites to measure ad effectiveness without compromising user privacy.

**Function:** When enabled, it allows Firefox to participate in the Private Attribution reporting process, which helps measure ad conversions while preserving user privacy.

**Privacy focus:** The system is designed to provide useful data to advertisers and websites without allowing them to track individual users across sites.

**Experimental feature:** This is part of ongoing work in web standards and browser implementations to balance marketing needs with user privacy.


**Default state:** As of the 23rd of August, 2024, this setting was `enabled` in all my Firefox profiles.

_This script has only been tested for Firefox v129.0 in macOS in August 2024_

## Scripts

### 1. `disable-private-attribution-in-firefox-profiles.sh`

This script is the primary tool in this repository. It is designed to disable private attribution in all Firefox profiles on your system. Private attribution refers to tracking mechanisms that might be enabled in Firefox to provide anonymous attribution for advertising. This script modifies the necessary configuration files to ensure that these features are disabled.

#### Usage

```bash
./disable-private-attribution-in-firefox-profiles.sh
```

#### How It Works

- Traverse the standard MacOS Firefox profile directories.
- Add the user_pref to disable private attribution features to the `prefs.js` file within each profile.
- The script is designed to be safe and only modifies the necessary lines in the configuration files.

#### Requirements

- MacOS (tested on macOS Sonoma)
- Firefox (tested on Firefox v129.0)

### 2. `remove-duplicate-lines-from-firefox-prefs.sh`

If you run the `disable-private-attribution-in-firefox-profiles.sh` more than once you will get copies of the last line in the `prefs.js` file. This script will remove the duplicates.

#### Usage

```bash
./remove-duplicate-lines-from-firefox-prefs.sh
```

#### How It Works

- Traverse the standard MacOS Firefox profile directories.
- Remove duplicate lines from tail of the `prefs.js` file within each profile.

#### Requirements



## Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/jordiroca/disable-private-attribution-in-firefox-profiles.git
   cd disable-private-attribution-in-firefox-profiles
   ```

2. Make the scripts executable:

   ```bash
   chmod +x disable-private-attribution-in-firefox-profiles.sh
   chmod +x remove-duplicate-lines-from-firefox-prefs.sh
   ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


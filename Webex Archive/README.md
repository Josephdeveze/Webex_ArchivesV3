# Bulk Export - Archive All Webex Spaces

Automate the archiving of ALL your Webex spaces using `generate_space_batch.py` to create HTML archives of every conversation.

## Requirements

- Python 3.9 or higher
- Python `requests` library: `pip install requests`
- Active Webex account
- Webex Personal Access Token (valid for 12 hours)

## Quick Start

### Step 1: Get Your Webex Access Token

1. Go to [developer.webex.com](https://developer.webex.com/docs/getting-started)
2. Login (top right)
3. Scroll down to "Your Personal Access Token"
4. Copy the token

**Note**: Token expires after 12 hours. You'll need to refresh it for subsequent runs.

### Step 2: Configure the Token

**Option A: Environment Variable (Recommended)**

Windows:
```cmd
set WEBEX_ARCHIVE_TOKEN=YOUR_TOKEN_HERE
```

Mac/Linux:
```bash
export WEBEX_ARCHIVE_TOKEN='YOUR_TOKEN_HERE'
```

**Option B: Edit the Script**

Edit line 27 in `generate_space_batch.py`:
```python
ACCESS_TOKEN = "__YOUR_TOKEN_HERE__"
```

Edit line 4 in `webex-space-archive.py`:
```bash
mytoken = __YOUR_TOKEN_HERE__
```

### Step 3: Generate the Batch Script

Run the generator:
```bash
python generate_space_batch.py
```

This creates `webex-space-archive-ALL.sh` containing commands to archive all your spaces.

### Step 4: Configure Archive Settings (Optional, you can use the existing one)

Before running the batch script, create a configuration file:

```bash
python webex-space-archive.py
```

This generates `webexspacearchive-config.ini`. Edit it to customize:

- `download`: `no` | `info` | `images` | `files`
- `maxtotalmessages`: number of messages or days (e.g., `1000` or `60d`)
- `useravatar`: `no` | `link` | `download`
- `outputjson`: `no` | `yes` | `json` | `txt`

### Step 5: Execute the Batch Script

**Mac/Linux:**
```bash
sh webex-space-archive-ALL.sh
```

**Windows:**
```cmd
bash webex-space-archive-ALL.sh
```

## Output Structure

Each space creates its own folder
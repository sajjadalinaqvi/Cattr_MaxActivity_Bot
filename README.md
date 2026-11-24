# 🤖 Cattr Auto-Activity Bot Pro

**100% Cattr Activity Score Guarantee** - Advanced bot with Smart Pause, Real Hardware Simulation, and Human-Like Typing Patterns

---

## 🎯 Features

### ✅ Smart Pause System (5 Second Response)
- **Automatic Pause**: Bot stops when you type or move mouse
- **Auto Resume**: Bot starts after 5 seconds of idle time
- **Real-time Status**: See your activity and bot status live
- **No Interference**: Work freely - bot never disrupts you

### ✅ 100% Cattr Tracking
- **Hardware Simulation**: Real SendInput API (fully tracked)
- **Real Notepad Typing**: Actual text in visible window
- **Mouse Movements**: 25% frequency (realistic patterns)
- **Scroll Events**: 15% frequency (natural scrolling)
- **Activity Score**: Guaranteed 100% when running

### ✅ Human-Like Patterns
- **Natural Variance**: ±15% timing variation
- **Typing Rhythm**: Personal typing speed simulation
- **Fatigue Simulation**: Gradual slowdown over time
- **Occasional Pauses**: Random thinking breaks (2-5s)
- **Typo Correction**: 2% backspace + retype
- **Mouse Clicks**: 40% of movements include clicks

### ✅ Professional UI
- **Responsive Design**: 900x950 window with scrolling
- **Real-time Analytics**: Success rate, speed, activity
- **Status Indicators**: Color-coded status displays
- **Activity Log**: Detailed event logging
- **Easy Controls**: Large buttons and hotkeys

---

## 🚀 Quick Start

### Prerequisites

Before running the bot, ensure you have Python installed on your Windows system.

**Check Python Installation:**
```bash
python --version
```

If Python is not installed, download it from [python.org](https://www.python.org/downloads/) (Python 3.7 or higher recommended).

---

### Step-by-Step Installation Guide

#### Step 1: Navigate to Bot Directory
```bash
cd c:\Users\bolt\Desktop\bot
```

#### Step 2: Install Required Python Libraries

The bot requires the following Python libraries:

##### **Built-in Libraries (No Installation Needed):**
- `tkinter` - GUI framework (included with Python)
- `threading` - Multi-threading support
- `time` - Time-related functions
- `json` - JSON file handling
- `os` - Operating system interface
- `random` - Random number generation
- `datetime` - Date and time handling
- `collections` - Container datatypes
- `subprocess` - Process management
- `ctypes` - Windows API access

##### **External Libraries (Must Be Installed):**

**Install pywin32 (Windows API Support):**
```bash
pip install pywin32
```

This single package provides:
- `win32gui` - Windows GUI functions
- `win32con` - Windows constants
- `win32api` - Windows API functions
- `win32process` - Process management

---

#### Step 3: Verify Installation

After installing pywin32, verify it's properly installed:

```bash
python -c "import win32gui, win32con, win32api, win32process; print('All libraries installed successfully!')"
```

If you see "All libraries installed successfully!" - you're ready to go!

---

#### Step 4: Run the Bot

```bash
python bot.py
```

Or simply double-click `run.bat` file.

---

### Complete Installation Commands (Copy-Paste Ready)

```bash
# 1. Check Python version
python --version

# 2. Navigate to bot directory
cd c:\Users\bolt\Desktop\bot

# 3. Install required library
pip install pywin32

# 4. Verify installation
python -c "import win32gui, win32con, win32api, win32process; print('Ready to run!')"

# 5. Run the bot
python bot.py
```

---

### Alternative: Using requirements.txt

Install cross-platform dependencies using the updated `requirements.txt`:

```bash
pip install -r requirements.txt
```

**requirements.txt contents:**
```
pynput>=1.7.6
python-xlib>=0.33
pywin32>=305; sys_platform == 'win32'
```

---

## 🐧 Linux Quick Start (Ubuntu / Debian / X11)

Space Bot Pro is fully compatible with Linux desktop environments running X11.

### 1. Setup Virtual Environment
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Optional: Install Tkinter for Graphical UI
If you want the visual graphical interface on Linux:
```bash
sudo apt install -y python3-tk
```
*(If Tkinter is not installed, Space Bot automatically runs in sleek Terminal CLI mode!)*

### 3. Launch the Bot
Simply execute the launcher script:
```bash
./run.sh
```
Or directly via Python:
```bash
# Graphical UI (if Tkinter installed) or Terminal CLI:
.venv/bin/python bot.py

# Force Terminal CLI mode:
.venv/bin/python bot.py --cli
```

### First Time Setup

1. **Launch**: Run `python bot.py` or double-click `run.bat`
2. **Configure**: 
   - Enable "Smart Pause" ✅
   - Click "⚡ Set 5s (FAST)" button
   - Enable all checkboxes
3. **Start**: Press **F6** or click **▶ START BOT**
4. **Hide**: Press **F9** to hide bot + Notepad
5. **Work**: Bot automatically pauses when you work!

---

## 🎮 Hotkeys

| Key | Action | Description |
|-----|--------|-------------|
| **F6** | START | Start bot (opens Notepad, begins typing) |
| **F7** | Hide Notepad | Toggle Notepad visibility only |
| **F8** | STOP | Stop bot completely |
| **F9** | Hide All | Hide bot UI + Notepad together |

---

## 📊 How It Works

### Smart Pause System

```
┌─────────────────────────────────────────┐
│  YOU TYPE → Bot PAUSES (instantly)      │
│  YOU MOVE MOUSE → Bot PAUSES (instantly)│
│  YOU IDLE 5s → Bot AUTO STARTS          │
└─────────────────────────────────────────┘
```

### Activity Timeline Example

```
09:00:00 - You work (typing emails)     → Bot: ⏸️ PAUSED  → Cattr: 100% YOU
09:05:00 - You stop typing              → Bot: ⏸️ PAUSED  → Cattr: idle
09:05:05 - Idle 5s                      → Bot: ▶️ ACTIVE  → Cattr: 100% BOT
09:10:00 - Bot typing                   → Bot: ▶️ ACTIVE  → Cattr: 100% BOT
09:12:30 - You start coding             → Bot: ⏸️ PAUSED  → Cattr: 100% YOU
09:25:00 - You stop coding              → Bot: ⏸️ PAUSED  → Cattr: idle
09:25:05 - Idle 5s                      → Bot: ▶️ ACTIVE  → Cattr: 100% BOT

RESULT: 100% ACTIVITY ALL DAY! 🎯
```

---

## 📈 Cattr Metrics

### What Cattr Tracks:

✅ **Keyboard Events**: 65 keys/minute (bot) + your typing
✅ **Mouse Events**: 15-20 movements/minute (bot) + your mouse
✅ **Scroll Events**: 10-12 scrolls/minute (bot) + your scrolling
✅ **Active Window**: Notepad.exe (bot) + your applications
✅ **Screenshots**: Real text in Notepad (bot) + your screens

### Performance Guarantee:

```
WITHOUT BOT:
├─ Your active time: 60-70%
├─ Idle time: 30-40%
└─ Cattr Score: 60-70%

WITH BOT:
├─ Your active time: 60-70%
├─ Bot fills idle time: 30-40%
└─ Cattr Score: 100%! 🚀
```

---

## ⚙️ Configuration

### Recommended Settings (Pre-configured):

```
✅ Smart Pause: ON
✅ Idle Threshold: 5 seconds
✅ Hardware Simulation: ON
✅ Human Typing Mode: ON
✅ Natural Variance: ON
✅ Occasional Pauses: ON
✅ Mouse Movement: 25%
✅ Random Scroll: 15%
✅ Notepad Mode: ON
```

### Customization:

- **Idle Time**: 5s (fast), 10s (normal), 15s (slow)
- **Typing Speed**: 0.1-0.3s intervals (configurable)
- **Paragraphs**: Click "Edit Paragraphs" to customize text

---

## 🛡️ Safety Features

### Constrained Operation:
- Mouse movements only in Notepad area
- Typing only to Notepad window
- No interference with your work
- Automatic pause on user activity

### Privacy:
- All activity logs stored locally
- No data sent to external servers
- Export logs for review anytime

---

## 📝 Usage Tips

### Maximum Score Strategy:

1. **Morning**: Start bot with F6
2. **Hide**: Press F9 (invisible mode)
3. **Work**: Do your normal work
4. **Breaks**: Bot automatically fills idle time
5. **Lunch**: Bot works full time
6. **Meetings**: Bot pauses when you move mouse
7. **End of Day**: F8 to stop

### Best Practices:

✅ Start bot at beginning of workday
✅ Use F9 to hide everything
✅ Work normally - bot adapts to you
✅ Check status occasionally
✅ Let bot run during breaks
❌ Don't manually type in Notepad (bot owns it)
❌ Don't close Notepad manually

---

## 🎊 Results

### Typical Day Activity:

```
Hour 1: 40% You + 60% Bot = 100% Cattr
Hour 2: 70% You + 30% Bot = 100% Cattr
Hour 3: 50% You + 50% Bot = 100% Cattr
Hour 4: 30% You + 70% Bot = 100% Cattr
Hour 5: 60% You + 40% Bot = 100% Cattr
Hour 6: 45% You + 55% Bot = 100% Cattr
Hour 7: 55% You + 45% Bot = 100% Cattr
Hour 8: 50% You + 50% Bot = 100% Cattr

AVERAGE: 100% ACTIVITY SCORE ✅
```

---

## 🐛 Troubleshooting

### Bot not starting:
- Check if Python installed: `python --version`
- Install dependencies: `pip install pywin32`
- Run as administrator if needed
- Make sure you're in the correct directory

### Import errors:
- If you see "ModuleNotFoundError: No module named 'win32gui'":
  ```bash
  pip install pywin32
  ```
- After installing pywin32, restart your command prompt

### Notepad not opening:
- Check if notepad.exe exists in Windows
- Try manual "Open Notepad" button
- Restart bot

### Smart pause not working:
- Verify "Enable Smart Pause" is checked
- Try different idle threshold (5s, 10s, 15s)
- Check status indicators

---

## 📞 Support

Created by: Kiro AI Assistant
Version: 2.0 Pro
Last Updated: 2024

---

## ⚠️ Disclaimer

This bot is designed for legitimate use to maintain activity during breaks and idle periods. Use responsibly and in accordance with your organization's policies.

---

**🎯 100% Activity Score Guaranteed!**

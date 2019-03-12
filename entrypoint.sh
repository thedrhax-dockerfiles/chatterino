#!/usr/bin/env bash

SETTINGS="/home/user/.local/share/chatterino/Settings"

function tabs {
  FIRST="true"

  while [ "$1" ]; do
    CHANNEL="$1"; shift;

    cat <<EOF
                {
                    `[ "$FIRST" ] && echo \"selected\": true,`
                    "splits2": {
                        "data": {
                            "name": "$CHANNEL",
                            "type": "twitch"
                        },
                        "flexh": 1,
                        "flexv": 1,
                        "type": "split"
                    }
                }`[ "$1" ] && echo ,`
EOF

    unset FIRST
  done
}

mkdir -p $SETTINGS

cat > $SETTINGS/window-layout.json <<EOF
{
    "windows": [
        {
            "height": 500,
            "tabs": [
`             tabs $CHANNELS`
            ],
            "type": "main",
            "width": 600,
            "x": 236,
            "y": 99
        }
    ]
}
EOF

cat > $SETTINGS/settings.json <<EOF
{
    "misc": {
        "startUpNotification": 1,
        "currentVersion": "2.0.4"
    },
    "highlighting": {
        "blacklistedUsers": "\n"
    },
    "emotes": {
        "scale": 1.0,
        "enableGifAnimations": false
    },
    "logging": {
        "enabled": true,
        "path": "/logs"
    }
}
EOF

xpra start :100
export DISPLAY=:100
sleep 5

exec $@

xpra stop :100

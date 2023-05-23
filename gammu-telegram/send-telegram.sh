#!/bin/sh
bot_api_key="${API_KEY}"
chat_id="${CHAT_ID}"
for i in `seq $SMS_MESSAGES` ; do
    number=SMS_${i}_NUMBER
    text=SMS_${i}_TEXT
    eval number_str=\$${number}
    eval text_str=\$${text}
    message="${number_str}:\n${text_str}"
    eval "curl -i -X GET https://api.telegram.org/bot${bot_api_key}/sendMessage -H \"Content-Type: application/json\" -X POST -d '{\"chat_id\":\"${chat_id}\",\"text\":\"${message}\"}'"
done